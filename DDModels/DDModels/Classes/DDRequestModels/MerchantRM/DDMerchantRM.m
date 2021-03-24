//
//  DDMerchantRM.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/08/2020.
//

#import "DDMerchantRM.h"

@implementation DDMerchantRM
-(BOOL)isValidMerchantRequest {
    if (self.category_id.integerValue > 0 && self.merchant_id.integerValue > 0 && self.outlet_id.integerValue > 0) {
        return YES;
    }
    return NO;
}
@end
