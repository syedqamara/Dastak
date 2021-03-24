//
//  DDSignupRequestM.h
//  DDAuth
//
//  Created by M.Jabbar on 07/01/2020.
//

#import <Foundation/Foundation.h>
#import "DDBaseRequestModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDSignupRequestM : DDBaseRequestModel
@property (strong, nonatomic) NSString <Optional> *email;
@property (strong, nonatomic) NSString <Optional> *otp;
@property (strong, nonatomic) NSString <Optional> *first_name;
@property (strong, nonatomic) NSString <Optional> *last_name;
@property (strong, nonatomic) NSString <Optional> *third_party_id;
@property (strong, nonatomic) NSString <Optional> *password;
@property (strong, nonatomic) NSString <Optional> *confirm_password;
@property (strong, nonatomic) NSString <Optional> *country_of_residence;
@property (strong, nonatomic) NSNumber <Optional> *is_user_agreement_accepted;
@property (strong, nonatomic) NSNumber <Optional> *is_privacy_policy_accepted;
@property (strong, nonatomic) NSString <Optional> *country_code;
@property (strong, nonatomic) NSString <Optional> *dob;
@property (strong, nonatomic) NSString <Optional> *gender;
@property (strong, nonatomic) NSString <Optional> *phone_number;
@property (strong, nonatomic) NSString <Optional> *login_type;
-(NSString *)completeMobileNumber;
-(BOOL)canProceedThirdPartyLogin;
@end

NS_ASSUME_NONNULL_END
