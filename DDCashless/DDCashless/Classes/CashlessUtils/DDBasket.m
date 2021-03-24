//
//  DDBasket.m
//  The Entertainer
//
//  Created by mac on 4/9/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import "DDBasket.h"
#import "DDEditOrderTimer.h"
#import "DDRequestOrderM.h"
#import "DDEncryption.h"
#import "DDOrderTimer.h"
@interface DDBasket()

@end
@implementation DDBasket
static DDBasket *basket;
+ (DDBasket *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        basket = [[DDBasket alloc] init];
        basket.currentOrder = [[DDOrderBasketM alloc]init];
        [basket resetBasketForceReset:NO];
    });
    return basket;
}

-(void) checkEditOrderAndResetBasket{
    if (![DDBasket.shared isOrderInEditState] && self.currentOrder.order_id != nil){
        self.currentOrder.purchased_order_date = nil;
        [self resetBasketForceReset:YES];
    }
}
-(NSString *)merchantAndOutletName {
    NSString *merchantName = self.currentOrder.merchant.name;
    NSString *outletName = self.currentOrder.outlet.name;
    if (merchantName != nil && outletName != nil) {
        return [NSString stringWithFormat:@"%@ & %@",merchantName, outletName];
    }
    else if (merchantName != nil) {
        return merchantName;
    }
    else if (outletName != nil) {
        return outletName;
    }
    return @"";
}
-(void)resetBasketForceReset:(BOOL)shouldForceReset {
    self.currentOrder.addedProducts = [NSMutableArray new];
    if (shouldForceReset) {
        [DDOrderBasketM removeBasket];
    }
}
-(void)checkAndInsertPrePopulatedProductWithMerchant:(DDCashlessMerchantM *)merchant {
    self.currentOrder = nil;
    self.currentOrder = [[DDOrderBasketM alloc]init];
    [self resetBasketForceReset:YES];
//    self.orderHisotyItem = nil;
}
-(void)setMerchant:(DDCashlessMerchantM *)merchant andAllProducts:(NSMutableArray <DDCashlessItemM *>*)allProducts {
    NSMutableArray <DDCashlessItemM *> *merchantProducts = [merchant getAllItems];
    [self.currentOrder.addedProducts removeAllObjects];
    for (DDCashlessItemM *selectedItem in allProducts) {
        for (DDCashlessItemM *item in merchantProducts) {
            if ([item.productId isEqualToString:selectedItem.productId]) {
                DDCashlessItemM *newItem = [item mutableCopy];
                newItem.isIncreaseEnabled = @(1);
                NSMutableArray <DDCashlessItemCustomizationOptionItemM *> *adonarray = (NSMutableArray <DDCashlessItemCustomizationOptionItemM *> *)[NSMutableArray new];

                for (DDCashlessItemCustomizationOptionItemM *selectedAdon in selectedItem.selectedOptions) {
                    DDCashlessItemCustomizationOptionItemM *adon = [item optionWithSectionId:selectedAdon.sectionId andSectionOptionId:selectedAdon.sectionOptionId andItemId:selectedAdon.item_id];
                    if (adon != nil) {
                        [adonarray addObject:adon];
                    }
                }
                newItem.selectedOptions = adonarray;
                newItem.numberOfItemsAdded = @(0);
                [self.currentOrder addItemToBasket:newItem];
                break;
            }
        }
    }
    //    self.currentOrder.addedProducts = [self.orderHisotyItem.addedProducts mutableCopy];
    self.currentOrder.merchant = merchant;
    self.currentOrder.edit_allowed_time = @30;//merchant.edit_order_idle_timer_value;
    self.currentOrder.saveAsJson;
}
-(void)addSelectedOutlet:(DDOutletM *)outlet {
    self.currentOrder.outlet = outlet;
}

