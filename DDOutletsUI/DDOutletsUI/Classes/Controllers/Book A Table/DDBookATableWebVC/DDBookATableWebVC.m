//
//  DDBookATableWebVC.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 28/01/2020.
//
#import "DDBookATableWebVC.h"
#import "DDCommons.h"
#import "DDConstants.h"
#import "DDAuth.h"
#import "DDOutletsThemeManager.h"
@import SafariServices;

@interface DDBookATableWebVC()<SFSafariViewControllerDelegate>{
    UIActivityIndicatorView *indicator;
    BOOL isErrorInPage;
    NSURL *loadedURL;
    NSURL *safariOpeningURL;
}

@end

@implementation DDBookATableWebVC

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
    if (self.dataModel.request == nil) {
        [self loadURLWithRequestWithParams];
    }
    [super viewDidLoad];
    [self setThemeNavigationBar];
    [self addBackArrowNavigtaionItemWithtitle:@"Back".localized tintColor:OUTLETS_THEME.text_white.colorValue];
    __weak typeof(self) weakSelf = self;
    self.dataModel.urlChange = ^BOOL(DDUIWebActions * _Nullable action, UIViewController * _Nullable controller) {
        return [weakSelf shouldPerformAction:action];
    };
}
-(void)loadURLWithRequestWithParams {
    NSString *url = DDCAppConfigManager.shared.api_config.BOOK_A_TABLE_URL;
    
    NSString *urlPart = [url componentsSeparatedByString:@"?"].firstObject;
    NSString *paramPart = [url componentsSeparatedByString:@"?"].lastObject;
    NSString *key = [paramPart componentsSeparatedByString:@"="].firstObject;
    NSString *value = [paramPart componentsSeparatedByString:@"="].lastObject;
    
    NSURL *urlObj = [NSURL URLWithString:urlPart];
    NSDictionary <NSString *, NSString *>*param = @{key: value};
    
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:urlObj cachePolicy:(NSURLRequestReloadIgnoringLocalAndRemoteCacheData) timeoutInterval:60];
    if (self.dataModel.params == nil) {
        self.dataModel.params = [NSMutableDictionary new];
    }
    [self.dataModel.params addEntriesFromDictionary:param];
    req.HTTPMethod = @"POST";
    [self.dataModel.params addEntriesFromDictionary:DDCCommonParamManager.shared.default_web_parameters.toDictionary];
    if (self.navigation.routerModel.deeplinkModel.toApiDictionary.count > 0) {
        [self.dataModel.params addEntriesFromDictionary:self.navigation.routerModel.deeplinkModel.toApiDictionary];
    }
    req.POSTParameters = self.dataModel.params;
    self.dataModel.request = req;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
-(BOOL)shouldPerformAction:(DDUIWebActions *)action {
    if (action.type == DDUIWebActionTypeLogin) {
        return NO;
    }
    if (action.type == DDUIWebActionTypeOpenSafari) {
        return NO;
    }
    if (action.type == DDUIWebActionTypeDeeplink) {
        return NO;
    }
    if (action.type == DDUIWebActionTypeProductList) {
        return NO;
    }
    if (action.type == DDUIWebActionTypeComplete) {
        return NO;
    }
    return YES;
}

//- (void)openApplePayInWebController:(NSString*)link {
//    NSURL *urlObj = [NSURL URLWithString:link];
//    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:urlObj];
//    safariVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    safariVC.modalPresentationCapturesStatusBarAppearance = YES;
//    safariVC.delegate = self;
//    [self presentViewController:safariVC animated:NO completion:^{
//    }];
//}
//
//#pragma mark - SFSafariViewController delegate methods
//
//-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
//    __block NSString *deeplink = [NSString stringWithFormat:@"%@%@",DDCAppConfigManager.shared.APPLICATION_DEEPLINK_SCHEME,HOME_SCHEME];
//    __weak typeof(self) weakSelf = self;
//    [DDAuthManager.shared userProfileWithCompletion:^(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        [weakSelf goBackWithCompletion:^{
//            [DDWebManager.shared openURL:deeplink.requireRefreshGlobally title:@"" onController:weakSelf];
//        }];
//    }];
//}
@end
