//
//  DDTabbarController.m
//  dynamicdelivery_Example
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import "DDTabbarController.h"
#import <DDConstants.h>
#import <DDUI.h>
#import <DDAuth/DDAuth.h>
#import <DDAuthUI/DDAuthUI.h>
#import <DDHomeUI/DDHomeUI.h>

@interface DDTabbarController ()<UITabBarControllerDelegate>

@end

@implementation DDTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = THEME.app_theme.colorValue;
    [self.tabBar setTranslucent:NO];
    self.selectedIndex = 0;
}
-(void)didAddedToWindow {
    DDUIRouterM *home = [[DDUIRouterM alloc]init];
    home.route_link = DD_Nav_Home_Home;
    home.should_embed_in_nav = YES;
    home.transition = DDUITransitionEmbedInTab;
    
    DDUIRouterM *orders = [[DDUIRouterM alloc]init];
    orders.route_link = DD_Nav_Order_History;
    orders.should_embed_in_nav = YES;
    orders.transition = DDUITransitionEmbedInTab;
    
    DDUIRouterM *profile = [[DDUIRouterM alloc]init];
    profile.route_link = DD_Nav_Accounts_Profile;
    profile.should_embed_in_nav = YES;
    profile.transition = DDUITransitionEmbedInTab;
    
    
    DDUIRouterM *send = [[DDUIRouterM alloc]init];
    send.route_link = DD_Nav_Home_Send_Parcel;
    send.should_embed_in_nav = YES;
    send.transition = DDUITransitionEmbedInTab;
    
    DDUIRouterM *fav = [[DDUIRouterM alloc]init];
    fav.route_link = DD_Nav_Favourites_Main;
    fav.should_embed_in_nav = YES;
    fav.transition = DDUITransitionEmbedInTab;
    
    
    [DDUIRouterManager.shared navigateTo:@[home] onController:self];
    [DDUIRouterManager.shared navigateTo:@[orders] onController:self];
    [DDUIRouterManager.shared navigateTo:@[send] onController:self];
    [DDUIRouterManager.shared navigateTo:@[fav] onController:self];
//    [DDUIRouterManager.shared navigateTo:@[notification] onController:self];
    [DDUIRouterManager.shared navigateTo:@[profile] onController:self];
    
    self.delegate = self;
    if (self.navigation.routerModel.deeplinkModel != nil) {
        [self.navigation.routerModel sendDeeplinkCallbackWithData:nil withController:self];
    }
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    if ([tabBarController.viewControllers indexOfObject:viewController] > 0) {
        if (!DDUserManager.shared.isLoggedIn) {
            [self openLoginFromIndex:index];
            return NO;
        }
    }
    return YES;
}
-(void)openLoginFromIndex:(NSInteger)index {
    [DDHomeUIManager.shared openLoginVC:self.selectedViewController onCompletion:^{
        if (DDUserManager.shared.isLoggedIn) {
            [self setSelectedIndex:index];
        }
    }];
}
+(void)createNewTabbar {
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = DD_Nav_Main_Tabbar;
    route.should_embed_in_nav = NO;
    route.transition = DDUITransitionWindows;
    [DDUIRouterManager.shared navigateTo:@[route] onController:nil];
}

+(NSArray <DDUIRouterM *>*)deeplinkRoutes {
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = DD_Nav_Main_Tabbar;
    route.transition = DDUITransitionWindows;
    return @[route];
}

@end

