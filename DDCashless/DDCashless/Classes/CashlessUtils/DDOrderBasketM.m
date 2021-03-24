//
//  DDOrderBasketM.m
//  The Entertainer
//
//  Created by mac on 4/13/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//
#import "DDCashlessManager.h"
#import "DDOrderBasketM.h"
#import "DDEditOrderTimer.h"
#import "DDBasket.h"
#import "DDCashlessItemM+DDCashless.h"
#import "DDCashlessMerchantM+DDCashless.h"
#import "DDJSONManager.h"
#import "DDAuth.h"
@interface DDOrderBasketM(){
    NSString *specialMessageObject;
    DDCashlessMerchantM *currentMerchant;
    NSNumber *o;
}

@end
@implementation DDOrderBasketM

-(void)setMerchant:(DDCashlessMerchantM<Optional> *)merchant {
    currentMerchant = merchant;
    self.edit_allowed_time = merchant.edit_order_idle_timer_value;
}
-(DDCashlessMerchantM<Optional> *)merchant {
    return currentMerchant;
}

-(void)resetBasket {
    [self.addedProducts removeAllObjects];
    
    if (![DDBasket.shared isOrderInEditState]){
        [self resetOrderEditIdleState];
    }
    
    
    
}
-(void)setOrder_id:(NSNumber<Optional> *)order_id {
    o = order_id;
}
-(NSNumber<Optional> *)order_id {
    return o;
}
-(NSInteger)orderID {
    if (self.order_id != nil) {
        return self.order_id.integerValue;
    }
    return 0;
}
-(void) resetOrderEditIdleState{
    self.order_id = nil;
    self.edit_order_date = nil;
    self.purchased_order_date = nil;
}

-(void) resetEditOrderDate{
    if ([DDBasket.shared isOrderInEditState] && self.purchased_order_date != nil){
        self.edit_order_date = [NSNumber numberWithDouble:[NSDate date].timeIntervalSince1970];
        [self saveAsJson];
        [self startTimer];
    }
}
-(NSMutableDictionary *)orderIdParam {
    NSNumber *orderID = self.order_id;
    if (orderID == nil) {
        orderID = @(0);
    }
    return [@{@"order_id": orderID} mutableCopy];
}
-(void)orderIsCancelled {
    DDOrderStatusRequestM *req = [DDOrderStatusRequestM new];
    req.order_id = self.order_id;
    [DDCashlessManager.shared cancelOrder:req withCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {}];
//    [DDOrderStatusAPIModel orderIsCancelled:NO withParams:[self orderIdParam] completion:^(BOOL success, NSError *error) {}];
}
-(void)startTimer {
    if (self.order_id != nil && [DDBasket.shared isOrderInEditState]) {
        double timeDif = NSDate.date.timeIntervalSince1970 - self.edit_order_date.doubleValue;
        if (timeDif < self.edit_allowed_time.doubleValue) {
            [DDEditOrderTimer.shared stopOrReset];
            [DDEditOrderTimer.shared startTimerForTime:self.edit_allowed_time.doubleValue - timeDif shouldClearBasketOnCompletion:YES completion:^(NSTimeInterval totalTime, NSTimeInterval remainingTime) {
                if (remainingTime <= 0) {
                    [self orderIsCancelled];
                }
            }];
        }else {
            [DDEditOrderTimer.shared stopOrReset];
            [self orderIsCancelled];
            //Invoke Order Cancelled Notification
//            [NSNotificationCenter.defaultCenter postNotificationName:DDEditOrderTimerIsCompleted object:nil];
            [DDBasket.shared resetBasketForceReset:YES];
        }
    }
}
-(float)overAllSavingAmount {
    return [self allPriceWithUpgradesAndCounts] - [self allPriceWithUpgradesAndCountsAfterDiscount];
}
-(float)allPriceWithUpgradesAndCountsAfterDiscount {
    return [self allPriceWithUpgradesAndCounts];
}
-(float)allPriceWithUpgradesAndCounts {
    float price = 0.0;
    for (DDCashlessItemM *item in self.addedProducts) {
        price += [item totalPriceWithAdonsUpgradesAndCount];
    }
    return price;
}
-(void)addItemToBasket:(DDCashlessItemM *)product {
    if (![product isAllowedProductAddition]) {
        return;
    }
    DDCashlessItemM *newProduct = product;
 
    for (DDCashlessItemM *pro in self.addedProducts) {
        if (pro.productId == product.productId) {
            NSInteger alreadyAddedProductsCount = [self countOfItemInBasket:product];
                newProduct.isIncreaseEnabled = [NSNumber numberWithBool:YES];
                newProduct.localStoredProductId = [NSNumber numberWithInteger:(alreadyAddedProductsCount + 1)];
            newProduct.localStoredTimeId = @(NSDate.date.timeIntervalSince1970);
                [self.addedProducts addObject:newProduct];
                [self saveAsJson];
                return;
        }
    }
    
    if (newProduct.numberOfItemAvailable.integerValue > 0){
        newProduct.isIncreaseEnabled = [NSNumber numberWithBool:YES];
        newProduct.numberOfItemsAdded = [NSNumber numberWithInteger:1];
        newProduct.localStoredProductId = [NSNumber numberWithInteger:1];
        newProduct.localStoredTimeId = @(NSDate.date.timeIntervalSince1970);
        [self.addedProducts addObject:newProduct];
        [self saveAsJson];
    }
}