-(BOOL)loadSavedBasket {

   
    self.currentOrder = [DDOrderBasketM loadLocalOrder];
    BOOL isLoaded = !(self.currentOrder == nil);
    if (!isLoaded) {
        self.currentOrder = [DDOrderBasketM.alloc init];
        [self resetBasketForceReset:YES];
    }else {
        NSMutableArray <DDCashlessItemM *>*products = [self.currentOrder.addedProducts mutableCopy];
        if (products.count > 0) {
            [self.currentOrder startTimer];
//            [self setMerchant:self.currentOrder.merchant andAllProducts:products];
        }else {
            [self resetBasketForceReset:YES];
        }

    }

    return isLoaded;
}

- (BOOL)isLocationEnabledAndShowAlert
{
//    if (DDBasket.shared.selectedUserDeliveryLocation == nil) {
//        [[DDAlertUtil sharedInstance] showDeliverySingleButtonAlert:nil message:NSLocalizedString(@"Please select your delivery location first.", nil) yesButtonTitle:NSLocalizedString(@"OK", nil) img:@"icLocation" completion:^(bool isSuccess) {
//        }];
//        return NO;
//    }

    return YES;
}


+(BOOL) isBasketEmpty{
    return DDBasket.shared.currentOrder.count == 0;
}

+(void) resetEditIdleOrderTimerAndMarkOrderIdNil:(NSNumber *) orderId{
    DDBasket.shared.currentOrder.order_id = orderId;
    [self resetEditIdleOrderTimerOnly];
}

+(void) resetEditIdleOrderTimerOnly{
    DDBasket.shared.currentOrder.edit_order_date = nil;
    [[DDEditOrderTimer shared] stopOrReset];
    [DDBasket.shared.currentOrder saveAsJson];
}

-(BOOL) isOrderInEditState{
    if (self.currentOrder.edit_order_date){
        return YES;
    }
    return NO;
}
-(DDCashlessCart *)getBasketRequestMForWeb {
    DDCashlessCart *cart = [DDCashlessCart.alloc init];
    DDRequestOrderM *order = [DDRequestOrderM.alloc initWithOrder:DDBasket.shared.currentOrder];
    DDCashlessCartDTS *__p = [DDCashlessCartDTS.alloc initWithDictionary:DDCCommonParamManager.shared.default_api_parameters.toDictionary error:nil];
    __p.__t = DDCCommonParamManager.shared.default_api_parameters.session_token;
    __p.company = DDCCommonParamManager.shared.default_api_parameters.company;
    __p.__platform = DDCCommonParamManager.shared.default_api_parameters.__platform;
    __p.app_version = DDCCommonParamManager.shared.default_api_parameters.app_version;
    __p.custom_parameters = DDCCommonParamManager.shared.default_api_parameters.toDictionary.mutableCopy;
    
    cart.__p_decrypted = __p.toDictionary;
    cart.__dts_decrypted = order.toDictionary;
    [self encryptedCashlessCart:cart];
    
    return cart;
}
-(void)encryptedCashlessCart:(DDCashlessCart *)cart {
    NSString *encryptedP = [DDEncryptionManager.shared encryptDictionaryIntoString:cart.__p_decrypted.mutableCopy];
    NSString *encryptedOrder = [DDEncryptionManager.shared encryptDictionaryIntoString:cart.__dts_decrypted.mutableCopy];
    
    cart.__p = encryptedP;
    cart.__dts = encryptedOrder;
}
-(NSString *)cashlessType {
    if(self.currentOrder.isTakeawayOrder.boolValue) {
        return @"Cashless Delivery";
    }
    return @"Cashless Takeaway";
}
-(void)loadTimerWithTime:(NSTimeInterval)time shouldClearBasketOnCompletion:(BOOL)shouldClearBasket withCompletion:(MainTimerBlock _Nullable)completion {
    [DDOrderTimer.shared startTimerForTime:time shouldClearBasketOnCompletion:shouldClearBasket completion:^(NSTimeInterval totalTime, NSTimeInterval remainingTime) {
        if (completion != nil) {
            completion(totalTime, remainingTime, remainingTime <= 0);
        }
        //NSLog(@"Time = %f\n",(totalTime-remainingTime));
        if (remainingTime <= 0) {
        }
    }];
}
@end
