//
//  DDDeeplinkConfig.m
//  theDDERTAINER_Example
//
//  Created by Syed Qamar Abbas on 29/01/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import "DDDeeplinkConfig.h"
#import "DDCashlessUI.h"
#import <DDUI/DDUI.h>
#import "DDDeepLinkUtils.h"
#import "DDTabbarController.h"
#import <DDAccountsUI.h>
#import <DDHomeUI.h>
#import <DDSearchUI.h>
#import <DDCashlessUI.h>
#import <DDPingsUI/DDPingsUI.h>
#import <DDFamilyUI/DDFamilyUI.h>
#import <DDRedemptionsUI/DDRedemptionsUI.h>

@interface DDDeeplinkConfig ()

@end

@implementation DDDeeplinkConfig
+(void)configureDeeplinkToRouteLinkTranslator {
    NSMutableDictionary <NSString *,NSArray <DDUIRouterM *>*> *deeplinks = [[NSMutableDictionary alloc]init];
    deeplinks[ALLOFFERS_SCHEME] = [self allOffersRoutes];
    deeplinks[PRODUCT_DETAIL_SCHEME] = [self productDetail];
    deeplinks[PRODUCT_LISTING_SCHEME] = [self productDetail];
    deeplinks[HOME_SCHEME] = [self home];
    deeplinks[FILTER_SEARCH_SCHEME] = [self filterSearch];
    deeplinks[CUSTOM_FILTER_SEARCH_SCHEME] = [self filterSearch];
    deeplinks[SEARCH_SCHEME] = [self filterSearch];
    deeplinks[MY_FAMILY_SCHEME] = [self myFamily];
    deeplinks[PINGSHISTORY_SCHEME] = [self pingsHistory];
    deeplinks[MYINFORMATION_SCHEME] = [self myInformation];
    deeplinks[HELP_SCHEME] = [self help];
    deeplinks[RESERVATION_HISTORY] = [self reservationHistory];
    deeplinks[MYPROFILE_SCHEME] = [self myProfile];
    deeplinks[SAVINGS_SCHEME] = [self mySavings];
    
    deeplinks[FEEDBACK_SCHEME] = [self feedbackRoute];
    deeplinks[TRIAL_INFO] = [self trialInfo];
    deeplinks[LOCATIONS_SCHEME] = [self appLocations];
    deeplinks[YOUTUBE_VIDEO] = [self youtubeRoute];
    deeplinks[CASHLESS_MERCHANTDETAILPAGE_SCHEME] = [self cashlessMerchantDetail];
    deeplinks[DELIVERY_SCHEME] = [self openDelivery];
    deeplinks[CASHLESS_ORDER_STATUS] = [DDOrderStatusVC deeplinkRoutes];
    DDDeepLinkUtils.sharedInstance.configurations = deeplinks;
}
+(NSArray <DDUIRouterM *>*)openDelivery {
    return DDCashlessOutletListingContainerVC.deeplinkRoutes;
}
+(NSArray <DDUIRouterM *>*)cashlessMerchantDetail {
    return DDCashlessMerchantDetailVC.deeplinkRoutes;
}