-(void)removeAllItemsOfId:(NSString *)itemId {
    
    NSMutableArray <DDCashlessItemM *>*indexes = [NSMutableArray new];
    for (DDCashlessItemM *item in self.addedProducts) {
        if (item.productId == itemId) {
            [indexes addObject:item];
        }
    }
    for (DDCashlessItemM *indexItem in indexes) {
        [self.addedProducts removeObject:indexItem];
    }
}
- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}
-(void)forceRemoveItemFromBasket:(DDCashlessItemM *)product {
    [self resetEditOrderDate];
    [self.addedProducts removeObject:product];
    if (_addedProducts == nil) {
        _addedProducts = [NSMutableArray new];
    }
    [self saveAsJson];
}
-(NSMutableArray <DDCashlessItemM *>*)getItemsWithItemId:(NSString *)itemId {
    NSMutableArray <DDCashlessItemM *>* filterItems = [NSMutableArray new];
    for (DDCashlessItemM *item in self.addedProducts) {
        if (item.productId == itemId) {
            [filterItems addObject:item];
        }
    }
    return filterItems;
}
-(void)removeItemFromBasket:(DDCashlessItemM *)product {
    [self resetEditOrderDate];
    NSInteger lastAddedProductId = 0;
    DDCashlessItemM *itemToRemove;
    NSInteger index = 0;
    NSInteger selectedIndex = -1;
    for (DDCashlessItemM *pro in self.addedProducts) {
        NSInteger productId = pro.localStoredProductId.integerValue;
        if (pro.productId == product.productId && productId > lastAddedProductId) {
            lastAddedProductId = productId;
            itemToRemove = pro;
            selectedIndex = index;
        }
        index++;
    }
    
    if (itemToRemove){
        if (selectedIndex != -1) {
            [self.addedProducts removeObjectAtIndex:selectedIndex];
            [self saveAsJson];
        }
    }
    
    if ([self countOfItemInBasket:product] == 0){
        product.isIncreaseEnabled = @(0);
    }
    
//    if (self.addedProducts.count == 0) {
//
//    }
    
}
-(NSInteger)countOfItemInBasket:(DDCashlessItemM *)product {
    NSInteger count = 0;
    for (DDCashlessItemM *pro in self.addedProducts) {
        if (pro.productId == product.productId) {
            count += 1;
        }
    }
    return count;
}

-(NSInteger)count {
    return self.addedProducts.count;
}
-(DDCashlessItemM *)itemAtIndex:(NSInteger)index {
    return [self.addedProducts objectAtIndex:index];
}
-(NSInteger)allItemCount {
//    NSInteger count = 0;
//    for (DDOutletItems *pro in self.addedProducts) {
//        count += pro.numberOfItemsAdded.integerValue;
//    }
    return self.addedProducts.count;
}
-(BOOL)isAddedToBasket:(DDCashlessItemM *)product {
    for (DDCashlessItemM *pro in self.addedProducts) {
        if (pro.productId == product.productId) {
            return YES;
        }
    }
    return NO;
}
-(DDCashlessItemM * _Nullable )getBasketItemFromOrignalItem:(DDCashlessItemM *)product {
    for (DDCashlessItemM *pro in self.addedProducts) {
        if (pro.productId == product.productId) {
            return pro;
        }
    }
    return nil;
}

