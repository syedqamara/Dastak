//
//  DDAccountUIManager.m
//  DDAccountsUI
//
//  Created by M.Jabbar on 24/02/2020.
//

#import "DDAccountUIManager.h"
#import <DDCommons/DDCommons.h>

@implementation DDAccountUIManager

+(void)showSubItems:(DDSettingsSectionListM*)item onController:(UIViewController*)controller {
    DDUIRouterM *settings = [[DDUIRouterM alloc]init];
    settings.route_link = DD_Nav_Accounts_Settings;
    settings.should_embed_in_nav = YES;
    settings.is_animated = YES;
    settings.transition = DDUITransitionPush;
    settings.data = item;
    [DDUIRouterManager.shared navigateTo:@[settings] onController:controller];
}
//MARK:- Family Routers

+(void)showMyFamilyList:(id _Nullable)data onController:(UIViewController*)controller {
    DDUIRouterM *family = [[DDUIRouterM alloc]init];
    family.route_link = DD_Nav_MY_Family;
    family.should_embed_in_nav = YES;
    family.is_animated = YES;
    family.transition = DDUITransitionPush;
    family.data = data;
    [DDUIRouterManager.shared navigateTo:@[family] onController:controller];
}

+(void)showMyFriendsList:(id _Nullable)data onController:(UIViewController*)controller {
    DDUIRouterM *router = [[DDUIRouterM alloc]init];
    router.route_link = DD_Nav_My_Friends;
    router.should_embed_in_nav = YES;
    router.is_animated = YES;
    router.transition = DDUITransitionPush;
    router.data = data;
    [DDUIRouterManager.shared navigateTo:@[router] onController:controller];
}
//MARK:- Histroy Routers
+(void)showMyOrdersList:(id _Nullable)data onController:(UIViewController*)controller {
    DDUIRouterM *orders = [[DDUIRouterM alloc]init];
    orders.route_link = DD_Nav_Order_History;
    orders.should_embed_in_nav = YES;
    orders.transition = DDUITransitionPush;
    orders.data = data;
    [DDUIRouterManager.shared navigateTo:@[orders] onController:controller];
}
+(void)showMyPingsList:(id _Nullable)data onController:(UIViewController*)controller {
    DDUIRouterM *ping = [[DDUIRouterM alloc]init];
    ping.route_link = DD_Nav_Pings_History;
    ping.should_embed_in_nav = YES;
    ping.transition = DDUITransitionPush;
    ping.data = data;
    [DDUIRouterManager.shared navigateTo:@[ping] onController:controller];
}
+(void)showMyRedemptionsList:(id _Nullable)data onController:(UIViewController*)controller {
    DDUIRouterM *redemption = [[DDUIRouterM alloc]init];
    redemption.route_link = DD_Nav_Redemption_History;
    redemption.should_embed_in_nav = YES;
    redemption.transition = DDUITransitionPush;
    redemption.data = data;
    [DDUIRouterManager.shared navigateTo:@[redemption] onController:controller];
}
+(void)showMyReservationsList:(id _Nullable)data onController:(UIViewController*)controller {
    DDUIRouterM *reservation = [[DDUIRouterM alloc]init];
    reservation.route_link = DD_Nav_Reservation_History;
    reservation.should_embed_in_nav = YES;
    reservation.transition = DDUITransitionPush;
    reservation.data = data;
    [DDUIRouterManager.shared navigateTo:@[reservation] onController:controller];
}
+(void)showMyAccount:(id _Nullable)data onController:(UIViewController*)controller {
    DDUIRouterM *reservation = [[DDUIRouterM alloc]init];
    reservation.route_link = DD_Nav_Accounts_My_Account;
    reservation.should_embed_in_nav = YES;
    reservation.transition = DDUITransitionPush;
    reservation.data = data;
    [DDUIRouterManager.shared navigateTo:@[reservation] onController:controller];
}
+(void)showSmilesDetail:(id _Nullable)data onController:(UIViewController*)controller {
    DDUIRouterM *reservation = [[DDUIRouterM alloc]init];
    reservation.route_link = DD_Nav_Accounts_Smiles_Detail;
    reservation.should_embed_in_nav = YES;
    reservation.transition = DDUITransitionPush;
    reservation.data = data;
    [DDUIRouterManager.shared navigateTo:@[reservation] onController:controller];
}
+(void)showSavingsDetail:(id _Nullable)data onController:(UIViewController*)controller {
    DDUIRouterM *reservation = [[DDUIRouterM alloc]init];
    reservation.route_link = DD_Nav_Accounts_Savings_Detail;
    reservation.should_embed_in_nav = YES;
    reservation.transition = DDUITransitionPush;
    reservation.data = data;
    [DDUIRouterManager.shared navigateTo:@[reservation] onController:controller];
}
+(void)showBuyProducts:(id _Nullable)data onController:(UIViewController  * _Nullable )controller {
   
    DDUIRouterM *reservation = [[DDUIRouterM alloc]init];
    reservation.should_embed_in_nav = YES;
    reservation.route_link = DD_Nav_UI_Web_View_Product;
    reservation.transition = DDUITransitionPresent;
    
    DDUIWebViewVM *webModel = [[DDUIWebViewVM alloc]init];
    webModel.webType = DDUIWebViewTypeProductCart;
    reservation.data = webModel;
    reservation.is_animated = YES;
    
    [DDUIRouterManager.shared navigateTo:@[reservation] onController:controller ?: [UIApplication topMostController]];
}

+(void)showLeaderboardMemberDetail:(id _Nullable)data onController:(UIViewController  * _Nullable )controller {
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = DD_Nav_Friend_Details;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    if (data) route.data = data;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

+(void)showProfileSettingsDetail:(id _Nullable)data onController:(UIViewController  * _Nullable )controller {
    DDUIRouterM *settings = [[DDUIRouterM alloc]init];
    settings.route_link = DD_Nav_Accounts_Settings;
    settings.should_embed_in_nav = YES;
    settings.transition = DDUITransitionPush;
    settings.is_animated = YES;
    [DDUIRouterManager.shared navigateTo:@[settings] onController:controller];
}
@end
