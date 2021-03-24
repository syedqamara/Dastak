//
//  DDNavigationConfigurations.m
//  dynamicdelivery_Example
//
//  Created by Syed Qamar Abbas on 26/12/2019.
//  Copyright © 2019 etDev24. All rights reserved.
//

#import "DDNavigationConfigurations.h"
#import <DDAuth/DDAuth.h>
#import <DDAuthUI/DDAuthUI.h>
#import "DDTabbarController.h"
#import <DDUI/DDUI.h>
#import <DDHomeUI.h>
#import <DDLocationsUI.h>
#import "DDEditConfigVC.h"
#import "DDJSONViewController.h"
#import "DDEditConfigAppUIConfiguration.h"
#import <DDSearchUI.h>
#import "DDSplashVC.h"
@implementation DDNavigationConfigurations
+(void)loadNavigationConfig {
    
    NSMutableArray <DDUIRouterConfigurationM *>*configurations = [[NSMutableArray alloc]init];
    //All View Controllers Must Be Register Here Before Using Routing System
    
    //Main App Configurations
    [self addMainAppControllersInConfigurations:configurations];
    
    [DDHomeUIAppUIConfiguration loadUIConfiguration];
    [DDAuthUIAppUIConfiguration loadUIConfiguration];
    [DDEditConfigAppUIConfiguration loadUIConfiguration];
    [DDBaseAppUIConfiguration loadUIConfiguration];
    [DDLocationsUIAppUIConfiguration loadUIConfiguration];
    [DDSearchUIAppUIConfiguration loadUIConfiguration];
//    [DDUIRouterManager.shared setRouteConfiguration:configurations];
}

+(void)addMainAppControllersInConfigurations:(NSMutableArray <DDUIRouterConfigurationM *>*)configurations {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Main_Tabbar andModuleName:@"" withClassRef:DDTabbarController.class];
    [DDSplashVC setRouteConfiguration];
    
}


@end
