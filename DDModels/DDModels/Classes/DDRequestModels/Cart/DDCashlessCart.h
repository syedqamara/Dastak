//
//  CashlessCart.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 27/03/2020.
//

#import "DDBaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface DDCashlessCartDTS : DDBaseRequestModel
@property (strong, nonatomic) NSString <Optional> *__t;
@property (strong, nonatomic) NSString <Optional> *device_model;
@property (strong, nonatomic) NSString <Optional> *device_key;
@property (strong, nonatomic) NSNumber <Optional> *__sid;
@property (strong, nonatomic) NSString <Optional> *app_version;
@property (strong, nonatomic) NSString <Optional> *session_token;
@property (strong, nonatomic) NSString <Optional> *company;
@property (strong, nonatomic) NSString <Optional> *user_id;
@property (strong, nonatomic) NSString <Optional> *location_id;
@property (strong, nonatomic) NSString <Optional> *__lng;
@property (strong, nonatomic) NSString <Optional> *__lat;
@property (strong, nonatomic) NSString <Optional> *device_id;
@property (strong, nonatomic) NSNumber <Optional> *__i;
@property (strong, nonatomic) NSString <Optional> *language;
@property (strong, nonatomic) NSString <Optional> *os_version;
@property (strong, nonatomic) NSString <Optional> *currency;
@property (strong, nonatomic) NSString <Optional> *__platform;
@property (strong, nonatomic) NSString <Optional> *time_zone;

@end

@interface DDCashlessCart : DDBaseRequestModel
@property (strong, nonatomic) NSString <Optional> * _Nullable __basket;
@property (strong, nonatomic) NSString <Optional> * _Nullable __default_param;

@property (strong, nonatomic) NSDictionary <Optional> * _Nullable basket;
@property (strong, nonatomic) NSDictionary <Optional> * _Nullable default_param;

-(NSDictionary *)decryptedCart;
@end

NS_ASSUME_NONNULL_END
