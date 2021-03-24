//
//  DDProductPurachesWebViewController.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 28/01/2020.
//

#import "DDCashlessCartWebVC.h"
#import "DDCommons.h"
#import "DDConstants.h"
#import "DDEditConfigManager.h"
#import "DDHomeThemeManager.h"
#import "DDHomeUIManager.h"


#define CASHLESS_ORDER_FAILED_NOTIFICATION @"CASHLESS_ORDER_FAILED_NOTIFICATION"

@import SafariServices;

@interface DDCashlessCartWebVC()<SFSafariViewControllerDelegate>{
    UIActivityIndicatorView *indicator;
    BOOL isErrorInPage;
    NSURL *loadedURL;
    NSURL *safariOpeningURL;
    SFSafariViewController *safariVC;
}

@end

@implementation DDCashlessCartWebVC

-(BOOL)processRequest:(NSURL *)URL {
    if (self.dataModel.urlChange != nil) {
        return [super processRequest:URL];
    }
    if ([URL.host isEqualToString:self.dataModel.request.URL.host]){
        loadedURL = URL;
    }
    return YES;
}
-(void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self name:CASHLESS_ORDER_PLACE_NOTIFICATION object:nil];
    
    [NSNotificationCenter.defaultCenter removeObserver:self name:CASHLESS_ORDER_FAILED_NOTIFICATION object:nil];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [DDCashlessCartWebVC postOrderCompletionNotification:@{@"order_id": @(123), @"allow_edit": @(YES)}];
}
-(void)designUI {
    self.navigationController.navigationBar.barTintColor = HOME_THEME.app_theme.colorValue;
    [self setActivityIndicatorTintColor:HOME_THEME.bg_white.colorValue];
}
-(void)viewDidLoad {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(orderFailedMethod:) name:CASHLESS_ORDER_FAILED_NOTIFICATION object:nil];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(newOrderRecieveMethod:) name:CASHLESS_ORDER_PLACE_NOTIFICATION object:nil];
    if (DDCAppConfigManager.shared.isEditConfigAllowed) {
        [self addNavigationItemWithTitle:@"JSON" identifier:@"json_button" tintColor:HOME_THEME.text_white.colorValue direction:(DDNavigationItemDirectionRight)];
    }
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
}
-(void)setUpRequestBeforeLoad {
    NSString *url = DDCAppConfigManager.shared.api_config.CASHLESS_CART_URL;
    if (self.dataModel.url.length > 0) {
        url = self.dataModel.url;
    }
//    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:(NSURLRequestReloadIgnoringLocalAndRemoteCacheData) timeoutInterval:10];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc]initWithURL:url.URLValue];
    req.HTTPMethod = @"POST";
    if (self.dataModel.params.allKeys.count > 0) {
        [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [req setHTTPBody:[self.dataModel.params bv_jsonDataWithPrettyPrint:YES]];
    }
    self.dataModel.request = req;
}
-(void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    if (sender.direction == DDNavigationItemDirectionRight) {
        if (self.dataModel.webCompletion != nil) {
            self.dataModel.webCompletion(nil, self);
        }
        return;
    }
    [super didTapOnNavigationItem:sender];
}
-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(BOOL)shouldPerformAction:(DDUIWebActions *)action {
    if (action.type == DDUIWebActionTypeDeeplink) {
        if ([action.url.lowercaseString containsString:DDCAppConfigManager.shared.app_config.APPLICATION_DEEPLINK_SCHEME.lowercaseString]){
            [DDWebManager.shared openURL:action.url title:@"" onController:self];
            return NO;
        }
    }
    if (action.type == DDUIWebActionTypeAnalytics) {
        return NO;
    }
    if (action.type == DDUIWebActionTypeForceStop) {
        return NO;
    }
    return YES;
}

- (void)openApplePayInWebController:(NSString*)link {
    NSURL *urlObj = [NSURL URLWithString:link];
    safariVC = [[SFSafariViewController alloc]initWithURL:urlObj];
    safariVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    safariVC.modalPresentationCapturesStatusBarAppearance = YES;
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:NO completion:^{
    }];
}

#pragma mark - SFSafariViewController delegate methods

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
    //Perform User Management
    NSString *prodID = [safariOpeningURL.absoluteString.URLQueryParameters valueForKey:@"product_id"];
    NSString *deeplink = [NSString stringWithFormat:@"%@?product_id=%@",PRODUCT_DETAIL_SCHEME,prodID];
    [DDWebManager.shared openURL:deeplink.requireRefreshGlobally title:nil onController:self];

}

#pragma mark - Notification Observer Methods

- (void)newOrderRecieveMethod:(NSNotification *)notification {
    if (safariVC == nil) {
        [self sendData:notification.userInfo];
    }else {
        [self dismissViewControllerAnimated:NO completion:^{
            [self sendData:notification.userInfo];
        }];
    }
    
    
}

- (void)orderFailedMethod:(NSNotification *)notification {
    if (safariVC == nil) {
        [self sendData:notification.userInfo];
    }else {
        [DDAlertUtils showOkAlertWithTitle:notification.userInfo[@"title"] subtitle:notification.userInfo[@"message"] completion:^{
        }];
    }
    
    
}
-(void)sendData:(NSDictionary *)data {
    NSMutableDictionary *order_info = data.mutableCopy;
    if (self.dataModel.webCompletion != nil) {
        self.dataModel.webCompletion(order_info, self);
    }
}
+(void)postOrderCompletionNotification:(NSDictionary *)userInfo {
    [NSNotificationCenter.defaultCenter postNotificationName:CASHLESS_ORDER_PLACE_NOTIFICATION object:nil userInfo:userInfo];
}
+(void)postOrderFailureNotification:(NSDictionary *)userInfo {
    [NSNotificationCenter.defaultCenter postNotificationName:CASHLESS_ORDER_FAILED_NOTIFICATION object:nil userInfo:userInfo];
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Cart_Web andModuleName:@"DDHomeUI" withClassRef:self.class];
}
@end
