//
//  DDLoginRequestM.m
//  DDAuth
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//

#import "DDLoginRequestM.h"
#import "NSString+DDString.h"
#import "DDCommons.h"

@implementation DDLoginRequestM

-(BOOL)isValidRequest {
    return self.validationError.length == 0;
}

-(NSString *)validationError {
    NSString *errorMessage = @"";
    if (self.email == nil || self.email.length == 0 || !self.email.isValidEmail) {
        errorMessage = INVALID_EMAIL_MESSAGE.localized;
    }
    else if (self.password == nil || self.password.length == 0 || !self.password.isValidPassword) {
        errorMessage = PASSWORD_ERROR_MESSAGE.localized;
    }
//    else if (self.is_user_agreement_accepted == nil || self.is_user_agreement_accepted.boolValue == false) {
//        errorMessage = EULA_ERROR_MESSAGE.localized;
//    }
//    else if (self.is_privacy_policy_accepted == nil || self.is_privacy_policy_accepted.boolValue == false) {
//        errorMessage = PRIVACY_POLICY_ERROR_MESSAGE.localized;
//    }
    return errorMessage;
}
@end
