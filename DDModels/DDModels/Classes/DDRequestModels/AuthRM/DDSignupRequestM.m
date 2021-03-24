//
//  DDSignupRequestM.m
//  DDAuth
//
//  Created by M.Jabbar on 07/01/2020.
//

#import "DDSignupRequestM.h"

@implementation DDSignupRequestM
-(NSString *)completeMobileNumber {
    return [NSString stringWithFormat:@"%@%@",self.country_code,self.phone_number];
}
-(BOOL)canProceedThirdPartyLogin {
    return self.email.length > 0 && self.first_name.length > 0;
}
@end
