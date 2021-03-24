//
//  DDAccountUIManager.h
//  DDAccountsUI
//
//  Created by M.Jabbar on 24/02/2020.
//

#import <Foundation/Foundation.h>
#import <DDModels/DDModels.h>
#import <DDAccounts/DDAccounts.h>
#import <DDUI/DDUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDAccountUIManager : NSObject

+(void)showSubItems:(DDSettingsSectionListM*)item onController:(UIViewController*)controller;
+(void)showMyFamilyList:(id _Nullable)data onController:(UIViewController*)controller;
+(void)showMyFriendsList:(id _Nullable)data onController:(UIViewController*)controller;
+(void)showMyPingsList:(id _Nullable)data onController:(UIViewController*)controller;
+(void)showMyRedemptionsList:(id _Nullable)data onController:(UIViewController*)controller;
+(void)showMyReservationsList:(id _Nullable)data onController:(UIViewController*)controller;
+(void)showMyAccount:(id _Nullable)data onController:(UIViewController*)controller;
+(void)showSmilesDetail:(id _Nullable)data onController:(UIViewController*)controller;
+(void)showSavingsDetail:(id _Nullable)data onController:(UIViewController*)controller;
+(void)showMyOrdersList:(id _Nullable)data onController:(UIViewController*)controller;
+(void)showBuyProducts:(id _Nullable)data onController:(UIViewController  * _Nullable )controller;
+(void)showLeaderboardMemberDetail:(id _Nullable)data onController:(UIViewController  * _Nullable )controller;
+(void)showProfileSettingsDetail:(id _Nullable)data onController:(UIViewController  * _Nullable )controller;
@end

NS_ASSUME_NONNULL_END
