//
//  DDOrderBasketM.h
//  The Entertainer
//
//  Created by mac on 4/13/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDModels.h"

@interface DDOrderBasketM : JSONModel
//total_items
@property (strong, nonatomic) DDDeliveryRegionM<Optional> * _Nullable selected_region;
@property (strong, nonatomic) NSNumber<Optional> *order_id;
@property (strong, nonatomic) NSNumber<Optional> *edit_order_date;
@property (strong, nonatomic) NSNumber<Optional> *edit_allowed_time;
@property (strong, nonatomic) NSDate<Optional> *purchased_order_date;
@property (strong, nonatomic) DDCashlessMerchantM<Optional> * merchant;
@property (strong, nonatomic) DDOutletM<Optional> * outlet;
@property (strong, nonatomic) NSString<Ignore> *phoneNumber;
@property (strong, nonatomic) NSString<Ignore> *currentUserName;
@property (strong, nonatomic) NSMutableArray<DDCashlessItemM,Optional> *addedProducts;
@property (strong, nonatomic) NSString<Optional> *currency;
@property (strong, nonatomic) NSNumber<Optional> *isTakeawayOrder;
//Check Methods
-(BOOL)isAddedToBasket:(DDCashlessItemM *_Nullable)product;
-(BOOL)isVoucherAppliedSuccessfullyOnItem:(DDCashlessItemM *_Nullable)item;
-(BOOL)haveAnySubItemInMainItem:(DDCashlessItemM *)item;
-(BOOL)haveMinimumOrderInBasket;
-(BOOL)havePhoneNumber;

//Price Methods
-(float)allPriceWithUpgradesAndCounts;
-(float)discountPriceForItem:(DDCashlessItemM *_Nullable)item;
-(float)getItemPriceAfterValidateVoucherDiscount:(DDCashlessItemM *)item;
-(float)overAllSavingAmount;
-(float)allPriceWithUpgradesAndCountsAfterDiscount;

//Insert/Update/Delete Methods
-(void) removeSelectedCustomizedProductsAgainstProduct:(DDCashlessItemM *) product;
-(void) removeSingleProductAgainstLocalStoredId:(DDCashlessItemM *) product;
-(void)forceRemoveItemFromBasket:(DDCashlessItemM *)product;
-(void)removeItemFromBasket:(DDCashlessItemM *_Nullable)product;
-(void)addItemToBasket:(DDCashlessItemM *_Nullable)product;
-(void)removeAllItemsOfId:(NSString *)itemId;

-(void)setSpecialMessage:(NSString * _Nonnull)message;
-(void) resetEditOrderDate;
-(void)startTimer;
//Get Values
-(NSString * _Nonnull)getSpecialMessage;
-(DDCashlessItemM * _Nullable )getBasketItemFromOrignalItem:(DDCashlessItemM *_Nullable)product;
-(NSInteger)allItemCount;
-(NSInteger)countOfItemInBasket:(DDCashlessItemM *_Nullable)product;
-(NSInteger)count;
-(DDCashlessItemM *_Nullable)itemAtIndex:(NSInteger)index;
-(NSString * _Nullable )discountNameFor:(DDCashlessItemM *_Nullable)item;
-(NSMutableArray <DDCashlessItemM *>*)getItemsWithItemId:(NSString *)itemId;
-(NSMutableArray *) getSelectedCustomizedProductsAgainstProduct:(DDCashlessItemM *) item;

//Basket Content Setting Methods
-(void)resetBasket;
+(void)removeBasket;
- (void)saveAsJson;
-(void)removeNonAppliedVoucher;
-(void)startTimer;
-(NSInteger)orderID;
+ (DDOrderBasketM *)loadLocalOrder;
@end
