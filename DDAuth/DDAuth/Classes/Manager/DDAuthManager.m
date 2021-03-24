//
//  DDAuthManager.m
//  DDAuth
//
//  Created by M.Jabbar on 10/01/2020.
//

#import "DDAuthManager.h"
#import <DDNetwork/DDNetwork.h>
#import "DDStorage/DDStorage.h"
#import "DDUserManager.h"

@implementation DDAuthManager

static DDAuthManager * _sharedObject;
+(DDAuthManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [DDAuthManager.alloc init];
    });
    return _sharedObject;
}

-(void)signUpEmailValidate:(DDBaseRequestModel *)reqModel  andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    [UIApplication showDDLoaderAnimation];
    [self verifyCaptchaWithCompletion:^(NSString * _Nullable captcha, NSError * _Nullable error) {
        [UIApplication dismissDDLoaderAnimation];
        if (error == nil) {
//            NSMutableDictionary *dict = reqModel.custom_parameters;
//            [dict setValue:captcha forKey:@"captcha_token"];
//            reqModel.custom_parameters = dict;
//            reqModel.i_c_e = @(1);
            DDSignupRequestM *req = (DDSignupRequestM *)reqModel;
            if (req.login_type.length > 0) {
                [self signUpUserWithThirdParty:req andCompletion:completion];
            }else {
                [self signUpEmailValidaterWithCaptchaSettings:reqModel andCompletion:completion];
            }
            
        }else {
            completion(nil, nil, error);
        }
    }];
}
-(void)signUpEmailValidaterWithCaptchaSettings:(DDBaseRequestModel *)reqModel  andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    [DDNetworkManager.shared post:DDApisType_Auth_SignUp showHUD:YES withParam:reqModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDAuthSignupResponseM *loginModel = (DDAuthSignupResponseM *)model;
        DDUserManager.shared.currentUser = loginModel.data.user;
        
        completion(loginModel, response, error);
    }];
}

