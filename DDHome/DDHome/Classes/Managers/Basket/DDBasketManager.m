//
//  DDBasketManager.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 21/08/2020.
//

#import "DDBasketManager.h"
#import "DDStorage.h"
#import "DDLocations.h"
#import "DDAuth.h"
#define BASKET_JSON_FILE_NAME @"basket"

@interface DDBasketManager () {
    BOOL isAllowedToEditBasket;
}
@property (strong, nonatomic) DDBasketM *basket;
@end

@implementation DDBasketManager
static DDBasketManager *_sharedObject;
+(DDBasketManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [DDBasketManager.alloc init];
    });
    return _sharedObject;
}
-(instancetype)init {
    self = [super init];
    [self loadSavedBasket];
    return self;
}
-(void)loadSavedBasket {
    self.basket = [[DDJSONManager loadJSON:BASKET_JSON_FILE_NAME forClass:self.class isEncrypted:YES] decodeTo:DDBasketM.class];
    if (self.basket.items == nil) {
        if (self.basket == nil) {
            self.basket = [DDBasketM.alloc init];
        }
        self.basket.items = [NSMutableArray<DDMerchantDeliveryMenuItemM, Optional> new];
    }
}
-(void)saveChanges {
    [DDJSONManager saveJSON:self.basket.toDictionary withFileName:BASKET_JSON_FILE_NAME withExtension:@"json" isEncrypted:YES];
}
-(void)resetBasket {
    isAllowedToEditBasket = YES;
    [DDJSONManager saveJSON:@{} withFileName:BASKET_JSON_FILE_NAME withExtension:@"json" isEncrypted:YES];
    [self loadSavedBasket];
}
-(void)resetBasketWithOutMerchant {
    isAllowedToEditBasket = YES;
    DDMerchantM *merchant = self.basket.merchant;
    [DDJSONManager saveJSON:@{} withFileName:BASKET_JSON_FILE_NAME withExtension:@"json" isEncrypted:YES];
    [self loadSavedBasket];
    self.basket.merchant = merchant;
}
-(void)addItem:(DDMerchantDeliveryMenuItemM *)item onCompletion:(BasketModificationCallback)completion {
    if (isAllowedToEditBasket) {
        if ([self countOfItem:item] < item.stockCount) {
            [self.basket.items addObject:item.copy];
        }
        [self saveChanges];
        if (completion != nil) {
            completion(item, nil, isAllowedToEditBasket);
        }
    }
    
}
-(void)removeItem:(DDMerchantDeliveryMenuItemM *)item shouldRemoveAll:(BOOL)shouldRemoveAll onCompletion:(BasketModificationCallback)completion {
    if (isAllowedToEditBasket) {
        if (shouldRemoveAll) {
            [self removeItemCompletely:item onCompletion:completion];
        }else {
            DDMerchantDeliveryMenuItemM *itemToRemove;
            if (item.haveCustomization) {
                for (DDMerchantDeliveryMenuItemM *itm in self.basket.items) {
                    if ([itm.object_id isEqualToString:item.object_id]) {
                        itemToRemove = itm;
                        break;
                    }
                }
            }else {
                for (DDMerchantDeliveryMenuItemM *itm in self.basket.items) {
                    if ([itm.item_id.stringValue isEqualToString:item.item_id.stringValue]) {
                        itemToRemove = itm;
                        break;
                    }
                }
            }
            if (itemToRemove != nil) {
                NSInteger index = [self.basket.items indexOfObject:itemToRemove];
                [self.basket.items removeObjectAtIndex:index];
            }
            [self saveChanges];
            if (completion != nil) {
                completion(item, nil, isAllowedToEditBasket);
            }
        }
        
    }
}
-(void)removeItemCompletely:(DDMerchantDeliveryMenuItemM *)item onCompletion:(BasketModificationCallback)completion {
    if (isAllowedToEditBasket) {
        NSMutableArray *arr = [NSMutableArray new];
        for (DDMerchantDeliveryMenuItemM *itm in self.basket.items) {
            if (![itm isEqual:item]) {
                [arr addObject:itm];
            }
        }
        self.basket.items = arr.mutableCopy;
        [self saveChanges];
        if (completion != nil) {
            completion(item, nil, YES);
        }
    }
}
-(NSArray *)itemsInBasketOfItem:(DDMerchantDeliveryMenuItemM *)item {
    NSMutableArray *items = [NSMutableArray new];
    for (DDMerchantDeliveryMenuItemM *itm in self.basket.items) {
        if ([item isEqual:itm]) {
            [items addObject:itm];
        }
    }
    return items;
}
-(NSInteger)countOfItem:(DDMerchantDeliveryMenuItemM *)item {
    NSInteger countOfItems = 0;
    for (DDMerchantDeliveryMenuItemM *itm in self.basket.items) {
        if ([item isEqual:itm]) {
            countOfItems++;
        }
    }
    return countOfItems;
}
-(CGFloat)priceWithoutCustomisation:(DDMerchantDeliveryMenuItemM *)item {
    CGFloat price = 0;
    for (DDMerchantDeliveryMenuItemM *item in self.basket.items) {
        if ([item isEqual:item]) {
            price += item.price.floatValue;
        }
    }
    return price;
}

-(CGFloat)priceWithCustomisation:(DDMerchantDeliveryMenuItemM *)item {
    CGFloat price = 0;
    for (DDMerchantDeliveryMenuItemM *item in self.basket.items) {
        if ([item isEqual:item]) {
            price += item.priceWithAllOption;
        }
    }
    return price;
}
-(void)setMerchant:(DDMerchantM *)merchant {
    if (self.basket == nil) {
        self.basket = [DDBasketM new];
    }
    if (self.basket.merchant == nil || self.basket.merchant.merchant_id.integerValue == merchant.merchant_id.integerValue) {
        isAllowedToEditBasket = YES;
        NSMutableArray *items = [NSMutableArray new];
        for (DDMerchantDeliveryMenuItemM *addedItem in self.basket.items) {
            for (DDMerchantDeliveryMenuM *menu in merchant.delivery_menu) {
                for (DDMerchantDeliveryMenuItemM *item in menu.items) {
                    if ([addedItem isEqual:item]) {
                        [items addObject:[item copyForItem:addedItem]];
                    }
                }
            }
        }
        self.basket.merchant = merchant;
        self.basket.items = items;
    }else {
        isAllowedToEditBasket = NO;
    }
}

-(BOOL)basketIsAllowedToEdit {
    return isAllowedToEditBasket;
}
-(NSInteger)count {
    return self.basket.items.count;
}
-(CGFloat)totalPrice {
    CGFloat price = 0.0;
    for (DDMerchantDeliveryMenuItemM *item in self.basket.items) {
        price += item.priceWithAllOption;
    }
    return price;
}
-(void)syncAddressAndCurrentUser {
    self.basket.address = DDLocationsManager.shared.selectedCashlessDeliveryLocation.copy;
    self.basket.user = DDUserManager.shared.currentUser.copy;
}
-(NSDictionary *)basketCartParams {
    self.basket.payment_types = DDAuthManager.shared.config.data.delivery_payment_method;
    return self.basket.toDictionary;
}
@end
