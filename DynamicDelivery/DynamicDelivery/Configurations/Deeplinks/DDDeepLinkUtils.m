//
//  DDDeepLinkUtils.m
//  Thedynamicdelivery
//
//  Created by Raheel Ahmad on 5/2/16.
//  Copyright © 2016 Future Workshops. All rights reserved.
//



#import "DDDeepLinkUtils.h"
#import <DDCommons.h>
#import "DDAuthUI.h"
#import "DDModels.h"
#import "DDHomeUI.h"


@interface DDDeepLinkUtils(){
    DPLDeepLinkRouter *router;
}
@end

@implementation DDDeepLinkUtils

+(DDDeepLinkUtils *) sharedInstance {
    static DDDeepLinkUtils *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[DDDeepLinkUtils alloc] init];
    });
    return _sharedInstance;
}

-(id)init{
    if (self=[super init]) {
        router = [[DPLDeepLinkRouter alloc] init];
        [self registerSchemes];
    }
    return self;
}
-(BOOL)haveAnyTabbar:(NSMutableArray <DDUIRouterM *>*)routes {
    for (DDUIRouterM *route in routes) {
        if (route.transition == DDUITransitionTabs) {
            return YES;
        }
    }
    return NO;
}

-(DDDeeplinkModel*)deeplinkModelFrom:(DPLDeepLink*)link {
    NSError *err;
    DDDeeplinkModel *model = [[DDDeeplinkModel alloc] initWithDictionary:link.queryParameters error:&err];
    model.all_params = link.queryParameters.mutableCopy;
    if (model.all_params == nil) {
        model.all_params = [NSMutableDictionary new];
    }
    model.host = link.URL.host;
    return model;
}
-(void)openAuth:(NSArray <DDUIRouterM *> *)routes {
    [DDAuthUIManager showLoginScreenOnController:UIApplication.topMostController WithcallBack:^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
        if (DDUserManager.shared.isLoggedIn) {
            [DDUIRouterManager.shared navigateDeeplinkTo:routes onController:UIApplication.topMostController];
        }
    }];
}

-(void)checkDeeplinksForLink:(DPLDeepLink *)link {
    BOOL shouldOpenAuth = NO;
    NSString *deeplink = [link.URL.absoluteString componentsSeparatedByString:@"?"].firstObject;
    deeplink = [deeplink.lowercaseString removeString:DDCAppConfigManager.shared.app_config.APPLICATION_DEEPLINK_SCHEME.lowercaseString];
    NSArray <DDUIRouterM *>*routes = self.configurations[deeplink];
    NSMutableArray *deeplinkRoutes = [[NSMutableArray alloc]init];
    for (DDUIRouterM *route in routes) {
        if (route.auth_permission != DDUIRouterAuthPermissionTypeProceed && !DDUserManager
            .shared.isLoggedIn) {
            if (route.auth_permission == DDUIRouterAuthPermissionTypeStop) {
                return ;
            }
            shouldOpenAuth = YES;
        }
        DDUIRouterM *r = [route copy];
        r.deeplinkModel = [self deeplinkModelFrom:link];
        [deeplinkRoutes addObject:r];
        
        
    }
    
    
    if ([link.queryParameters.allKeys containsObject:@"ref_app"]) {
        NSString *shouldRefreshApp = link.queryParameters[@"ref_app"];
        if (!shouldRefreshApp.boolValue) {
            if ([self haveAnyTabbar:deeplinkRoutes]) {
                [deeplinkRoutes removeObjectAtIndex:0];
                if (shouldOpenAuth) {
                    [self openAuth:deeplinkRoutes];
                }else {
                    [DDUIRouterManager.shared navigateDeeplinkTo:deeplinkRoutes onController:UIApplication.topMostController];
                }
                
            }else {
                if (shouldOpenAuth) {
                    [self openAuth:deeplinkRoutes];
                }else {
                    [DDUIRouterManager.shared navigateDeeplinkTo:@[deeplinkRoutes.lastObject] onController:UIApplication.topMostController];
                }
                
            }
            return;
        }
    }
    if (shouldOpenAuth) {
        [self openAuth:deeplinkRoutes];
    }else {
        [DDUIRouterManager.shared navigateDeeplinkTo:deeplinkRoutes onController:UIApplication.topMostController];
    }
}

