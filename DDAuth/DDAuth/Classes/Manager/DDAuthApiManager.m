//
//  DDAuthApiManager.m
//  DDAuth
//
//  Created by Syed Qamar Abbas on 30/12/2019.
//

#import "DDAuthApiManager.h"

#define K_USER_CHANGE_PASSWORD @"user/change-password"
#define K_USER_CHANGE_EMAIL @"user/change-email"
#define K_AUTH_ACTIVATE_KEY @"user/activate_key"
#define K_AUTH_PASSWORD_UPDATE_ENDPOINT @"change_password"
#define K_AUTH_RULES_ENDPOINT @"rules"
#define K_AUTH_SESSION_ENDPOINT @"user/session"
#define K_AUTH_PASSWORDS_ENDPOINT @"user/reset-password"
#define K_AUTH_THIRD_PARTY @"user/third-party-login"
#define K_AUTH_RESEND_ENDPOINT @"resend_email"
#define K_AUTH_REGISTRATION @"user/register"
#define K_AUTH_USERSINFO_ENDPOINT @"user/get/profile"
#define K_AUTH_CONFIG_ENDPOINT @"configs"
#define K_AUTH_COUNTRY_ENDPOINT @"country"
#define K_AUTH_EDITPROFILE_ENDPOINT @"user/profile"
#define K_AUTH_USER_PROFILE_WITH_ID_ENDPOINT @"user/update-profile"
#define K_AUTH_PENDING_NOTIFICATIONS @"pending_notifications"
#define K_AUTH_CHEERS_CONFIRMATION_ENDPOINT @"family/edit_family_member_cheers"
#define K_AUTH_REDEMPTION_SYNC @"redemptions/sync"
#define K_AUTH_SESSION_LOGOUT_ENDPOINT @"user/logout"
#define K_AUTH_REGISTRATION_VALIDATE_EMAIL @"validate/email"
#define K_AUTH_SDD_OTP @"user/send-otp"
#define K_AUTH_VERIFY_OTP @"user/verify-otp"

//#import <DDUI/DDUI.h>

@implementation DDAuthApiManager
-(void)getConfigs {}
-(void)loginUser {}
-(void)editProfile {}
-(void)updateDemographics {}
-(void)getPasswordRules {}
-(void)updateNewPassword {}
-(void)forgotPassword {}
-(void)signUp {}
-(void)resendEmail {}
-(void)userProfile {}
-(void)getCountryDestinations {}
-(void)signout{}
-(void)verifyKey{}
-(void)pendingNotifications {}
-(void)cheersNotificationsConfirmation {}
-(void)redemptionSync {}
-(void)changePassword {}
-(void)changeEmail {}

//temp[@(DDApisType_Auth_Login)].end_point = K_AUTH_SESSION_ENDPOINT
//temp[@(DDApisType_Auth_Forgot_Password)].end_point = K_AUTH_PASSWORDS_ENDPOINT
//temp[@(DDApisType_Auth_SignUp)].end_point = K_AUTH_USERS_ENDPOINT
//temp[@(DDApisType_Auth_User_Profile)].end_point = K_AUTH_RESEND_ENDPOINT
//temp[@(DDApisType_Auth_ResendEmail)].end_point = K_AUTH_USERSINFO_ENDPOINT
//temp[@(DDApisType_Auth_User_Profile)].end_point = K_AUTH_SESSION_ENDPOINT


+(void)registerApiConfiguration {
    
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Auth_Update_Password classObj:self responseClassObj:DDBaseApiModel.class selector:@selector(updateNewPassword) endPoint:K_AUTH_PASSWORD_UPDATE_ENDPOINT isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];

    [DDApisConfiguration registerConfigurations:DDApisType_App_Configs classObj:self responseClassObj:DDConfigApiM.class selector:@selector(getConfigs) endPoint:K_AUTH_CONFIG_ENDPOINT isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Auth_ResendEmail classObj:self responseClassObj:DDAuthLoginM.class selector:@selector(resendEmail) endPoint:K_AUTH_RESEND_ENDPOINT isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Auth_Login classObj:self responseClassObj:DDAuthLoginM.class selector:@selector(loginUser) endPoint:K_AUTH_SESSION_ENDPOINT isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    

    [DDApisConfiguration registerConfigurations:DDApisType_Auth_SignUp classObj:self responseClassObj:DDAuthSignupResponseM.class selector:@selector(signUp) endPoint:K_AUTH_REGISTRATION isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    [DDApisConfiguration registerConfigurations:DDApisType_Auth_SignUp_Third_Party classObj:self responseClassObj:DDAuthSignupResponseM.class selector:@selector(signUp) endPoint:K_AUTH_THIRD_PARTY isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Auth_Forgot_Password classObj:self responseClassObj:DDAuthLoginM.class selector:@selector(forgotPassword) endPoint:K_AUTH_PASSWORDS_ENDPOINT isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Auth_User_Profile classObj:self responseClassObj:DDAuthLoginM.class selector:@selector(userProfile) endPoint:K_AUTH_USERSINFO_ENDPOINT isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    
//     [DDApisConfiguration registerConfigurations:DDApisType_Auth_UpdateProfile classObj:self responseClassObj:DDEditProfileAPIM.class selector:@selector(editProfile) endPoint:K_AUTH_EDITPROFILE_ENDPOINT isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];

    [DDApisConfiguration registerConfigurations:DDApisType_Auth_User_profile_with_id classObj:self responseClassObj:DDAuthLoginM.class selector:@selector(updateDemographics) endPoint:K_AUTH_USER_PROFILE_WITH_ID_ENDPOINT isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Auth_Logout classObj:self responseClassObj:DDBaseApiModel.class selector:@selector(signout) endPoint:K_AUTH_SESSION_LOGOUT_ENDPOINT isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Auth_SignUpEmail_Validateion classObj:self responseClassObj:DDAuthEmailValidationApiM.class selector:@selector(signUp) endPoint:K_AUTH_REGISTRATION_VALIDATE_EMAIL isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Auth_Send_OTP classObj:self responseClassObj:DDBaseApiModel.class selector:@selector(signUp) endPoint:K_AUTH_SDD_OTP isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Auth_Verify_OTP classObj:self responseClassObj:DDBaseApiModel.class selector:@selector(signUp) endPoint:K_AUTH_VERIFY_OTP isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Auth_Change_Password classObj:self responseClassObj:DDOutletApiM.class selector:@selector(changePassword) endPoint:K_USER_CHANGE_PASSWORD isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Auth_Change_Email classObj:self responseClassObj:DDOutletApiM.class selector:@selector(changeEmail) endPoint:K_USER_CHANGE_EMAIL isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
}
@end
