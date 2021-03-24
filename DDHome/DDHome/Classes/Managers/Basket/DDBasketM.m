//
//  DDBasketM.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 21/08/2020.
//

#import "DDBasketM.h"

@implementation DDBasketM
-(NSDictionary *)toDictionary {
    self.api_param = self.merchant.api_param;
    DDMerchantM *temp = self.merchant;
    self.merchant = nil;
    NSDictionary *dict = [super toDictionary];
    self.merchant = temp;
    return dict;
}
@end
