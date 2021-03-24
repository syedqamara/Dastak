//
//  DDMerchantDeliveryMenuItemM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 22/07/2020.
//

#import "DDBaseModel.h"
#import "DDMerchantMenuItemCustomizationM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantDeliveryMenuItemM : DDBaseModel
@property (strong,nonatomic) NSString <Optional> *object_id;
@property (strong,nonatomic) NSNumber <Optional> *menu_id;
@property (strong,nonatomic) NSNumber <Optional> *item_id;
@property (strong,nonatomic) NSString <Optional> *name;
@property (strong,nonatomic) NSString <Optional> *detail_description;
@property (strong,nonatomic) NSNumber <Optional> *price;
@property (strong,nonatomic) NSNumber <Optional> *original_price;
@property (strong,nonatomic) NSNumber <Optional> *item_stock_count;
@property (strong,nonatomic) NSString <Optional> *image_url;
@property (strong,nonatomic) NSArray <DDMerchantMenuItemCustomizationM, Optional> *customizations;
@property (strong,nonatomic) NSString <Optional> *menu_name;
@property (strong,nonatomic) NSString <Optional> *currency;
@property (strong,nonatomic) NSArray <DDMerchantMenuItemCustomizationOptionM, Optional> *selected_options;

-(BOOL)haveMenuTitle;
-(BOOL)haveCustomization;
-(NSString *)allSelectedOptions;
-(NSString *)priceWithCurrency;
-(NSMutableAttributedString *)orignalPriceWithCurrency;
-(NSInteger)stockCount;
-(BOOL)isEqual:(DDMerchantDeliveryMenuItemM *)object;
-(CGFloat)priceOfAllOption;
-(CGFloat)priceWithAllOption;
-(NSString *)priceOfAllOptionWithCurrency;
-(NSString *)priceWithAllOptionWithCurrency;
-(void)setUniqueObjectID;
-(DDMerchantDeliveryMenuItemM *)copyForItem:(DDMerchantDeliveryMenuItemM *)item;
-(void)insertAdon:(DDMerchantMenuItemCustomizationOptionM *)adon inCust:(DDMerchantMenuItemCustomizationM *)cust;
@end

NS_ASSUME_NONNULL_END
