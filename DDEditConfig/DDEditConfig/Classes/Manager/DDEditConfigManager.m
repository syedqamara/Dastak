//
//  DDEditConfigManager.m
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 06/04/2020.
//

#import "DDEditConfigManager.h"
#import "DDChooseEditOptionVC.h"
#import "DDEditConfigM.h"

@implementation DDEditConfigManager


+(void)openEditConfigurations:(NSArray *)allEditingConfigs onController:(UIViewController *)controller andCallBack:(ControllerCallBack)callBack {
    DDUIRouterM *route = [DDUIRouterM new];
    route.route_link = DD_App_Edit_Configuration;
    route.should_embed_in_nav = NO;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.data = allEditingConfigs;
    route.callback = callBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
+(void)openEditOptions:(NSArray *)allEditingConfigs onController:(UIViewController *)controller andCallBack:(ControllerCallBack)callBack {
    DDEditConfigM *url = [DDEditConfigM configWithTitle:@"App URLS" andDescription:@"Change any urls which are using in Application" andIdentifier:DDEDITCONFIG_URL];
    DDEditConfigM *brk = [DDEditConfigM configWithTitle:@"Break Points" andDescription:@"Enable Break Point on Any Api" andIdentifier:DDEDITCONFIG_BREAK];
    DDEditConfigM *api = [DDEditConfigM configWithTitle:@"Api Configurations" andDescription:@"Change Api Configurations" andIdentifier:DDEDITCONFIG_Api];
    DDUIRouterM *route = [DDUIRouterM new];
    route.route_link = DD_App_Edit_Options;
    route.should_embed_in_nav = YES;
    route.transition = DDUITransitionPresent;
    route.is_animated = YES;
    route.data = @[url, brk, api];
    route.callback = ^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull cont) {
        DDEditConfigM *config = (DDEditConfigM *)data;
        if ([config.identifier isEqualToString:DDEDITCONFIG_URL]) {
            [DDEditConfigManager openEditConfigurations:allEditingConfigs onController:cont andCallBack:callBack];
        }
        else if ([config.identifier isEqualToString:DDEDITCONFIG_BREAK]) {
            [DDEditConfigManager openBreakPointsListOnController:cont andCallBack:callBack];
        }
        
        else if ([config.identifier isEqualToString:DDEDITCONFIG_Api]) {
            [DDEditConfigManager openApiConfigVCOnController:cont andCallBack:callBack];
        }
    };
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

+(void)openJSONEditor:(NSData *)jsonData withTitle:(NSString *)title onController:(UIViewController *)controller andCallBack:(ControllerCallBack)callBack {
    NSMutableDictionary *dict = @{@"title": title}.mutableCopy;
    NSString *jsonStr = [jsonData stringValue];
    if (jsonStr.length == 0) {
        if (callBack != nil) {
            callBack(nil, jsonData, controller);
        }
        return;
    }
    [dict setValue:jsonStr forKey:@"json"];
    DDUIRouterM *route = [DDUIRouterM new];
    route.route_link = DD_App_Edit_JSON;
    route.should_embed_in_nav = YES;
    route.transition = DDUITransitionPresent;
    route.is_animated = YES;
    route.data = dict;
    route.callback = ^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        NSDictionary *editedDictionary = (NSDictionary *)data;
        NSData *editedData = [editedDictionary bv_jsonDataWithPrettyPrint:YES];
        if (callBack != nil) {
            callBack(identifier, editedData, controller);
        }
    };
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

+(void)openBreakPointsListOnController:(UIViewController *)controller andCallBack:(ControllerCallBack)callBack {
    DDUIRouterM *route = [DDUIRouterM new];
    route.route_link = DD_App_Edit_Break_Points;
    route.should_embed_in_nav = NO;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.callback = ^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        
    };
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

+(void)openApiConfigVCOnController:(UIViewController *)controller andCallBack:(ControllerCallBack)callBack {
    DDUIRouterM *route = [DDUIRouterM new];
    route.route_link = DD_App_Edit_Api_Config;
    route.should_embed_in_nav = NO;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.callback = ^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        NSAssert(false, @"Successfully Changed Api Config");
    };
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

+(BOOL)isAlreadyDisplaying {
    UIViewController *topVC = UIApplication.topMostController;
    
    if ([topVC isKindOfClass:UINavigationController.class]) {
        UINavigationController *navVC = (UINavigationController *)topVC;
        return [navVC.viewControllers.firstObject isKindOfClass:DDChooseEditOptionVC.class];
    }
    return NO;
}
@end