-(BOOL)haveAnySubItemInMainItem:(DDCashlessItemM *)item {
    BOOL haveAdons = NO;
    if (item.selectedOptions.count > 0) {
        haveAdons = YES;
    }
    return haveAdons;
}
-(BOOL)containsVoucherIDInAllProducts:(NSString *)voucherId {
    for (DDCashlessItemM *item in _addedProducts) {
        if ([item.voucherId.stringValue isEqualToString:voucherId]) {
            return YES;
        }
    }
    return NO;
}
-(NSString * _Nonnull)getSpecialMessage {
    return specialMessageObject;
}
-(void)setSpecialMessage:(NSString * _Nonnull)message {
    specialMessageObject = message;
    [self saveAsJson];
}
-(BOOL)haveMinimumOrderInBasket {
    float minimumOrder = self.merchant.minimum_order_amount.floatValue;
    float currentAmount = [self allPriceWithUpgradesAndCounts];
    return currentAmount >= minimumOrder;
}
-(BOOL)havePhoneNumber {
    return _phoneNumber != nil && _phoneNumber.length > 0;
}

- (void)saveAsJson {
    [DDJSONManager saveJSON:self.toDictionary withFileName:DDUserManager.shared.currentUser.user_id.stringValue withExtension:@"json" isEncrypted:NO];
}
+ (DDOrderBasketM *)loadLocalOrder {
    //Load From Storage
    NSError *error;
    NSDictionary *dict = [DDJSONManager loadJSON:DDUserManager.shared.currentUser.user_id.stringValue forClass:self.class isEncrypted:NO];
    DDOrderBasketM *order = [DDOrderBasketM.alloc initWithDictionary:dict error:&error];
    return order;
}
+(void)removeBasket {
    //Remove From Storage
    if (DDUserManager.shared.currentUser == nil || DDUserManager.shared.currentUser.user_id == 0){
        return;
    }

    [[DDBasket shared].currentOrder resetBasket];
    [DDJSONManager removeJSON:DDUserManager.shared.currentUser.user_id.stringValue andExtension:@"json" forClass:self.class];
}
//+ (DDOrderBasketM *)loadLocalOrder {
    //Load From Storage
//    [DDOrderBasketM removeBasket];
//    return nil;
    // Build the path...
//    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString* fileName = [NSString stringWithFormat:@"%d.mp4", [[DDUserManager.sharedManager currentUser] userId]];
//    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
//    
//    // The main act...
//    NSData *data = [NSData dataWithContentsOfFile:fileAtPath];
//    NSData *objectData = [DDProcessUtil.sharedInstance decryptDeliveryData:data];
//    NSError *jsonError;
////    NSString *jsonStr = [[NSString alloc] initWithData: encoding:NSUTF8StringEncoding];
//    if (objectData != nil) {
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
//                                                             options:kNilOptions
//                                                               error:&jsonError];
//        if (jsonError == nil) {
//            DDOrderBasketM *order = [DDOrderBasketM.alloc initWithDictionary:json error:&jsonError];
//            return order;
//        }
//    }
//    return nil;
//}


-(NSMutableArray *) getSelectedCustomizedProductsAgainstProduct:(DDCashlessItemM *) item{
    NSMutableArray *customizableProducts = [[NSMutableArray alloc] init];
    for (DDCashlessItemM *itemTemp in self.addedProducts){
        if (itemTemp.productId == item.productId && itemTemp.is_customisable && [itemTemp.is_customisable boolValue]){
            [customizableProducts addObject:itemTemp];
        }
    }
    return customizableProducts;
}

-(void) removeSelectedCustomizedProductsAgainstProduct:(DDCashlessItemM *) product{
    [self resetEditOrderDate];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (DDCashlessItemM *itemTemp in self.addedProducts){
        if (itemTemp.productId == product.productId && itemTemp.is_customisable && [itemTemp.is_customisable boolValue]){
            [dataArray addObject:itemTemp];
        }
    }
    
    [self.addedProducts removeObjectsInArray:[dataArray copy]];
}

-(void) removeSingleProductAgainstLocalStoredId:(DDCashlessItemM *) product{
    [self resetEditOrderDate];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (DDCashlessItemM *itemTemp in self.addedProducts){
        if ([itemTemp.localStoredTimeId doubleValue] == [product.localStoredTimeId doubleValue] && itemTemp.is_customisable && [itemTemp.is_customisable boolValue]){
            [dataArray addObject:itemTemp];
        }
    }
    
    [self.addedProducts removeObjectsInArray:[dataArray copy]];
}

@end
