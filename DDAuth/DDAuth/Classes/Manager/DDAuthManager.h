//
//  DDAuthManager.h
//  DDAuth
//
//  Created by M.Jabbar on 10/01/2020.
//

#import <Foundation/Foundation.h>
#import "DDLoginRequestM.h"
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>




NS_ASSUME_NONNULL_BEGIN

@interface DDAuthManager : NSObject

+(DDAuthManager *)shared;
@property (strong, nonatomic) DDConfigApiM *config;

-(void)loginUser:(DDLoginRequestM *)login  andCompletion:(void (^)(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion;
-(void)signUpUser:(DDSignupRequestM *)signup  andCompletion:(void (^)(DDAuthSignupResponseM * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion;
-(void)signUpEmailValidate:(DDBaseRequestModel *)reqModel  andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion;
-(void)logout;
-(void)forgotPassword:(DDBaseRequestModel *)reqM andCompletion:(void (^)(DDAuthLoginM * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion;
-(void)resendEmail:(NSString *)email withCompletion:(void (^)(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion;
-(void)userProfileWithCompletion:(BOOL)showHud completion:(void (^)(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)updateUserImage:(DDBaseRequestModel *)userProfile andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion;
-(void)updatePassword:(DDBaseRequestModel *)request andCompletion:(void (^)(DDBaseApiModel * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion;
-(void)updateProfileInfo:(DDBaseRequestModel *)userProfile andCompletion:(void (^)(DDAuthLoginM * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion;
-(void)verifyKeys:(DDAuthLoginM *)keyRequest onCompletion:(void (^)(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)sendOTPWithRequestModel:(DDBaseRequestModel *)request WithCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion;
-(void)verifyOTPWithRequestModel:(DDBaseRequestModel *)request WithCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion;
-(void)changeEmail:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(DefaultApiCompletionCallback)completion;
-(void)changePassword:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(DefaultApiCompletionCallback)completion;
-(void)config:(DDBaseRequestModel *)param  andCompletion:(void (^)(DDConfigApiM * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion;
@end

NS_ASSUME_NONNULL_END
