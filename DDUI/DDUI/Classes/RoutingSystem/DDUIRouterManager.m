//
//  DDUIRouterManager.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 26/12/2019.
//

#import "DDUIRouterManager.h"

@interface DDUIRouterManager()
@property (strong, nonatomic) NSMutableDictionary <NSString *, DDUIRouterConfigurationM *> *all_configuration;
@property (strong, nonatomic) NSMutableArray <DDUIRouterInfoM *> *navigation_stack;
@property (strong, nonatomic) NSMutableArray <DDUIRouterInfoM *> *deeplink_navigation_stack;
@end

@implementation DDUIRouterManager
static DDUIRouterManager *_sharedObject;
+(DDUIRouterManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDUIRouterManager alloc]init];
    });
    return _sharedObject;
}
-(instancetype)init {
    self = [super init];
    self.all_configuration = [[NSMutableDictionary alloc]init];
    self.navigation_stack = [[NSMutableArray alloc]init];
    self.deeplink_navigation_stack = [[NSMutableArray alloc]init];
    return self;
}
-(void)displayOn:(UIViewController *)viewController {
    DDUIRouterInfoM *info = self.navigation_stack.lastObject;
    if (info != nil) {
        __block void (^deeplinkInvokingCallback)(id data, UIViewController *controller) = info.routerModel.deeplinkCallBack;
        info.routerModel.deeplinkCallBack = ^(id  _Nonnull data, UIViewController * _Nonnull controller) {
            if (deeplinkInvokingCallback != nil) {
                deeplinkInvokingCallback(data, controller);
            }
            NSDictionary *dict = (NSDictionary *)data;
            if (dict != nil && dict.count > 0) {
                [self.navigation_stack.lastObject.routerModel.deeplinkModel.all_params addEntriesFromDictionary:dict];
            }
            [self displayOn:controller];
        };
        [self.navigation_stack removeLastObject];
        [info startTransitionOn:viewController withCompletion:^{
            if (info.routerModel.transitionCallBack != nil) {
                info.routerModel.transitionCallBack();
            }
        }];
    }
}
-(void)displayDeeplinkOn:(UIViewController *)viewController {
    DDUIRouterInfoM *info = self.deeplink_navigation_stack.lastObject;
    if (info != nil) {
        __block void (^deeplinkInvokingCallback)(id data, UIViewController *controller) = info.routerModel.deeplinkCallBack;
        info.routerModel.deeplinkCallBack = ^(id  _Nonnull data, UIViewController * _Nonnull controller) {
            if (deeplinkInvokingCallback != nil) {
                deeplinkInvokingCallback(data, controller);
            }
            NSDictionary *dict = (NSDictionary *)data;
            if (dict != nil && dict.count > 0) {
                [self.navigation_stack.lastObject.routerModel.deeplinkModel.all_params addEntriesFromDictionary:dict];
            }
            [self displayDeeplinkOn:controller];
        };
        [self.deeplink_navigation_stack removeLastObject];
        [info startTransitionOn:viewController withCompletion:^{
            if (info.routerModel.transitionCallBack != nil) {
                info.routerModel.transitionCallBack();
            }
        }];
    }
}
-(void)navigateTo:(NSArray <DDUIRouterM *> *)params onController:(UIViewController *)controller {
    NSMutableArray <DDUIRouterInfoM *>*allRouteInfos = [[NSMutableArray alloc]init];
    for (NSInteger index=0; index < params.count; index++) {
        DDUIRouterM *routeModel = params[index];
        DDUIRouterConfigurationM *config = self.all_configuration[routeModel.route_link];
        if (config == nil) {
            NSAssert(false, @"DDCrash: Failed to load Configurations");
        }
        DDUIRouterInfoM *routeInfo = [[DDUIRouterInfoM alloc] initWithConfiguration:config andRouteModel:routeModel];
        [allRouteInfos insertObject:routeInfo atIndex:0];
    }
    self.navigation_stack = allRouteInfos;
    [self displayOn:controller];
    
}
-(void)navigateDeeplinkTo:(NSArray <DDUIRouterM *> *)params onController:(UIViewController *)controller {
    NSMutableArray <DDUIRouterInfoM *>*allRouteInfos = [[NSMutableArray alloc]init];
    for (NSInteger index=0; index < params.count; index++) {
        DDUIRouterM *routeModel = params[index];
        DDUIRouterConfigurationM *config = self.all_configuration[routeModel.route_link];
        DDUIRouterInfoM *routeInfo = [[DDUIRouterInfoM alloc] initWithConfiguration:config andRouteModel:routeModel];
        [allRouteInfos insertObject:routeInfo atIndex:0];
    }
    if (allRouteInfos.count > 0) {
        self.deeplink_navigation_stack = allRouteInfos;
    }
    [self displayDeeplinkOn:controller];
    
}
-(void)setRouteConfiguration:(NSArray<DDUIRouterConfigurationM *> *)configurations {
    for (DDUIRouterConfigurationM *config in configurations) {
        [self.all_configuration setObject:config forKey:config.route_name];
    }
}
-(void)addRouteToConfiguration:(DDUIRouterConfigurationM *)config {
    [self.all_configuration setObject:config forKey:config.route_name];
}
-(DDUIRouterConfigurationM *)configForID:(NSString *)configID {
    if ([self.all_configuration.allKeys containsObject:configID]) {
        return self.all_configuration[configID];
    }
    return nil;
}

@end
