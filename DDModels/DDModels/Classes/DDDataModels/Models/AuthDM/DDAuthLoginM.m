//
//  DDAuthLoginM.m
//  DDCommons
//
//  Created by Syed Qamar Abbas on 31/12/2019.
//

#import "DDAuthLoginM.h"

@implementation DDAuthAlreadyLoginM

@end

@implementation DDAuthResetPasswordSectionM

@end

@implementation DDAuthLoginDataM
-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    self = [super initWithDictionary:dict error:err];
    return self;
}
-(BOOL)isSent {
    return NO;
}
-(BOOL)shouldForceLogin {
    return NO;
}
-(BOOL)isUserLoggedIn {
    return NO;
}
@end
@implementation DDAuthLoginM

@end
