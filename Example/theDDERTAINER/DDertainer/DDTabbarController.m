//
//  DDTabbarController.m
//  theDDERTAINER_Example
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import "DDTabbarController.h"
#import <DDConstants.h>
#import <DDUI.h>
#import <DDHomeUI.h>
#import <DDAuth/DDAuth.h>
#import <DDAuthUI/DDAuthUI.h>
#import <DDAccountsUI/DDAccountsUI.h>
#import "DDGetawayPrePopupVC.h"

@interface DDTabbarController ()<UITabBarControllerDelegate>

@end

@implementation DDTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setTranslucent:NO];
    self.selectedIndex = 0;
}
-(void)didAddedToWindow {
    DDUIRouterM *home = [[DDUIRouterM alloc]init];
    home.route_link = DD_Nav_Home_Home;
    home.should_embed_in_nav = YES;
    home.transition = DDUITransitionEmbedInTab;
    
    DDUIRouterM *travel = [[DDUIRouterM alloc]init];
    travel.route_link = DD_Nav_Main_Travel;
    travel.should_embed_in_nav = YES;
    travel.transition = DDUITransitionEmbedInTab;
    
    DDUIRouterM *fav = [[DDUIRouterM alloc]init];
    fav.route_link = DD_Nav_Favourites_Main;
    fav.should_embed_in_nav = YES;
    fav.transition = DDUITransitionEmbedInTab;

    DDUIRouterM *notification = [[DDUIRouterM alloc]init];
    notification.route_link = DD_Nav_Main_Notifications;
    notification.should_embed_in_nav = YES;
    notification.transition = DDUITransitionEmbedInTab;
    
    DDUIRouterM *profile = [[DDUIRouterM alloc]init];
    profile.route_link = DD_Nav_Accounts_Profile;
    profile.should_embed_in_nav = YES;
    profile.transition = DDUITransitionEmbedInTab;
    
    [DDUIRouterManager.shared navigateTo:@[home] onController:self];
    [DDUIRouterManager.shared navigateTo:@[travel] onController:self];
    [DDUIRouterManager.shared navigateTo:@[fav] onController:self];
    [DDUIRouterManager.shared navigateTo:@[notification] onController:self];
    [DDUIRouterManager.shared navigateTo:@[profile] onController:self];
    
    self.delegate = self;
    if (self.navigation.routerModel.deeplinkModel != nil) {
        [self.navigation.routerModel sendDeeplinkCallbackWithData:nil withController:self];
    }
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if(tabBarController.selectedIndex == 1){
        //UINavigationController *navcontroller = (UINavigationController *)viewController;
        //DDFeedsRedHistViewController *controller = [navcontroller.viewControllers firstObject];
        //[controller restoreToFirstIndex];
    }
    
//    if(self.previousIndex == tabBarController.selectedIndex  && self.previousIndex==0){
//
//        [self dismissViewControllerAnimated:YES completion:nil];
//
//    } else if (tabBarController.selectedIndex == 4){
        
//        if(![DDUserManager shared].isLoggedIn){
//
//            [self showSignViewController];
//
//        } else if(tabBarController.selectedIndex == 1){
//
//            //[[DDTabbarNavigationUtil sharedInstance] reloadMyStatusData:viewController];
//
//        }
//    } else if(tabBarController.selectedIndex == 4){
//        /*DDProductsMainViewController *productsController = [((UINavigationController *) viewController).viewControllers firstObject];
//         [productsController refreshProductList];*/
//    }
//
    
    
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    UINavigationController *navController = (UINavigationController*)viewController;
    if ([navController.visibleViewController isKindOfClass:[DDHomeVC class]]) return YES;
    if ([navController.visibleViewController isKindOfClass:[DDGetawayPrePopupVC class]]) return YES;
    if (navController && ![DDUserManager shared].isLoggedIn) {
        [self showSignViewController:navController];
        self.selectedIndex = self.selectedIndex;
        return NO;
    }
    return YES;
}
-(void)showSignViewController:(UINavigationController*)controller{
    __weak __typeof(self) weakSElf = self;
    [DDAuthUIManager showLoginScreenOnController:self WithcallBack:^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:NO completion:nil];
        if ([DDUserManager shared].isLoggedIn) {
            [UIApplication refreshAppWithParams:nil];
            NSUInteger index = [weakSElf.viewControllers indexOfObject:controller];
            weakSElf.selectedIndex = index;
        }
    }];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    BOOL isLoggedIn = [[DDUserManager shared] isLoggedIn];
    if (selectedIndex > 0 && !isLoggedIn) {
        UINavigationController *navController = [self.viewControllers objectAtIndex:selectedIndex];
        [self showSignViewController:navController];
    }
    else {
        [super setSelectedIndex:selectedIndex];
    }
}

+(void)createNewTabbar {
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = DD_Nav_Main_Tabbar;
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