+(NSArray <DDUIRouterM *>*)youtubeRoute {
    DDUIRouterM *r1 = [[DDUIRouterM alloc]init];
    r1.route_link = DD_Nav_UI_Youtube_Player;
    r1.transition = DDUITransitionPresent;
    r1.is_animated = YES;
    r1.should_embed_in_nav = NO;
    return @[r1];
}
+(NSArray <DDUIRouterM *>*)feedbackRoute {
    DDUIRouterM *r1 = [[DDUIRouterM alloc]init];
    r1.route_link = DD_Nav_Accounts_Feedback;
    r1.transition = DDUITransitionPush;
    r1.is_animated = YES;
    r1.should_embed_in_nav = NO;
    return @[r1];
}
+(NSArray <DDUIRouterM *>*)trialInfo {
    DDUIRouterM *r1 = [[DDUIRouterM alloc]init];
    DDUIRouterM *r2 = [[DDUIRouterM alloc]init];
    DDUIRouterM *r3 = [[DDUIRouterM alloc]init];
    
    r1.route_link = DD_Nav_Main_Tabbar;
    r2.route_link = DD_Nav_Home_Home;
    r3.route_link = DD_Nav_Home_TrialInfo;
    
    r1.transition = DDUITransitionWindows;
    r2.transition = DDUITransitionTabs;
    r3.transition = DDUITransitionPresent;
    
    r1.is_animated = YES;
    r2.is_animated = YES;
    r3.is_animated = YES;
    
    r3.should_embed_in_nav = NO;
    return @[r1,r2,r3];
}
+(NSArray <DDUIRouterM *>*)allOffersRoutes {
    DDUIRouterM *r1 = [[DDUIRouterM alloc]init];
    DDUIRouterM *r2 = [[DDUIRouterM alloc]init];
    DDUIRouterM *r3 = [[DDUIRouterM alloc]init];
    DDUIRouterM *r4 = [[DDUIRouterM alloc]init];
    DDUIRouterM *r5 = [[DDUIRouterM alloc]init];
    
    r1.route_link = DD_Nav_Main_Tabbar;
    r2.route_link = DD_Nav_Home_Home;
    r3.route_link = DD_Nav_Auth_Login;
    r4.route_link = DD_Nav_Auth_Login;
    r5.route_link = DD_Nav_Auth_Login;
    
    r1.transition = DDUITransitionWindows;
    r2.transition = DDUITransitionTabs;
    r3.transition = DDUITransitionPresent;
    r4.transition = DDUITransitionPush;
    r5.transition = DDUITransitionPresent;
    
    r1.is_animated = YES;
    r2.is_animated = YES;
    r3.is_animated = YES;
    r4.is_animated = YES;
    r5.is_animated = YES;
    
    
    r3.should_embed_in_nav = YES;
    r5.should_embed_in_nav = YES;
    
    return @[r1,r2];
}

+(NSArray <DDUIRouterM *>*)productDetail {
    DDUIRouterM *r1 = [[DDUIRouterM alloc]init];
    DDUIRouterM *r2 = [[DDUIRouterM alloc]init];
    DDUIRouterM *r3 = [[DDUIRouterM alloc]init];
    
    r1.route_link = DD_Nav_Main_Tabbar;
    r2.route_link = DD_Nav_Home_Home;
    r3.route_link = DD_Nav_UI_Web_View_Product;
    
    r1.transition = DDUITransitionWindows;
    r2.transition = DDUITransitionTabs;
    r3.transition = DDUITransitionPresent;
    
    r1.is_animated = YES;
    r2.is_animated = YES;
    
    r3.should_embed_in_nav = YES;
    
    DDUIWebViewVM *webModel = [[DDUIWebViewVM alloc]init];
    webModel.webType = DDUIWebViewTypeProductCart;
    r3.data = webModel;
    r3.is_animated = YES;
    
    return @[r3];
}
+(NSArray <DDUIRouterM *>*)home {
    DDUIRouterM *r1 = [DDTabbarController deeplinkRoutes].firstObject;
    DDUIRouterM *r2 = [DDHomeVC deeplinkRoutes].firstObject;
    r2.select_tab_tabbar_controller = YES;
    return @[r1,r2];
}
+(NSArray <DDUIRouterM *>*)filterSearch {
    DDUIRouterM *r1 = [DDTabbarController deeplinkRoutes].firstObject;
    DDUIRouterM *r2 = [DDHomeVC deeplinkRoutes].firstObject;
    DDUIRouterM *r3 = [DDDeeplinkSearchViewController deeplinkRoutes].firstObject;
    r2.select_tab_tabbar_controller = YES;
    return @[r1,r2, r3];
}
+(NSArray <DDUIRouterM *>*)myInformation {
    DDUIRouterM *r1 = [DDTabbarController deeplinkRoutes].firstObject;
    DDUIRouterM *r2 = [DDProfileViewController deeplinkRoutes].firstObject;
    DDUIRouterM *r3 = [DDSettingsViewController deeplinkRoutes].firstObject;
    DDUIRouterM *r4 = [DDAccountViewController deeplinkRoutes].firstObject;
    r2.select_tab_tabbar_controller = YES;
    
    return @[r1,r2,r3,r4];
}
+(NSArray <DDUIRouterM *>*)help {
    DDUIRouterM *r1 = [DDTabbarController deeplinkRoutes].firstObject;
    DDUIRouterM *r2 = [DDProfileViewController deeplinkRoutes].firstObject;
    DDUIRouterM *r3 = [DDSettingsViewController deeplinkRoutes].firstObject;
    DDUIRouterM *r4 = [DDUIWebViewController deeplinkRoutes].firstObject;
    
    DDUIWebViewVM *webView = [DDUIWebViewVM new];
    webView.request = DDCAppConfigManager.shared.helpRequest;
    webView.title = @"Help & Live Chat".localized;
    webView.webType = DDUIWebViewTypeGeneral;
    r4.data = webView;
    
    r2.select_tab_tabbar_controller = YES;
    
    return @[r1,r2,r3,r4];
}
+(NSArray <DDUIRouterM *>*)pingsHistory {
    DDUIRouterM *r1 = [DDTabbarController deeplinkRoutes].firstObject;
    DDUIRouterM *r2 = [DDProfileViewController deeplinkRoutes].firstObject;
    DDUIRouterM *r3 = [DDSettingsViewController deeplinkRoutes].firstObject;
    DDUIRouterM *r4 = [DDPingsHistoryVC deeplinkRoutes].firstObject;
    r2.select_tab_tabbar_controller = YES;
    
    return @[r1,r2,r3,r4];
}