-(void) registerSchemes{
    __weak typeof(self) weakSelf = self;
    void (^deeplinkCompletionHandler)(DPLDeepLink *link) = ^(DPLDeepLink *link) {
        [weakSelf checkDeeplinksForLink:link];
    };
    
    
    router[HOME_SCHEME] = deeplinkCompletionHandler;
    router[PRODUCT_DETAIL_SCHEME] = deeplinkCompletionHandler;
    router[PRODUCT_DETAIL_SCHEME_OLD] = deeplinkCompletionHandler;
    router[ALLOFFERS_SCHEME] = deeplinkCompletionHandler;
    router[NEW_OFFERS_SCHEME] = deeplinkCompletionHandler;
    router[BUYMORE_SCHEME] = deeplinkCompletionHandler;
    router[CHEEROFFERS_SCHEME] = deeplinkCompletionHandler;
    router[DELIVERY_OFFERS_SCHEME] = deeplinkCompletionHandler;
    router[MONTHLYOFFERS_SCHEME] = deeplinkCompletionHandler;
    router[MORESAOFFERS_SCHEME] = deeplinkCompletionHandler;
    router[PRODUCT_LISTING_SCHEME] = deeplinkCompletionHandler;
    router[LOCATIONS_SCHEME] = deeplinkCompletionHandler;
    router[QUICKSEARCH_SCHEME] = deeplinkCompletionHandler;
    router[MYSTATUS_SCHEME] = deeplinkCompletionHandler;
    router[NOTIFICATIONS_SCHEME] = deeplinkCompletionHandler;
    router[MYINFORMATION_SCHEME] = deeplinkCompletionHandler;
    router[HELP_SCHEME] = deeplinkCompletionHandler;
    router[WALLET_SCHEME] = deeplinkCompletionHandler;
    router[MY_FAMILY_SCHEME] = deeplinkCompletionHandler;
    router[PENDING_INVITES_SCHEME] = deeplinkCompletionHandler;
    router[REDEMPTION_HISTORY_SCHEME] = deeplinkCompletionHandler;
    router[PURCHASE_HISTORY_SCHEME] = deeplinkCompletionHandler;
    router[CATEGORIES_SCHEME] = deeplinkCompletionHandler;
    router[CHECKOUT_SCHEME] = deeplinkCompletionHandler;
    router[CHECKOUT_SCHEME_OLD] = deeplinkCompletionHandler;
    router[TUTORIAL_SCHEME] = deeplinkCompletionHandler;
    router[MERCHANTDETAILPAGE_SCHEME] = deeplinkCompletionHandler;
    router[CATEGORY_OFFER_TYPE_SCHEME] = deeplinkCompletionHandler;
    router[MERCHANTDETAILPAGE_SCHEME_OLD] = deeplinkCompletionHandler;
    router[MYLEVELS_SCHEME] = deeplinkCompletionHandler;
    router[SAVINGS_BREAKDOWN_SCHEME] = deeplinkCompletionHandler;
    router[REDEMPTION_BREAKDOWN_SCHEME] = deeplinkCompletionHandler;
    router[MYBADGES_SCHEME] = deeplinkCompletionHandler;
    router[MYPROFILE_SCHEME] = deeplinkCompletionHandler;
    router[SAVINGS_SCHEME] = deeplinkCompletionHandler;
    router[SMILES_SCHEME] = deeplinkCompletionHandler;
    router[FRIENDS_SCHEME] = deeplinkCompletionHandler;
    router[FAVOURITES_SCHEME] = deeplinkCompletionHandler;
    router[PINGS_SCHEME] = deeplinkCompletionHandler;
    router[PINGSHISTORY_SCHEME] = deeplinkCompletionHandler;
    router[EULA_SCHEME] = deeplinkCompletionHandler;
    router[RULESOFUSE_SCHEME] = deeplinkCompletionHandler;
    router[MY_PRODUCTS] = deeplinkCompletionHandler;
    router[FRIEND_LEADER_BOARD] = deeplinkCompletionHandler;
    router[ORDER_HISTORY] = deeplinkCompletionHandler;
    router[RESERVATION_HISTORY] = deeplinkCompletionHandler;
    router[HOTELRULESOFUSE_SCHEME] = deeplinkCompletionHandler;
    router[RATEAPP_SCHEME] = deeplinkCompletionHandler;
    router[PERSONALDETAIL_SCHEME] = deeplinkCompletionHandler;
    router[SEARCH_SCHEME] = deeplinkCompletionHandler;
    router[SOCIAL_SCHEME] = deeplinkCompletionHandler;
    router[FILTER_SEARCH_SCHEME] = deeplinkCompletionHandler;
    router[CUSTOM_FILTER_SEARCH_SCHEME] = deeplinkCompletionHandler;
    router[REFER_FRIEND] = deeplinkCompletionHandler;
    router[CONNECT_friend] = deeplinkCompletionHandler;
    router[REGISTER_SCREEN] = deeplinkCompletionHandler;
    router[DISMISS_SCREEN] = deeplinkCompletionHandler;
    router[GETAWAY_SCHEME] = deeplinkCompletionHandler;
    router[VIEW_ORDER_DETAIL] = deeplinkCompletionHandler;
    router[GENERIC_KEY_BRANCH] = deeplinkCompletionHandler;
    router[RESET_NINE_DIGIT_KEY_BRANCH] = deeplinkCompletionHandler;
    router[LOCATION_PERMISSION] = deeplinkCompletionHandler;
    router[SSO] = deeplinkCompletionHandler;
    router[FEEDBACK_SCHEME] = deeplinkCompletionHandler;
    router[TRIAL_INFO] = deeplinkCompletionHandler;
    router[YOUTUBE_VIDEO] = deeplinkCompletionHandler;
    router[CASHLESS_MERCHANTDETAILPAGE_SCHEME] = deeplinkCompletionHandler;
    router[DELIVERY_SCHEME] = deeplinkCompletionHandler;
    router[CASHLESS_ORDER_STATUS] = deeplinkCompletionHandler;
    router[CASHLESS_ORDER_SUCCESS] = ^(DPLDeepLink *link) {
        [DDCashlessCartWebVC postOrderCompletionNotification:link.queryParameters];
    };
    router[DEEPLINK_C2C] = ^(DPLDeepLink *link) {
        UITabBarController *tabVC = (UITabBarController *)DDUIRouterManager.shared.applicationsWindow.rootViewController;
        tabVC.selectedIndex = 2;
    };
    
    router[CASHLESS_ORDER_FAILED] = ^(DPLDeepLink *link) {
        [DDCashlessCartWebVC postOrderFailureNotification:link.queryParameters];
    };
}

-(DPLDeepLinkRouter *) getRouter{
    return router;
}

@end
