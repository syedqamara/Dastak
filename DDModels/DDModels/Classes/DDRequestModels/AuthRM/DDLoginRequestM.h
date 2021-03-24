//
//  DDLoginRequestM.h
//  DDAuth
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//

#import "DDBaseRequestModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDLoginRequestM : DDBaseRequestModel
@property (strong, nonatomic) NSString <Optional> *captcha_token;
@property (strong, nonatomic) NSString <Optional> *email;
@property (strong, nonatomic) NSString <Optional> *password;
@property (strong, nonatomic) NSNumber <Optional> *is_user_agreement_accepted;
@property (strong, nonatomic) NSNumber <Optional> *is_privacy_policy_accepted;
@property (strong, nonatomic) NSNumber <Optional> *is_social;
@property (strong, nonatomic) NSNumber <Optional> *force_login;

-(BOOL)isValidRequest;
-(NSString *)validationError;
@end

NS_ASSUME_NONNULL_END