+(NSArray <DDUIRouterM *>*)myFamily {
    DDUIRouterM *r1 = [DDTabbarController deeplinkRoutes].firstObject;
    DDUIRouterM *r2 = [DDProfileViewController deeplinkRoutes].firstObject;
    DDUIRouterM *r3 = [DDSettingsViewController deeplinkRoutes].firstObject;
    DDUIRouterM *r4 = [DDMyFamilyVC deeplinkRoutes].firstObject;
    r2.select_tab_tabbar_controller = YES;
    
    return @[r1,r2,r3,r4];
}

+(NSArray <DDUIRouterM *>*)appLocations {
    
    DDUIRouterM *r1 = [DDTabbarController deeplinkRoutes].firstObject;
    DDUIRouterM *r2 = [DDProfileViewController deeplinkRoutes].firstObject;
    DDUIRouterM *r3 = [DDSettingsViewController deeplinkRoutes].firstObject;
    DDUIRouterM *r4 = [DDAppLocationsVC deeplinkRoutes].firstObject;
    r2.select_tab_tabbar_controller = YES;
    return @[r1,r2,r3,r4];
}

+(NSArray <DDUIRouterM *>*)reservationHistory {
    DDUIRouterM *r1 = [DDTabbarController deeplinkRoutes].firstObject;
    DDUIRouterM *r2 = [DDProfileViewController deeplinkRoutes].firstObject;
    DDUIRouterM *r3 = [DDSettingsViewController deeplinkRoutes].firstObject;
    DDUIRouterM *r4 = [DDReservationHistoryVC deeplinkRoutes].firstObject;
    r2.select_tab_tabbar_controller = YES;
    
    return @[r1,r2,r3,r4];
}

+(NSArray <DDUIRouterM *>*)myProfile {
    DDUIRouterM *r1 = [DDTabbarController deeplinkRoutes].firstObject;
    DDUIRouterM *r2 = [DDProfileViewController deeplinkRoutes].firstObject;
    r2.select_tab_tabbar_controller = YES;
    return @[r1,r2];
}


+(NSArray <DDUIRouterM *>*)mySavings {
    DDUIRouterM *r1 = [DDTabbarController deeplinkRoutes].firstObject;
    DDUIRouterM *r2 = [DDProfileViewController deeplinkRoutes].firstObject;
    DDUIRouterM *r3 = [DDSavingsViewController deeplinkRoutes].firstObject;
    r2.select_tab_tabbar_controller = YES;
    return @[r1,r2, r3];
}

@end
