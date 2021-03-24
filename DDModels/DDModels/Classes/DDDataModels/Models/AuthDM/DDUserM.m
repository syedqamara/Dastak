//
//  DDUserM.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 20/08/2020.
//

#import "DDUserM.h"

@implementation DDUserM
-(BOOL)isPhoneNumberVerified {
    if (self.is_phone_verified != nil) {
        return self.is_phone_verified.boolValue;
    }
    return NO;
}
-(NSString *)completeMobileNumber {
    return [NSString stringWithFormat:@"%@",self.phone_number];
}
-(void)setGenderType:(DDUserGender)genderType {
    if (genderType == DDUserGenderNone) {
        self.gender = nil;
    }
    if (genderType == DDUserGenderMale) {
        self.gender = @"male";
    }
    if (genderType == DDUserGenderFemale) {
        self.gender = @"female";
    }
}
-(DDUserGender)genderType {
    if ([self.gender.lowercaseString isEqualToString:@"male"]) {
        return DDUserGenderMale;
    }
    if ([self.gender.lowercaseString isEqualToString:@"female"]) {
        return DDUserGenderFemale;
    }
    return DDUserGenderNone;
}
@end
