//
//  DDUIWebViewVM.m
//  DDUI
//
//  Created by M.Jabbar on 16/01/2020.
//

#import "DDUIWebViewVM.h"

@interface DDUIWebActions () {
    NSString *action_url;
}


@end

@implementation DDUIWebActions


-(instancetype)initWithURL:(NSString *)url {
    self = [super init];
    self.url = url;
    return self;
}

-(void)setUrl:(NSString *)url {
    action_url = url;
    if (action_url.length > 0) {
        self.parameters = action_url.paramsWithLowercaseKey;
    }
}
-(NSString *)url {
    return action_url;
}

-(DDUIWebActionType)type {
    
    if ([self.parameters.allKeys containsObject:DD_WEB_OPEN_LOGIN]) {
        return DDUIWebActionTypeLogin;
    }
    if ([self.parameters.allKeys containsObject:DD_WEB_CLOSE_VIEW]) {
        id value = self.parameters[DD_WEB_CLOSE_VIEW];
        if ([value isKindOfClass:NSString.class]) {
            NSString *valueObj = value;
            if (valueObj.boolValue) {
                return DDUIWebActionTypeBack;
            }
        }
        if ([value isKindOfClass:NSNumber.class]) {
            NSNumber *valueObj = value;
            if (valueObj.boolValue) {
                return DDUIWebActionTypeBack;
            }
        }
    }
    if ([self.parameters.allKeys containsObject:DD_WEB_OPEN_SAFARI]) {
        return DDUIWebActionTypeOpenSafari;
    }
    if ([self.parameters.allKeys containsObject:DD_WEB_IS_OPEN_SAFARI]) {
        return DDUIWebActionTypeOpenSafari;
    }
    if ([self.parameters.allKeys containsObject:DD_WEB_OPEN_SUCCESS]) {
        return DDUIWebActionTypeComplete;
    }
    if ([self.parameters.allKeys containsObject:DD_WEB_OPEN_PRODUCT_MERCHANTS]) {
        return DDUIWebActionTypeProductList;
    }
    if ([self.parameters.allKeys containsObject:DD_WEB_OPEN_DEEPLINK]) {
        return DDUIWebActionTypeDeeplink;
    }
    if ([self.parameters.allKeys containsObject:DD_WEB_IS_ANALYTICS]) {
        return DDUIWebActionTypeAnalytics;
    }
    if ([self.url containsString:@"dynamicdelivery://"]) {
        return DDUIWebActionTypeDeeplink;
    }
    if ([self.url containsString:@"blank"]) {
        return DDUIWebActionTypeForceStop;
    }
    return DDUIWebActionTypeUnknown;
}
-(BOOL)hasAction:(NSString *)key {
    return [self.parameters.allKeys containsObject:key];
}
@end


@implementation DDUIWebViewVM
-(instancetype)init {
    self = [super init];
    self.is_animated = YES;
    return self;
}
-(void)setRequest:(NSURLRequest *)request {
    _request = request;
}
@end
