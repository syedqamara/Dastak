//
//  DDCCommonApiParam.h
//  DDCommons
//
//  Created by Syed Qamar Abbas on 30/01/2020.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCCommonApiParam : JSONModel
@property (strong, nonatomic) NSString <Optional> *device_id;
@property (strong, nonatomic) NSString <Optional> *api_token;

@property (strong, nonatomic) NSNumber <Optional> *temp;
@property (strong, nonatomic) NSString <Optional> *__i;
@property (strong, nonatomic) NSString <Optional> *__lat;
@property (strong, nonatomic) NSString <Optional> *__lng;
@property (strong, nonatomic) NSString <Optional> *__platform;
@property (strong, nonatomic) NSString <Optional> *app_version;
@property (strong, nonatomic) NSString <Optional> *company;
@property (strong, nonatomic) NSString <Optional> *currency;
@property (strong, nonatomic) NSString <Optional> *device_key;
@property (strong, nonatomic) NSString <Optional> *device_model;
@property (strong, nonatomic) NSString <Optional> *device_os;
@property (strong, nonatomic) NSString <Optional> *email;
@property (strong, nonatomic) NSString <Optional> *is_privacy_policy_accepted;
@property (strong, nonatomic) NSString <Optional> *is_social;
@property (strong, nonatomic) NSString <Optional> *is_user_agreement_accepted;
@property (strong, nonatomic) NSString <Optional> *language;
@property (strong, nonatomic) NSString <Optional> *os_version;
@property (strong, nonatomic) NSString <Optional> *password;

@property (strong, nonatomic) NSString <Optional> *time_zone;
@property (strong, nonatomic) NSString <Optional> *user_id;
@property (strong, nonatomic) NSString <Optional> *location_id;
@property (strong, nonatomic) NSString <Optional> *api_version;

@property (strong, nonatomic) NSMutableDictionary <Ignore> *extra_params;
-(void)insertDictionary:(NSDictionary *)dict;
@end


NS_ASSUME_NONNULL_END
