//
//  DDProductPurachesWebViewController.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 28/01/2020.
//

#import "DDCashlessCartWebVC.h"
#import "DDCommons.h"
#import "DDConstants.h"
#import "DDProducts.h"
#import "DDCashlessUIConstants.h"
#import "DDEditConfigManager.h"
#import "DDCashlessThemeManager.h"
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
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [DDCashlessCartWebVC postOrderCompletionNotification:@{@"order_id": @(123), @"allow_edit": @(YES)}];
}
-(void)designUI {
    self.navigationController.navigationBar.barTintColor = CASHLESS_THEME.app_theme.colorValue;
    [self setActivityIndicatorTintColor:CASHLESS_THEME.bg_white.colorValue];
}
-(void)viewDidLoad {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(newOrderRecieveMethod:) name:CASHLESS_ORDER_PLACE_NOTIFICATION object:nil];
    [self addNavigationItemWithTitle:@"JSON" identifier:@"json_button" tintColor:CASHLESS_THEME.text_white.colorValue direction:(DDNavigationItemDirectionRight)];
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    __weak typeof(self) weakSelf = self;
    self.dataModel.urlChange = ^BOOL(DDUIWebActions * _Nullable action, UIViewController * _Nullable controller) {
        return [weakSelf shouldPerformAction:action];
    };
    
}
-(void)setUpRequestBeforeLoad {
    NSString *url = DDCAppConfigManager.shared.api_config.CASHLESS_CART_URL;
    if (![url containsString:@"theme"]) {
        url = [NSString stringWithFormat:@"%@?theme=v7",url];
    }
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:(NSURLRequestReloadIgnoringLocalAndRemoteCacheData) timeoutInterval:60];
    req.HTTPMethod = @"POST";
    if (self.dataModel.params.allKeys.count > 0) {
        req.POSTParameters = self.dataModel.params;
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
    if (action.type == DDUIWebActionTypeOpenSafari) {
        NSString *isOpenSafari;
        if ([action.parameters.allKeys containsObject:DDPRODUCT_IS_OPEN_SAFARI]) {
            isOpenSafari = action.parameters[DDPRODUCT_IS_OPEN_SAFARI];
        }
        if ([action.parameters.allKeys containsObject:DDPRODUCT_OPEN_SAFARI]) {
            isOpenSafari = action.parameters[DDPRODUCT_OPEN_SAFARI];
        }
        if (isOpenSafari.length > 0 && isOpenSafari.boolValue) {
            NSString *cartURL = action.url;
            if (cartURL.length > 0) {
                safariOpeningURL = cartURL.urlValue;
                [self openApplePayInWebController:cartURL];
                return NO;
            }
        }
    }
    if (action.type == DDUIWebActionTypeDeeplink) {
        if ([action.parameters.allKeys containsObject:DDPRODUCT_DEEPLINK]) {
            NSString *deeplink = action.parameters[DDPRODUCT_DEEPLINK];
            [DDWebManager.shared openURL:deeplink.noRequireRefreshGlobally title:nil onController:self];
            return NO;
        }
    }
    if (action.type == DDUIWebActionTypeProductList) {
        NSString *productID = action.parameters[DDPRODUCT_PRODUCT_SKU];
        if (productID.length > 0) {
            NSString *deeplink = [NSString stringWithFormat:@"entertainer://productmerchant/?product_sku=%@",productID];
            [DDWebManager.shared openURL:deeplink.noRequireRefreshGlobally title:nil onController:self];
            return NO;
        }
    }
    if (action.type == DDUIWebActionTypeComplete) {
        NSString *productID = action.parameters[DDPRODUCT_PRODUCT_SKU];
        if (productID.length > 0) {
            NSString *deeplink = [NSString stringWithFormat:@"entertainer://productmerchant/?product_sku=%@",productID];
            [DDWebManager.shared openURL:deeplink.noRequireRefreshGlobally title:nil onController:self];
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
-(void)sendData:(NSDictionary *)data {
    NSMutableDictionary *order_info = data.mutableCopy;
    if (self.dataModel.webCompletion != nil) {
        self.dataModel.webCompletion(order_info, self);
    }
}
+(void)postOrderCompletionNotification:(NSDictionary *)userInfo {
    [NSNotificationCenter.defaultCenter postNotificationName:CASHLESS_ORDER_PLACE_NOTIFICATION object:nil userInfo:userInfo];
}
@end
