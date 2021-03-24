//
//  DDAppDelegate.m
//  dynamicdelivery
//
//  Created by etDev24 on 12/24/2019.
//  Copyright (c) 2019 etDev24. All rights reserved.
//

#import "DDAppDelegate.h"
#import "DDNavigationConfigurations.h"
#import "DDAnalyticsConfiguration.h"
#import "DDAppConfiguration.h"
#import "DDApiRouteConfig.h"
#import "DDThemeConfiguration.h"
#import "DDDeepLinkUtils.h"
#import "DDTabbarController.h"
#import "DDUIRouterManager.h"
#import "DDThirdPartySDKConfig.h"
#import "DDDeeplinkConfig.h"
#import <IQKeyboardManager.h>
#import "DDConstants.h"
#import <DDAuth.h>
#import "DDHomeUI.h"
#import <Branch.h>
#import "DDSplashVC.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

@implementation DDAppDelegate 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self loadAllConfigurations];
    [FBSDKApplicationDelegate.sharedInstance application:application didFinishLaunchingWithOptions:launchOptions];
    [self IQKeybordEnabled:YES];
    
    [self initAppBoySDK:application launchOptions:launchOptions];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(loadTabbarController) name:REFRESH_CONTROLLER_NOTIFICATION object:nil];
    [DDSplashVC openSplash:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        [self loadTabbarController];
    }];
    if ([NSString.deviceLanguage.lowercaseString containsString:@"ar"]) {
        [[UIView appearance] setSemanticContentAttribute:(UISemanticContentAttributeForceRightToLeft)];
    }
    [self addObservers];
    [DDBasketManager.shared loadSavedBasket];
    [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
    [[UIView appearanceWhenContainedInInstancesOfClasses:@[[UIAlertController class]]] setSemanticContentAttribute:UISemanticContentAttributeUnspecified];

    return YES;
}
-(void)loadTabbarController {
    [DDTabbarController createNewTabbar];
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    [[Branch getInstance]
    application:UIApplication.sharedApplication
    openURL:url
    sourceApplication:nil
    annotation:nil];
    
    [[GIDSignIn sharedInstance] handleURL:url];
    
    
    
    NSArray <NSString *> *urls = [url.absoluteString componentsSeparatedByString:@"?"];
    NSString *baseURL = urls.firstObject;
    NSString *parameters = urls.lastObject;
    NSString *finalURL = [NSString stringWithFormat:@"%@?%@",baseURL.lowercaseString, parameters];
    [[DDDeepLinkUtils.sharedInstance getRouter] handleURL:finalURL.URLValue withCompletion:nil];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [DDApiRouteConfig loadAppConfigurationsFromAPI];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - IQKeybordManager

-(void)IQKeybordEnabled:(BOOL)enabled {
    [IQKeyboardManager.sharedManager setEnable:enabled];
}


#pragma mark - All Configurations

-(void)addObserverToCurrentThemeInDefaults {
    [DD_DEFAULTS addObserver:self
               forKeyPath:DDUIThemeManager.current_saved_theme_key_name
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([DDUIThemeManager.current_saved_theme_key_name isEqualToString:keyPath]) {
        [DDUIThemeManager shouldLoadNewTheme];
    }
}
-(void)addObservers{
    [NSNotificationCenter.defaultCenter addObserverForName:DD_USER_LOGIN_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self initializeGamification];
    }];
    
    [NSNotificationCenter.defaultCenter addObserverForName:DD_NETWORK_USER_LOGOUT object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [[DDUserManager shared] logout];
        [self loadTabbarController];
    }];
    
    [NSNotificationCenter.defaultCenter addObserverForName:DD_USER_LOGOUT_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self loadTabbarController];
    }];
}
/// loadAllConfigurations method should be the first line of didFinishLaunchingWithOptions method
-(void)loadAllConfigurations {
    [DDAppConfiguration loadAppConfig];
    [DDThirdPartySDKConfig loadConfigurations];
    [self setInitialCommonParamConfiguration];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(loadTheme) name:DDUIThemeManager.load_new_theme_notification_name object:nil];
    
    DDUIRouterManager.shared.applicationsWindow = self.window;
    DDUILottieAnimationManager.shared.applicationWindow = self.window;
    [self loadTheme];
    [DDDeeplinkConfig configureDeeplinkToRouteLinkTranslator];
    [DDNavigationConfigurations loadNavigationConfig];
    [DDApiRouteConfig loadApiConfiguration];
    [DDAnalyticsConfiguration configure];
    [DDAnalyticsConfiguration configure];
    [DDAuthManager.shared config:nil andCompletion:^(DDConfigApiM * _Nullable model, NSURLResponse * _Nullable resp, NSError * _Nullable err) {
        NSLog(@"");
    }];
    [self addObserverToCurrentThemeInDefaults];
    [self initializeGamification];
    
}
-(void)setInitialCommonParamConfiguration {
    DDCCommonParamManager.shared.default_api_parameters.device_id = [DDSharedPreferences.shared getUniqueKey];
    DDCCommonParamManager.shared.default_api_parameters.device_key = [DDSharedPreferences.shared getUniqueKey];
}
-(void)initializeGamification{
    
}
-(void)loadTheme {
    [DDThemeConfiguration loadConfig];
}

