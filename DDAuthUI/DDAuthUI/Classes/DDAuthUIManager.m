//
//  DDAuthUIManager.m
//  DDAuthUI
//
//  Created by M.Jabbar on 25/02/2020.
//

#import "DDAuthUIManager.h"
#import "DDAuth.h"
#import "DDUI.h"

@implementation DDAuthUIManager

+(void)showCountryCodePicker:(UIViewController*)controller withCountries:(NSArray *)countries withSelectedCountryCode:(NSString *)code WithcallBack:(ControllerCallBack _Nullable)block{
    DDPopupVM *popup = [DDPopupVM new];
    popup.title = @"Choose Country";
    popup.search_placeholder = @"Search by Country Name & Code";
    for (DDCountryM *country in countries) {
        DDPopupOptionVM *option = [DDPopupOptionVM new];
        option.titleLabelLeft = country.titleWithImage;
        option.titleLabelRight = country.code;
        option.rightImageSelected = @"checkbox.png";
        option.rightImageNormal = @"uncheckbox.png";
        if ([code isEqualToString:country.code]) {
            option.isSelected = YES;
        }
        if (country.code.length > 0 && ![country.code isEqualToString:@"+"]) {
            option.object = country;
            [popup.options addObject:option];
        }
    }
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_UI_Popup_Option;
    route.transition = DDUITransitionPresentWithPan2;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.panDraggableInFullScreen = YES;
    route.panModelHeight = popup.panHeight;
    route.callback = ^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:YES completion:nil];
        if (block != nil && data != nil) {
            block(identifier, data, controller);
        }
    };
    route.data = popup;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
+(void)showLanguagePicker:(UIViewController*)controller withcallBack:(ControllerCallBack _Nullable)block{
    DDPopupVM *popup = [DDPopupVM new];
    popup.title = @"Language";
    DDPopupOptionVM *option = [DDPopupOptionVM new];
    option.titleLabelLeft = @"English";
    option.object = @"en";
    option.rightImageSelected = @"checkbox.png";
    option.rightImageNormal = @"uncheckbox.png";
    if ([DDCCommonParamManager.shared.default_api_parameters.language isEqualToString:option.object]) {
        option.isSelected = YES;
    }
    [popup.options addObject:option];
    
    DDPopupOptionVM *option2 = [DDPopupOptionVM new];
    option2.titleLabelLeft = @"Arabic";
    option2.object = @"ar";
    option2.rightImageSelected = @"checkbox.png";
    option2.rightImageNormal = @"uncheckbox.png";
    if ([DDCCommonParamManager.shared.default_api_parameters.language isEqualToString:option2.object]) {
        option2.isSelected = YES;
    }
    [popup.options addObject:option2];
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_UI_Popup_Option;
    route.transition = DDUITransitionPresentWithPan2;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.panDraggableInFullScreen = YES;
    route.panModelHeight = popup.panHeight;
//    route.callback = block;
    route.data = popup;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
    route.callback = ^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:YES completion:nil];
        if (block != nil && data != nil) {
            block(identifier, data, controller);
        }
    };
}

