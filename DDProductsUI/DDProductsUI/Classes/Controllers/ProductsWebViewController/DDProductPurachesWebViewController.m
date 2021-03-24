//
//  DDProductPurachesWebViewController.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 28/01/2020.
//
#import "DDProductPurachesWebViewController.h"
#import "DDCommons.h"
#import "DDConstants.h"
#import "DDProducts.h"
#import "DDProductsUIManager.h"
@import SafariServices;

@interface DDProductPurachesWebViewController()<SFSafariViewControllerDelegate>{
    UIActivityIndicatorView *indicator;
    BOOL isErrorInPage;
    NSURL *loadedURL;
    NSURL *safariOpeningURL;
    NSArray *userPreviousProducts;
}

@end

@implementation DDProductPurachesWebViewController

-(BOOL)processRequest:(NSURL *)URL {
    if ([URL.absoluteString.lowercaseString containsString:@"blank"]) {
        return NO;
    }
    if (self.dataModel.urlChange != nil) {
        return [super processRequest:URL];
    }
    if ([URL.host isEqualToString:self.dataModel.request.URL.host]){
        loadedURL = URL;
    }
    return YES;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.shouldLoadSameWebPage = YES;
    userPreviousProducts = [DDUserManager shared].currentUser.products;
    __weak typeof(self) weakSelf = self;
    self.dataModel.urlChange = ^BOOL(DDUIWebActions * _Nullable action, UIViewController * _Nullable controller) {
        return [weakSelf shouldPerformAction:action];
    };
    [self addRefreshControllInWebView];
}
-(void)setUpRequestBeforeLoad {
    NSString *url = DDCAppConfigManager.shared.api_config.PRODUCT_CART_URL;
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:(NSURLRequestReloadIgnoringLocalAndRemoteCacheData) timeoutInterval:60];
    if (self.dataModel.params == nil) {
        self.dataModel.params = [NSMutableDictionary new];
    }
    [self.dataModel.params addEntriesFromDictionary:DDCCommonParamManager.shared.default_web_parameters.toDictionary];
    if (self.navigation.routerModel.deeplinkModel.toApiDictionary.count > 0) {
        [self.dataModel.params addEntriesFromDictionary:self.navigation.routerModel.deeplinkModel.toApiDictionary];
    }
    req.GETParameters = self.dataModel.params;
    self.dataModel.request = req;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(BOOL)shouldPerformAction:(DDUIWebActions *)action {
    if (action.type == DDUIWebActionTypeLogin) {
        if ([action.parameters.allKeys containsObject:DDPRODUCT_LOGIN]) {
            NSString *shouldLogin = action.parameters[DDPRODUCT_LOGIN];
            if (!shouldLogin.boolValue) {
                __weak DDProductPurachesWebViewController *weakSelf = self;
                [DDProductsUIManager showCompleteLoginOnVC:self onCompletion:^(BOOL isLoggedIn) {
                    if (isLoggedIn) {
                        DDProductPurachesWebViewController *strongSelf = weakSelf;
                        NSString *userId = DDUserManager.shared.currentUser.user_id.stringValue;
                        NSString *newURL = [NSString stringWithFormat:@"%@&cid=%@",action.url,userId];
                        if ([action hasAction:DDPRODUCT_OPEN_SAFARI] || [action hasAction:DDPRODUCT_IS_OPEN_SAFARI]) {
                            NSString *isOpenSafari;
                            if ([action.parameters.allKeys containsObject:DDPRODUCT_IS_OPEN_SAFARI]) {
                                isOpenSafari = action.parameters[DDPRODUCT_IS_OPEN_SAFARI];
                            }
                            if ([action.parameters.allKeys containsObject:DDPRODUCT_OPEN_SAFARI]) {
                                isOpenSafari = action.parameters[DDPRODUCT_OPEN_SAFARI];
                            }
                            if (isOpenSafari.length > 0 && isOpenSafari.boolValue) {
                                NSString *queryParam = DDCCommonParamManager.shared.default_web_parameters.toDictionary.urlEncodedString;
                                NSString *cartURL = [NSString stringWithFormat:@"%@&%@",newURL,queryParam];
                                if (cartURL.length > 0) {
                                    strongSelf->safariOpeningURL = cartURL.urlValue;
                                    [strongSelf openApplePayInWebController:cartURL];
                                }
                            }
                        }
                    }
                }];
                return NO;
            }
        }
    }
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
            [DDWebManager.shared openURL:deeplink.noRequireRefreshGlobally title:@"" onController:self];
            return NO;
        }else {
            [DDWebManager.shared openURL:action.url.noRequireRefreshGlobally title:@"" onController:self];
            return NO;
        }
    }
    if (action.type == DDUIWebActionTypeProductList) {
        NSString *productID = action.parameters[DDPRODUCT_PRODUCT_SKU];
        if (productID.length > 0) {
            NSString *deeplink = [NSString stringWithFormat:@"entertainer://productmerchant/?product_sku=%@",productID];
            [DDWebManager.shared openURL:deeplink.noRequireRefreshGlobally title:@"" onController:self];
            return NO;
        }
    }
    if (action.type == DDUIWebActionTypeComplete) {
        NSString *productID = action.parameters[DDPRODUCT_PRODUCT_SKU];
        if (productID.length > 0) {
            NSString *deeplink = [NSString stringWithFormat:@"entertainer://productmerchant/?product_sku=%@",productID];
            [DDWebManager.shared openURL:deeplink.noRequireRefreshGlobally title:@"" onController:self];
            return NO;
        }
        
    }
    return YES;
}
-(void)setUpRequestBeforeRefresh {
    NSMutableURLRequest *req = [NSMutableURLRequest.alloc initWithURL:self.webView.URL];
    req.HTTPMethod = @"GET";
    self.dataModel.request = req;
}
- (void)openApplePayInWebController:(NSString*)link {
    NSURL *urlObj = [NSURL URLWithString:link];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:urlObj];
    safariVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    safariVC.modalPresentationCapturesStatusBarAppearance = YES;
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:NO completion:^{
    }];
}

#pragma mark - SFSafariViewController delegate methods

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
    __block NSString *deeplink = [NSString stringWithFormat:@"%@%@",DDCAppConfigManager.shared.app_config.APPLICATION_DEEPLINK_SCHEME,HOME_SCHEME];
    __weak typeof(self) weakSelf = self;
    [DDAuthManager.shared userProfileWithCompletion:YES completion:^(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [weakSelf goBackWithCompletion:^{
            if (self->userPreviousProducts != DDUserManager.shared.currentUser.products){
                [DDWebManager.shared openURL:deeplink title:@"" onController:weakSelf];
            }
        }];
    }];
}
@end
