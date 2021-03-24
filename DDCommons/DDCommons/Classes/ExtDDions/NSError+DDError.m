//
//  NSError+DDSEError.m
//  DDSE_Example
//
//  Created by Raheel on 06/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//

#import "NSError+DDError.h"
//#import "DDSEMessagesUtil.h"

#define TR_NETWORK_ERROR_CODE -1009

typedef NS_ENUM(NSInteger, DDSEErrorCode) {
    DDSEErrorCodeInvalidCredentials    = 0x1001,
    DDSEErrorCodeNeedsRegistration     = 0x1005
};

NSString * const DDSEErrorDomain = @"com.dynamicdelivery";
NSString * const DDSEAPIErrorDomain = @"com.dynamicdelivery.api";

@implementation DDSEAPIError

+ (DDSEAPIError *)initWithDDSEAPIError:(NSString *)title error:(NSError *)error
{
    DDSEAPIError *errorTemp = [[DDSEAPIError alloc] init];
    errorTemp.title = title;
    errorTemp.errorObject = error;
    return errorTemp;
}

-(NSString *) localizedDescription{
    return self.errorObject.localizedDescription.description;
//    return @"";
}

@end

@implementation NSError (DDSEError)

+ (DDSEAPIError *)errorWithDDSEAPIError:(NSError *)error {
    
    NSString *recoverySuggestion = error.userInfo[@"NSLocalizedRecoverySuggestion"];
    if (recoverySuggestion) {
        
        NSError *e;
        NSData *errorData = [recoverySuggestion dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *errorDict = [NSJSONSerialization JSONObjectWithData:errorData options:0 error:&e];
        NSInteger code = [errorDict[@"code"] integerValue];
        if (code == 403){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SDKLogoutCallBack" object:nil];
            return [DDSEAPIError initWithDDSEAPIError:nil error:[[NSError alloc] initWithDomain:DDSEAPIErrorDomain code:code userInfo:@{ NSLocalizedDescriptionKey : @""}]];
        }
        NSString *message;
        NSArray *errors = errorDict[@"errors"];
        if (errors.count > 0)
            message = errors[0];
        else
            message = errorDict[@"message"];
        
        if([message isKindOfClass:[NSNumber class]])
            message=@"";
        if (message) {
            return [DDSEAPIError initWithDDSEAPIError:nil error:[[NSError alloc] initWithDomain:DDSEAPIErrorDomain code:code userInfo:@{ NSLocalizedDescriptionKey : message}]];
        } else {
            
            if (code == -1004 || code == TR_NETWORK_ERROR_CODE || code == -1003 || code == -1005) {
                NSString *message = @"";//[[DDSEMessagesUtil sharedInstance] internetDisconnectionMessage];
                return [DDSEAPIError initWithDDSEAPIError:nil error:[[NSError alloc] initWithDomain:NSURLErrorDomain code:error.code userInfo:@{ NSLocalizedDescriptionKey : message}]] ;
            }
            return [DDSEAPIError initWithDDSEAPIError:nil error:[[NSError alloc] initWithDomain:DDSEAPIErrorDomain code:code userInfo:@{ NSLocalizedDescriptionKey : recoverySuggestion}]];
        }
        
    } else if (error.code == -1004 || error.code == TR_NETWORK_ERROR_CODE || error.code == -1003 || error.code == -1005) {
        NSString *message = @"";//[[DDSEMessagesUtil sharedInstance] internetDisconnectionMessage];
        return [DDSEAPIError initWithDDSEAPIError:nil error:[[NSError alloc] initWithDomain:NSURLErrorDomain code:error.code userInfo:@{ NSLocalizedDescriptionKey : message}]];
    }
    
    NSString *message = @"";//[[DDSEMessagesUtil sharedInstance] networkErrorMessage];
    return [DDSEAPIError initWithDDSEAPIError:nil error:[[NSError alloc] initWithDomain:NSURLErrorDomain code:error.code userInfo:@{ NSLocalizedDescriptionKey : message}]];
}

+ (DDSEAPIError *)errorWithDDSEInternetError {
    NSString *message = @"";//[[DDSEMessagesUtil sharedInstance] internetDisconnectionMessage];
    NSString *title = @"";//[[DDSEMessagesUtil sharedInstance] networkErrorMessageTitle];
    return [DDSEAPIError initWithDDSEAPIError:title error:[[NSError alloc] initWithDomain:NSURLErrorDomain code:TR_NETWORK_ERROR_CODE userInfo:@{ NSLocalizedDescriptionKey : message}]];
}


@end
