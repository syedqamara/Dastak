//
//  DDAuthUIManager.h
//  DDAuthUI
//
//  Created by M.Jabbar on 25/02/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <UIKit/UIKit.h>
#import <DDUI/DDUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDAuthUIManager : NSObject
+(void)showCountryCodePicker:(UIViewController*)controller withCountries:(NSArray *)countries withSelectedCountryCode:(NSString *)code WithcallBack:(ControllerCallBack _Nullable)block;
+(void)showVerifyMobileNumber:(UIViewController*)controller withData:(id)data WithcallBack:(ControllerCallBack _Nullable)block;
+(void)showWelcome:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block;
+(void)showLoginScreenOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block;
+(void)showRegisterScreenOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block;
+(void)showRegisterPasswordScreenOnController:(UIViewController*)controller withData:(DDSignupRequestM *)signupRequest withcallBack:(ControllerCallBack _Nullable)block;
+(void)showForgotPasswordScreenOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block;

+(void)setupDatePicker:(UIView*)origin
          selectedDate:(NSDate*)selectedDate
               minDate:(NSDate*)minDate
               maxDate:(NSDate*)maxDate
       onSelectionDone:(void (^)(NSDate*))onSelectionDone;
+(void)setupListPicker:(UIView*)origin
                dataArray:(NSArray*)dataArray
                sheetTitle:(NSString*)sheetTitle
       onSelectionDone:(void (^)(NSInteger))onSelectionDone;
+(void)showPickerWithDataSource:(NSArray *)data onController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block;
+(void)showDemographicsOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block;
+(void)applyKeys;
+(void)showResetPasswordPopupWithData:(DDAuthResetPasswordSectionM *)reqModel onController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block;
+(void)showMobileNumber:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block;
+(void)showLoginOptionsOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block;
+(void)showSettingsOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block;
+(void)showChangeEmailOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block;
+(void)showChangePasswordOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block;
+(void)showLanguagePicker:(UIViewController*)controller withcallBack:(ControllerCallBack _Nullable)block;
+(void)showDeliveryLocationsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
+(void)showPersonalDetailVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
@end

NS_ASSUME_NONNULL_END
