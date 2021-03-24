//
//  DDCAppConfigManager.m
//  DDCommons
//
//  Created by Syed Qamar Abbas on 30/12/2019.
//

#import "DDCAppConfigManager.h"
#import "DDCCommonParamManager.h"
#import "NSString+DDString.h"
#import "NSMutableURLRequest+DDNSMutableURLRequest.h"
@implementation DDCAppConfigManager
static DDCAppConfigManager *_sharedObject;
+(DDCAppConfigManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDCAppConfigManager alloc]init];
    });
    return _sharedObject;
}
-(void)setApiConfig:(NSDictionary *)api_config andAppConfig:(NSDictionary *)app_config {
    NSError *error;
    DDCAppApiConfigM *api = [[DDCAppApiConfigM alloc]initWithDictionary:api_config error:&error];
    DDCAppConfigM *app = [[DDCAppConfigM alloc]initWithDictionary:app_config error:&error];
    self.api_config = api;
    self.app_config = app;
}
-(NSURLRequest *)helpRequest {
    NSURL *url = self.app_config.HELP_PAGE.urlValue;
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc]initWithURL: url];
    req.HTTPMethod = @"GET";
    NSMutableDictionary *web = DDCCommonParamManager.shared.default_web_parameters.toDictionary.mutableCopy;
    NSMutableDictionary *api = DDCCommonParamManager.shared.default_api_parameters.toDictionary.mutableCopy;
    [api addEntriesFromDictionary:web];
    req.GETParameters = api;
    return req;
}
-(NSString *)deeplinkSchemeFor:(NSString*)host {
    NSString *mainAppScheme = self.app_config.APPLICATION_DEEPLINK_SCHEME;
    return [NSString stringWithFormat:@"%@%@", mainAppScheme.lowercaseString, host.lowercaseString];
}
-(BOOL)isEditConfigAllowed {
    return [NSUserDefaults.standardUserDefaults boolForKey:@"bundle_allow_url_change"];
}
@end
