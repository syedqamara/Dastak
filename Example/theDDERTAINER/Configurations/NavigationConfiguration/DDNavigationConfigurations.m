//
//  DDNavigationConfigurations.m
//  theDDERTAINER_Example
//
//  Created by Syed Qamar Abbas on 26/12/2019.
//  Copyright © 2019 etDev24. All rights reserved.
//

#import "DDNavigationConfigurations.h"
#import <DDAuth/DDAuth.h>
#import <DDAuthUI/DDAuthUI.h>
#import "DDTabbarController.h"
#import "DDGetawayPrePopupVC.h"
#import "DDNewsFeedViewController.h"
#import <DDHomeUI.h>
#import <DDSearchUI/DDSearchUI.h>
#import <DDUI/DDUI.h>
#import <DDPingsUI/DDPingsUI.h>
#import <DDAccountsUI.h>
#import <DDFamilyUI/DDFamilyUI.h>
#import <DDCashlessUI/DDCashlessUI.h>
#import <DDProductsUI.h>
#import "DDCashlessUI.h"
#import <DDFiltersUI/DDFiltersUI.h>
#import <DDFavouritesUI/DDFavouritesUI.h>
#import <DDRedemptionsUI/DDRedemptionsUI.h>
#import <DDAccountsUI.h>
#import "DDOutletsUI/DDOutletsUI.h"
#import "DDLocationsUI.h"
#import "DDTravelDestinationsVC.h"
#import "DDEditConfigVC.h"
#import "DDJSONViewController.h"
#import "DDEditConfigAppUIConfiguration.h"
@implementation DDNavigationConfigurations
+(void)loadNavigationConfig {
    
    NSMutableArray <DDUIRouterConfigurationM *>*configurations = [[NSMutableArray alloc]init];
    //All View Controllers Must Be Register Here Before Using Routing System
    
    //Main App Configurations
    [self addMainAppControllersInConfigurations:configurations];
    
    [DDAccountsUIAppUIConfiguration loadUIConfiguration];
    [DDAuthUIAppUIConfiguration loadUIConfiguration];
    [DDCashlessUIAppUIConfiguration loadUIConfiguration];
    [DDEditConfigAppUIConfiguration loadUIConfiguration];
    [DDFamilyUIAppUIConfiguration loadUIConfiguration];
    [DDFavouritesUIAppUIConfiguration loadUIConfiguration];
    [DDFiltersUIAppUIConfiguration loadUIConfiguration];
    [DDHomeUIAppUIConfiguration loadUIConfiguration];
    [DDLocationsUIAppUIConfiguration loadUIConfiguration];
    [DDMapsUIAppUIConfiguration loadUIConfiguration];
    [DDOutletsUIAppUIConfiguration loadUIConfiguration]; // DD_Nav_Outlet_Detail
    [DDPingsUIAppUIConfiguration loadUIConfiguration];
    [DDProductsUIAppUIConfiguration loadUIConfiguration];
    [DDRedemptionsUIAppUIConfiguration loadUIConfiguration];
    [DDSearchUIAppUIConfiguration loadUIConfiguration];
    [DDBaseAppUIConfiguration loadUIConfiguration];
//    [DDUIRouterManager.shared setRouteConfiguration:configurations];
}

+(void)addMainAppControllersInConfigurations:(NSMutableArray <DDUIRouterConfigurationM *>*)configurations {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Main_Tabbar andModuleName:@"" withClassRef:DDTabbarController.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Main_Travel andModuleName:@"" withClassRef:DDGetawayPrePopupVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Main_Notifications andModuleName:@"" withClassRef:DDNewsFeedViewController.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_App_Travel_Destinations andModuleName:@"" withClassRef:DDTravelDestinationsVC.class];
    
}


@end
