//
//  DDMerchantM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 19/07/2020.
//

#import "DDBaseModel.h"
#import "DDMerchantRatingM.h"
#import "DDJSONModelProtocols.h"
#import "DDMerchantDeliveryMenuM.h"
#import "DDHomeSectionAttributeM.h"
#import "DDMerchantInfoSectionM.h"
#import "DDMerchantInfoSectionListM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantM : DDBaseModel
@property (strong,nonatomic) NSNumber <Optional> *merchant_id;
@property (strong,nonatomic) NSNumber <Optional> *is_favourite;
@property (strong,nonatomic) NSNumber <Optional> *is_open;
@property (strong,nonatomic) NSNumber <Optional> *is_within_region;
@property (strong,nonatomic) NSString <Optional> *online_time;
@property (strong,nonatomic) NSString <Optional> *name;
@property (strong,nonatomic) NSString <Optional> *delivery_time;
@property (strong,nonatomic) NSNumber <Optional> *min_delivery_amount;
@property (strong,nonatomic) NSNumber <Optional> *delivery_fee;
@property (strong,nonatomic) NSString <Optional> *lattitude;
@property (strong,nonatomic) NSString <Optional> *longitude;
@property (strong,nonatomic) NSString <Optional> *currency;
@property (strong,nonatomic) NSString <Optional> *complete_address;
@property (strong,nonatomic) DDMerchantRatingM <Optional> *rating;
@property (strong,nonatomic) NSDictionary <Optional> *api_param;
@property (strong,nonatomic) NSArray <DDMerchantDeliveryMenuM, Optional> *delivery_menu;
@property (strong,nonatomic) NSArray <DDHomeSectionAttributeM, Optional> *merchant_attributes;
@property (strong,nonatomic) NSArray <DDMerchantInfoSectionM, Optional> *info;
@property (strong,nonatomic) NSArray <NSString, Optional> *image_urls;

-(NSString *)minOrder;
-(NSString *)deliveryFee;
-(BOOL)isOpen;
-(BOOL)isInsideRegion;
-(BOOL)isFav;
-(UIColor *)onlineColor;
-(NSString *)onlineTitle;
-(NSString *)unableToPlaceOrderError;
@end

NS_ASSUME_NONNULL_END