-(void) initAppBoySDK:(UIApplication *) application launchOptions:(NSDictionary *) launchOptions{
//    NSMutableDictionary *appboyOptions = [NSMutableDictionary dictionary];
//    appboyOptions[ABKURLDelegateKey] = self;
//    appboyOptions[ABKPushStoryAppGroupKey] = @"group.com.dynamicdelivery.Thedynamicdelivery";
//    
//    [Appboy startWithApiKey:DDCAppConfigManager.shared.api_config.APPBOY_API_KEY
//              inApplication:application
//          withLaunchOptions:launchOptions
//          withAppboyOptions:appboyOptions];
//
//    [Appboy sharedInstance].inAppMessageController.delegate = self;
//    [[Appboy sharedInstance].inAppMessageController displayNextInAppMessageWithDelegate:self];
//    [self setBranchSettingsWithLaunchOptions:launchOptions];
}

-(void)setBranchSettingsWithLaunchOptions:(NSDictionary *) launchOptions {
    if (DDAppConfiguration.buildType != DDBuildConfigPRODNode) {
        [Branch setUseTestBranchKey:YES];
        [Branch.getInstance setDebug];
//        if (DDAppConfiguration.shouldAllowURLChange) {
//            [Branch.getInstance validateSDKIntegration];
//        }
    }
    
    [[Branch getInstance] initSessionWithLaunchOptions:launchOptions andRegisterDeepLinkHandler:^(NSDictionary *params, NSError *error) {
        NSString *deeplink = DDCAppConfigManager.shared.app_config.APPLICATION_DEEPLINK_SCHEME;
        if ([params.allKeys containsObject:@"deeplink"]) {
            deeplink = params[@"deeplink"];
        }
        else if ([params.allKeys containsObject:@"$ios_deeplink_path"]) {
            deeplink = [deeplink add:params[@"$ios_deeplink_path"]];
        }
        else if ([params.allKeys containsObject:@"filter_search"]) {
            BOOL isFilterSearch = [params boolForKey:@"filter_search"];
            if (isFilterSearch) {
                deeplink = [deeplink add:FILTER_SEARCH_SCHEME];
                deeplink = [deeplink insert:params excludeKeysHavingString:@[@"$", @"+", @"~"]];
            }
        }
        else if ([params.allKeys containsObject:@"is_generic_key"]) {
            BOOL isFilterSearch = [params boolForKey:@"is_generic_key"];
            if (isFilterSearch) {
                deeplink = [deeplink add:VIP_KEY_SCHEME];
                NSMutableDictionary *dict = params.mutableCopy;
                [dict setValue:@(YES) forKey:IS_BRANCH_KEY];
                deeplink = [deeplink insert:dict excludeKeysHavingString:@[@"$", @"+", @"~"]];
            }
        }
        
        
        if (![deeplink isEqualToString:DDCAppConfigManager.shared.app_config.APPLICATION_DEEPLINK_SCHEME]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [DDWebManager.shared openURL:deeplink title:@"" onController:UIApplication.topMostController];
            });
        }
    }];
}
-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    [Branch.getInstance continueUserActivity:userActivity];
    return [DDDeepLinkUtils.sharedInstance.getRouter handleUserActivity:userActivity withCompletion:NULL];
}

- (ABKInAppMessageDisplayChoice) beforeInAppMessageDisplayed:(ABKInAppMessage *)inAppMessage {
    return ABKDisplayInAppMessageNow;
}

@end

@implementation DDApplication

-(void)sendEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) {
        if (DDAppConfiguration.shouldAllowURLChange && !DDAppConfiguration.isEditConfigAlreadyDisplaying) {
            [DDAppConfiguration showEditConfigurationViewController];
        }
    }else {
        [super sendEvent:event];
    }
}

@end
