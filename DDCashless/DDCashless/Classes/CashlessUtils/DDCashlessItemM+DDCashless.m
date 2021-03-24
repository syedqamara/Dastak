//
//  DDCashlessItemM+DDCashless.m
//  DDCashless
//
//  Created by Syed Qamar Abbas on 13/02/2020.
//

#import "DDCashlessItemM+DDCashless.h"
#import "DDBasket.h"
@implementation DDCashlessItemM(DDCashless)
-(BOOL) isAllowedProductAddition {
    NSInteger count = [DDBasket.shared.currentOrder countOfItemInBasket:self];
    NSInteger stockCount = self.numberOfItemAvailable.integerValue;
    return count < stockCount;
}
@end
