//
//  DDBasketM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 21/08/2020.
//

#import "DDBaseModel.h"
#import "DDModels.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDBasketM : DDBaseModel
@property (strong, nonatomic) NSMutableArray <DDMerchantDeliveryMenuItemM, Optional> *items;
@property (strong, nonatomic) DDDeliveryAddressM <Optional>*address;
@property (strong, nonatomic) DDUserM <Optional>*user;
@property (strong, nonatomic) DDMerchantM <Optional>*merchant;
@property (strong, nonatomic) NSArray <DDPaymentMethod, Optional>*payment_types;
@property (strong, nonatomic) NSDictionary <Optional>*api_param;
@end

NS_ASSUME_NONNULL_END
