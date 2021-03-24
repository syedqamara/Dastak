//
//  CashlessCart.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 27/03/2020.
//

#import "DDCashlessCart.h"

@implementation DDCashlessCartDTS

@end
@implementation DDCashlessCart

-(NSDictionary *)toDictionary {
//    NSDictionary *param = self.default_param;
//    NSDictionary *basket = self.basket;
//    self.basket = nil;
//    self.default_param = nil;
//    NSDictionary *final = [super toDictionary];
//    self.default_param = param;
//    self.basket = basket;
    return [self decryptedCart];
}

-(NSDictionary *)decryptedCart {
    NSString *param = self.__default_param;
    NSString *basket = self.__basket;
    self.__basket = nil;
    self.__default_param = nil;
    NSDictionary *final = [super toDictionary];
    self.__default_param = param;
    self.__basket = basket;
    return final;
}
@end

