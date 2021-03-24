//
//  DDMerchantM.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 19/07/2020.
//

#import "DDMerchantM.h"

@implementation DDMerchantM
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"merchant_id":@"id"}];
}
-(NSString *)minOrder {
    if (self.min_delivery_amount.integerValue > 0) {
        return [NSString stringWithFormat:@"%@%@",self.currency,self.min_delivery_amount.stringValue];
    }
    return @"Free".localized;
}
-(NSString *)deliveryFee {
    if (self.delivery_fee.integerValue > 0) {
        return [NSString stringWithFormat:@"%@%@",self.currency,self.delivery_fee.stringValue];
    }
    return @"Free".localized;
}
-(BOOL)isOpen {
    if (self.is_open != nil) {
        return self.is_open.boolValue;
    }
    return NO;
}
-(UIColor *)onlineColor {
    if (self.isOpen) {
        return @"06d6a0".colorValue;
    }
    return @"fd4f57".colorValue;
}
-(NSString *)onlineTitle {
    if (self.isOpen) {
        return @"Open".localized;
    }
    return @"Closed".localized;
}
-(BOOL)isFav {
    return self.is_favourite.boolValue;
}
-(BOOL)isInsideRegion {
    return self.is_within_region.boolValue;
}
-(NSString *)unableToPlaceOrderError {
    if (![self isOpen]) {
        return @"Merchant is not available right now to recieve order".localized;
    }
    if (![self isInsideRegion]) {
        return @"Cannot deliver in this region".localized;
    }
    return @"";
}
@end
