//
//  DDBaseApiModel.m
//  DDCommons
//
//  Created by Syed Qamar Abbas on 08/01/2020.
//

#import "DDBaseApiModel.h"

@implementation DDBaseApiModel

- (BOOL)successfulApi {
    return (self.status != nil && self.status.boolValue) || (self.http_code != nil && self.http_code.integerValue == 200);
}

- (NSError *)apiError {
    NSError *error = [NSError errorWithDomain:@"" code:self.http_code userInfo:@{NSLocalizedDescriptionKey:self.message}];
    return error;
}

@end