+(void)showMobileNumber:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block{
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Auth_Mobile_Number;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
//DD_Nav_Auth_Welcome
+(void)showVerifyMobileNumber:(UIViewController*)controller withData:(id)data WithcallBack:(ControllerCallBack _Nullable)block{
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Auth_Verify_Phone_Number;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.callback = block;
    route.data = data;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

+(void)showWelcome:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block{
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Auth_Welcome;
    route.transition = DDUITransitionPresent;
    route.is_animated = YES;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
+(void)showLoginScreenOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block{
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Auth_Login;
    route.transition = DDUITransitionPresent;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

+(void)showLoginOptionsOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block{
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Auth_Options;
    route.transition = DDUITransitionPresentWithPan2;
    route.is_animated = YES;
    route.panDraggableInFullScreen = NO;
    route.panModelHeight = 429;
    route.disableUpwardPan = YES;
    route.should_embed_in_nav = YES;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
+(void)showRegisterScreenOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block{
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Auth_Sign_Up;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = NO;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
+(void)showRegisterPasswordScreenOnController:(UIViewController*)controller withData:(DDSignupRequestM *)signupRequest withcallBack:(ControllerCallBack _Nullable)block{
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Auth_Sign_Up_Password;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = NO;
    route.callback = block;
    route.data = signupRequest;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
+(void)showForgotPasswordScreenOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block{
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Auth_Forgot_Password;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = NO;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
+(void)setupDatePicker:(UIView*)origin
          selectedDate:(NSDate*)selectedDate
               minDate:(NSDate*)minDate
               maxDate:(NSDate*)maxDate
       onSelectionDone:(void (^)(NSDate*))onSelectionDone {
    
    if (!selectedDate) {
        selectedDate = [NSDate date];
    }

    ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:nil datePickerMode:UIDatePickerModeDate selectedDate:selectedDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {

        onSelectionDone(selectedDate);

    } cancelBlock:^(ActionSheetDatePicker *picker) {

    } origin:origin];


    picker.minimumDate = minDate;
    picker.maximumDate = maxDate;
    [picker showActionSheetPicker];
}
+(void)showPickerWithDataSource:(NSArray *)data onController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block {
    DDUIRouterM *route = [DDUIRouterM new];
    route.route_link = DD_Nav_Auth_Native_Picker;
    route.transition = DDUITransitionPresent;
    route.is_animated = NO;
    route.callback = block;
    route.data = data;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

+(void)setupListPicker:(UIView*)origin
         dataArray:(NSArray*)dataArray
         sheetTitle:(NSString*)sheetTitle
       onSelectionDone:(void (^)(NSInteger))onSelectionDone {
    
}

+(void)showDemographicsOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block {
//    if (DDUserManager.shared.currentUser.isDemographicsUpdated) {
//        block(nil, nil, controller);
//        return;
//    }
    DDUIRouterM *route = [DDUIRouterM new];
    route.route_link = DD_Nav_Auth_Demographics;
    route.transition = DDUITransitionPresent;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

+(void)showResetPasswordPopupWithData:(DDAuthResetPasswordSectionM *)reqModel onController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block {
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Auth_Reset_password_Popup;
    route.transition = DDUITransitionPresent;
    route.is_animated = NO;
    route.should_embed_in_nav = NO;
    route.data = reqModel;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
+(void)showSettingsOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block {
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Accounts_Settings;
    route.transition = DDUITransitionPresent;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
+(void)showChangeEmailOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block {
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Auth_Change_Email;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = NO;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
+(void)showChangePasswordOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block {
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Auth_Change_Password;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = NO;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

+(void)showDeliveryLocationsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    [self showControllerFrom:controller
                  route_link:DD_Nav_Cashless_Locations
                  transition:DDUITransitionPresentWithPan2
                   animation:YES
         should_embed_in_nav:YES
                        data:data
          controllerCallBack:controllerCallBack];
}

+(void)showPersonalDetailVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    [self showControllerFrom:controller
                  route_link:DD_Nav_Accounts_My_Account
                  transition:DDUITransitionPresent
                   animation:YES
         should_embed_in_nav:YES
                        data:data
          controllerCallBack:controllerCallBack];
}
+(void)showControllerFrom:(UIViewController*)controller
               route_link:(NSString* _Nonnull)route_link
               transition:(DDUITransition)transition
                animation:(BOOL)animation
      should_embed_in_nav:(BOOL)should_embed_in_nav
                     data:(id _Nullable)data
       controllerCallBack:(ControllerCallBack)controllerCallBack {
    
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = route_link;
    route.transition = transition;
    route.should_embed_in_nav = should_embed_in_nav;
    route.is_animated = animation;
    if ([route_link isEqualToString:DD_Nav_Cashless_Locations]){
        route.panDraggableInFullScreen = YES;
    }else {
        route.disableUpwardPan = YES;
    }
    if (data) route.data = data;
    if (controllerCallBack) route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];

}
@end
