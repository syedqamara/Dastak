//
//  DDMerchantMenuItemCustomizationOptionM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 22/07/2020.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantMenuItemCustomizationOptionM : DDBaseModel
@property (strong,nonatomic) NSNumber <Optional> *option_id;
@property (strong,nonatomic) NSNumber <Optional> *cust_id;
@property (strong,nonatomic) NSString <Optional> *title;
@property (strong,nonatomic) NSNumber <Optional> *price;
@property (strong,nonatomic) NSNumber <Optional> *is_additional_price;
@property (strong,nonatomic) NSNumber <Optional> *is_selected;
@property (strong,nonatomic) NSString <Optional> *currency;
-(BOOL)isSelected;
-(void)toggle;
-(NSString *)priceWithCurrency;
@end

NS_ASSUME_NONNULL_END
