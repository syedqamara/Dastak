//
//  DDMerchantMenuItemCustomizationOptionM.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 22/07/2020.
//

#import "DDMerchantMenuItemCustomizationOptionM.h"

@implementation DDMerchantMenuItemCustomizationOptionM
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"option_id":@"id"}];
}
-(BOOL)isSelected {
    if (self.is_selected != nil) {
        return self.is_selected.boolValue;
    }
    return NO;
}
-(void)toggle {
    self.is_selected = @(![self isSelected]);
}
-(NSString *)priceWithCurrency {
    return [NSString stringWithFormat:@"%@ %.2f",self.currency,self.price.doubleValue];
}
@end
