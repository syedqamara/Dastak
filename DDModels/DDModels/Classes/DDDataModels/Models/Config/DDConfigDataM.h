//
//  DDConfigDataM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 05/09/2020.
//

#import "DDBaseModel.h"
#import "DDDeliveryAddressM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDPaymentMethod : DDBaseModel
@property (strong, nonatomic) NSString <Optional> *identifier;
@property (strong, nonatomic) NSString <Optional> *title;
@property (strong, nonatomic) NSString <Optional> *image_url;
@end

@interface DDConfigDataM : DDBaseModel
@property (strong, nonatomic) DDDeliveryAddressM <Optional> *default_location;
@property (strong, nonatomic) NSArray <DDCountrySectionM, Optional> *supported_countries;
@property (strong, nonatomic) NSArray <DDPaymentMethod, Optional> *c_2_c_payment_method;
@property (strong, nonatomic) NSArray <DDPaymentMethod, Optional> *delivery_payment_method;
@end

NS_ASSUME_NONNULL_END
