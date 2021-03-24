//
//  DDBasketManager.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 21/08/2020.
//

#import <Foundation/Foundation.h>
#import "DDBasketM.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ _Nullable BasketModificationCallback)(DDMerchantDeliveryMenuItemM * _Nullable item, NSString * _Nullable info, BOOL isCompleted);

@interface DDBasketManager : NSObject
+(DDBasketManager *)shared;
-(BOOL)basketIsAllowedToEdit;
-(void)addItem:(DDMerchantDeliveryMenuItemM *)item onCompletion:(BasketModificationCallback)completion;
-(void)resetBasket;
-(void)resetBasketWithOutMerchant;
-(void)saveChanges;
-(void)loadSavedBasket;
-(void)removeItem:(DDMerchantDeliveryMenuItemM *)item shouldRemoveAll:(BOOL)shouldRemoveAll onCompletion:(BasketModificationCallback)completion;
-(NSInteger)countOfItem:(DDMerchantDeliveryMenuItemM *)item;
-(NSArray *)itemsInBasketOfItem:(DDMerchantDeliveryMenuItemM *)item;
-(CGFloat)priceWithoutCustomisation:(DDMerchantDeliveryMenuItemM *)item;
-(void)setMerchant:(DDMerchantM *)merchant;
-(void)syncAddressAndCurrentUser;
-(NSInteger)count;
-(CGFloat)totalPrice;
-(NSDictionary *)basketCartParams;
@end

NS_ASSUME_NONNULL_END