-(void)loginUser:(DDBaseRequestModel *)login  andCompletion:(void (^)(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion  {
    [UIApplication showDDLoaderAnimation];
    [self verifyCaptchaWithCompletion:^(NSString * _Nullable captcha, NSError * _Nullable error) {
        [UIApplication dismissDDLoaderAnimation];
        if (error == nil) {
            [self loginUserWithCaptchaSettings:login andCompletion:completion];
        }else {
            completion(nil, nil, error);
        }
    }];
}

-(void)config:(DDBaseRequestModel *)param  andCompletion:(void (^)(DDConfigApiM * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion  {
    [DDNetworkManager.shared post:DDApisType_App_Configs showHUD:YES withParam:param andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDConfigApiM *config = (DDConfigApiM *)model;
        self.config = config;
        if (completion != nil) {
            completion(config, response, error);
        }
    }];
}

-(void)loginUserWithCaptchaSettings:(DDBaseRequestModel *)login  andCompletion:(void (^)(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    [DDNetworkManager.shared post:DDApisType_Auth_Login showHUD:YES withParam:login andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDAuthLoginM *loginModel = (DDAuthLoginM *)model;
        DDUserManager.shared.currentUser = loginModel.data.user;
        
        completion(loginModel, response, error);
//        if (loginModel.data.isUserLoggedIn) {
//            DDUserManager.shared.currentUser = loginModel.data.user;
//            completion(loginModel, response, error);
//
//        }else {
//            completion(loginModel, response, error);
//        }
    }];
}

-(void)updateUserImage:(DDBaseRequestModel *)userProfile andCompletion:(void (^)(DDBaseApiModel * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion  {
    [DDNetworkManager.shared post:DDApisType_Auth_UpdateProfile showHUD:YES withParam:userProfile andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(model, response, error);
    }];
}

-(void)updateProfileInfo:(DDBaseRequestModel *)userProfile andCompletion:(void (^)(DDAuthLoginM * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion  {
    
    [DDNetworkManager.shared post:DDApisType_Auth_User_profile_with_id showHUD:YES withParam:userProfile andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDAuthLoginM *loginModel = (DDAuthLoginM *)model;
        
        completion(loginModel, response, error);
    }];
}

-(void)updatePassword:(DDBaseRequestModel *)request andCompletion:(void (^)(DDBaseApiModel * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion{
    [DDNetworkManager.shared post:DDApisType_Auth_Update_Password showHUD:NO withParam:request andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(model, response, error);
    }];
}

-(void)signUpUser:(DDSignupRequestM *)signup andCompletion:(void (^)(DDAuthSignupResponseM * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    if (signup.login_type.length > 0) {
        [self signUpUserWithThirdParty:signup andCompletion:completion];
    }else {
        [self signUpUserWithCaptchaSettings:signup andCompletion:completion];
    }
    
}

-(void)signUpUserWithCaptchaSettings:(DDSignupRequestM *)signup andCompletion:(void (^)(DDAuthSignupResponseM * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    [DDNetworkManager.shared post:DDApisType_Auth_SignUp showHUD:YES withParam:signup andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDAuthSignupResponseM *signupModel = (DDAuthSignupResponseM *)model;
        completion(signupModel, response, error);
    }];
}

-(void)signUpUserWithThirdParty:(DDSignupRequestM *)signup andCompletion:(void (^)(DDAuthSignupResponseM * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    [DDNetworkManager.shared post:DDApisType_Auth_SignUp_Third_Party showHUD:YES withParam:signup andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDAuthSignupResponseM *loginModel = (DDAuthSignupResponseM *)model;
        DDUserManager.shared.currentUser = loginModel.data.user;
        
        completion(loginModel, response, error);
    }];
}

-(void)forgotPassword:(DDBaseRequestModel *)reqM andCompletion:(void (^)(DDAuthLoginM * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    
    [DDNetworkManager.shared post:DDApisType_Auth_Forgot_Password showHUD:YES withParam:reqM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(model, response, error);
    }];
}
-(void)userProfileWithCompletion:(BOOL)showHud completion:(void (^)(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    [DDNetworkManager.shared post:(DDApisType_Auth_User_Profile) showHUD:showHud withParam:DDBaseRequestModel.new andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDAuthLoginM *loginModel = (DDAuthLoginM *)model;
        completion(loginModel, response, error);
    }];
}
-(void)logout{
    //if (DDUserManager.shared.isLoggedIn == NO) return;
    [DDNetworkManager.shared post:(DDApisType_Auth_Logout) showHUD:YES withParam:DDBaseRequestModel.new andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil){
            [NSNotificationCenter.defaultCenter postNotificationName:DD_USER_LOGOUT_NOTIFICATION object:nil];
            [[DDUserManager shared] logout];
            [UIApplication refreshAppWithParams:nil];
        }
    }];
    
}

-(void)sendOTPWithRequestModel:(DDBaseRequestModel *)request WithCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    [DDNetworkManager.shared post:DDApisType_Auth_Send_OTP showHUD:YES withParam:request andCompletion:completion];
}
-(void)verifyOTPWithRequestModel:(DDBaseRequestModel *)request WithCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    [DDNetworkManager.shared post:DDApisType_Auth_Verify_OTP showHUD:YES withParam:request andCompletion:completion];
}
-(void)resendEmail:(NSString *)email withCompletion:(void (^)(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    DDLoginRequestM *req = [DDLoginRequestM new];
    req.email = email;
    [DDNetworkManager.shared post:(DDApisType_Auth_ResendEmail) showHUD:YES withParam:req andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDAuthLoginM *loginModel = (DDAuthLoginM *)model;
        completion(loginModel, response, error);
    }];
}
-(void)verifyCaptchaWithCompletion:(void (^)(NSString * _Nullable token, NSError * _Nullable error))completion {
    completion(nil,nil);
}
-(void)verifyKeys:(DDBaseRequestModel *)keyRequest onCompletion:(void (^)(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    
    [DDNetworkManager.shared post:DDApisType_Auth_Verify_Key showHUD:YES withParam:keyRequest andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDAuthLoginM *apiModel = (DDAuthLoginM *)model;
        completion(apiModel, response, error);
    }];
}
-(void)changeEmail:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(DefaultApiCompletionCallback)completion {
    [DDNetworkManager.shared post:DDApisType_Auth_Change_Email showHUD:showHUD withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion(model, error);
        }
    }];
}
-(void)changePassword:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(DefaultApiCompletionCallback)completion {
    [DDNetworkManager.shared post:DDApisType_Auth_Change_Password showHUD:showHUD withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion(model, error);
        }
    }];
}
@end
