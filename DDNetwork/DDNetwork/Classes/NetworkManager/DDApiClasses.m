//
//  DDApiRouterM.m
//  ApiRouter
//
//  Created by mac on 26/12/2019.
//

#import "DDApiClasses.h"
#import "DDBaseApiManager.h"
#import "DDNetworkManager.h"



@implementation DDApisConfiguration
+(void)registerConfigurations:(DDApisType)identifier classObj:(Class)cls responseClassObj:(Class)rspCls selector:(SEL)selector endPoint:(NSString *)endPoint isEncryptedEnabled:(BOOL)isEncrypted isSSLPinningEnabled:(BOOL)isSSLEnabled authorizationType:(DDApiAuthorizationType)authType {
    DDApisConfiguration *temp = [[DDApisConfiguration alloc]init];
    temp.identifier = identifier;
    temp.class_object = cls;
    temp.response_class_object = rspCls;
    temp.selector_name = NSStringFromSelector(selector);
    temp.end_point = endPoint;
    temp.is_encrypted = isEncrypted;
    temp.is_ssl_pinning = isSSLEnabled;
    temp.api_auth_type = authType;
    
    NSDictionary *dict = [NSUserDefaults.standardUserDefaults objectForKey:identifier];
    if (dict.count > 0) {
        if ([dict.allKeys containsObject:@"end_point"]) {
            temp.end_point = dict[@"end_point"];
        }
        if ([dict.allKeys containsObject:@"is_encrypted"]) {
            temp.is_encrypted = ((NSNumber *)dict[@"is_encrypted"]).boolValue;
        }
        if ([dict.allKeys containsObject:@"is_ssl_pinning"]) {
            temp.is_ssl_pinning = ((NSNumber *)dict[@"is_ssl_pinning"]).boolValue;
        }
        if ([dict.allKeys containsObject:@"is_static_api"]) {
            temp.is_static_api = ((NSNumber *)dict[@"is_static_api"]).boolValue;
        }
    }
    [DDNetworkManager.shared addConfiguration:temp forApi:identifier];
}
-(id)copy {
    DDApisConfiguration *temp = [[DDApisConfiguration alloc]init];
    temp.identifier = self.identifier;
    temp.class_object = self.class_object;
    temp.response_class_object = self.response_class_object;
    temp.selector_name = self.selector_name;
    temp.end_point = self.end_point;
    temp.is_encrypted = self.is_encrypted;
    temp.is_ssl_pinning = self.is_ssl_pinning;
    temp.is_static_api = self.is_static_api;
    temp.api_auth_type = self.api_auth_type;
    return temp;
}
-(NSDictionary *)cacheDict {
    return @{@"identifier":self.identifier, @"end_point": self.end_point, @"is_encrypted": @(self.is_encrypted), @"is_ssl_pinning": @(self.is_ssl_pinning), @"is_static_api": @(self.is_static_api)};
}
@end

@implementation DDApiRequest
-(instancetype)init {
    self = [super init];
    self.show_hud = YES;
    self.params = [[NSMutableDictionary alloc]init];
    return self;
}

@end
