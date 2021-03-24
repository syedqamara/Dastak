//
//  DDBaseAppConfiguration.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDAuthUIAppUIConfiguration.h"
#import "DDAuthUI.h"
@implementation DDAuthUIAppUIConfiguration

+(void)loadUIConfiguration {
    [DDPersonalDetails setRouteConfiguration];
    [DDProfileVC setRouteConfiguration];
    [DDSettingsVC setRouteConfiguration];
    [DDChangeEmailVC setRouteConfiguration];
    [DDChangePasswordVC setRouteConfiguration];
    [DDSignupVC setRouteConfiguration];
    [DDLoginOptionsVC setRouteConfiguration];
    [DDWelcomeViewController setRouteConfiguration];
    [DDVerifyMobileNumber setRouteConfiguration];
    [DDMobileNumberVC setRouteConfiguration];
    [DDLoginVC setRouteConfiguration];
    [DDForgotPasswordVC setRouteConfiguration];
    [DDSignupPasswordVC setRouteConfiguration];
    [DDAuthUINativePickerVC setRouteConfiguration];
    [DDRegistrationDemographicsVC setRouteConfiguration];
    [DDNewPasswordViewController setRouteConfiguration];
    [DDCheersConfirmationView setRouteConfiguration];
    [DDResetPasswordRequestVC setRouteConfiguration];
    
    
}

@end
