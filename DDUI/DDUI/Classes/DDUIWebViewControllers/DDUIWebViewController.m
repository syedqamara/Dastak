//
//  DDUIWebViewController.m
//  DDUI
//
//  Created by M.Jabbar on 16/01/2020.
//

#import "DDUIWebViewController.h"
#import "DDUIBaseViewController+Navigation.h"
#import "PBJNetworkObserver.h"
#import "DDUIRefreshControl.h"
#import "DDUIWebViewVM.h"
#warning No internet connectivity error

@interface DDUIWebViewController ()<WKNavigationDelegate,UIScrollViewDelegate, PBJNetworkObserverProtocol>{
    UIActivityIndicatorView *indicator;
    BOOL isErrorInPage;
    NSURL *loadedURL;
}
@property (weak, nonatomic) DDUIRefreshControl *refreshControl;
@end

@implementation DDUIWebViewController
- (void)dealloc
{
    [[PBJNetworkObserver sharedNetworkObserver] removeNetworkReachableObserver:self];
}
@synthesize dataModel;

- (void)loadView {
    [super loadView];
    dataModel = (DDUIWebViewVM*)self.navigation.routerModel.data;
    if (dataModel) {
        [self setUpWKWebview];
    }
}
-(void)designUI {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        [self.webView.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
//        [self.tblView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    // Do any additional setup after loading the view from its nib.
    [self setActivityIndicator];
    [self loadRequest];
    [self setThemeNavigationBar];
    [self addBackArrowNavigtaionItemWithtitle:@"Back".localized tintColor:THEME.text_white.colorValue];
    [[PBJNetworkObserver sharedNetworkObserver] addNetworkReachableObserver:self];
    self.navigationItem.title = dataModel.title;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIApplication showDDLoaderAnimation];
    });
    __weak typeof(self) weakSelf = self;
    self.dataModel.urlChange = ^BOOL(DDUIWebActions * _Nullable action, UIViewController * _Nullable controller) {
        return [weakSelf shouldPerformAction:action];
    };
}
-(BOOL)shouldPerformAction:(DDUIWebActions *)action {
    return YES;
}
- (void) addRefreshControllInWebView {
    DDUIRefreshControl *ref = [DDUIRefreshControl.alloc init];
    [ref addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = ref;
    [self.webView.scrollView addSubview:self.refreshControl];
    self.webView.backgroundColor = [UIColor whiteColor];
}

-(void)handleRefresh:(UIRefreshControl *)refresh {
    if(self.isWebViewLoading){
        [refresh endRefreshing];
        return;
    }
    [self loadRequest];
}

-(void)setUpRequestBeforeLoad {
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
-(void)closeView:(id)sender {
    
    loadedURL = self.webView.URL;
    
    if (loadedURL && ![loadedURL.absoluteString.URLQueryParameters valueForKey:@"booking_success"] && !self.webView.loading) {
        NSString *queryString = [loadedURL.absoluteString.URLQueryParameters valueForKey:@"value"];
        //queryString = @"'{\"Checkin\":\"Wed, February 27\",\"Checkout\":\"Fri, March 01\",\"hotel_id\":\"387077\",\"package\":\"2:0:3:01e0dcf4eee4a53c0c2dca4e63482551\"}'";
        if (queryString){
            //TODO: add analytics here
//            [DDTRPostAnalytics postWebViewAbandonCardParams:[self getParameters:queryString]];
        }
    }
    
    if (dataModel.webViewCloseCompletion){
        dataModel.webViewCloseCompletion(self);
    }
}

-(void) setUpWKWebview{
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    if (@available(iOS 10.0, *)) {
        theConfiguration.dataDetectorTypes = WKDataDetectorTypeNone;
    }
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:theConfiguration];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scrollView.delegate = self;
    self.webView.navigationDelegate = self;
    self.view = self.webView;
    

}
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
//        [DDProcessUtil.sharedInstance checkAndAddFloatingAction:YES];
    }];
}
-(void)orderEditTimerIsFinished {
    [self dismiss];
}
- (void)dismiss {
    
    if (isErrorInPage){
        [self loadInitialRequestIncaseOfErrorInPage];
    } else {
        __weak __typeof(self) weakSelf = self;
//
//        [self dismissViewControllerAnimated:YES completion:^{
//            if (weakSelf.dataModel.delegate != nil && [weakSelf.dataModel.delegate respondsToSelector:@selector(didDismissWebViewController:)]) {
//                [weakSelf.dataModel.delegate didDismissWebViewController:self];
//            }
//        }];
        
        if (weakSelf.dataModel.webViewCloseCompletion){
            weakSelf.dataModel.webViewCloseCompletion(self);
        }
    }
}

-(void) checkAndSendAnalaytics{
    NSString *url = self.webView.URL.absoluteString;
    NSString *queryStrings = nil;
    if (url && [url.URLQueryParameters valueForKey:@"is_analytics"] != nil) {
        NSNumber *isAnalytics = (NSNumber *)[url.URLQueryParameters valueForKey:@"is_analytics"];
        if ([isAnalytics boolValue]){
            queryStrings = [url.URLQueryParameters valueForKey:@"value"];
        }
    }
    if (queryStrings && ![queryStrings isEqualToString:@""]) {
        //TODO: add analytics here
//        [DDTRPostAnalytics postBookingPay:[self getParameters:queryStrings]];
    }
}


-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    if(webView != self.webView) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    
    [self checkAndSendAnalaytics];
    
    if (navigationAction.request.URL != nil){
        BOOL shouldContinue = [self processRequest:navigationAction.request.URL];
        if (!shouldContinue) {
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = navigationAction.request.URL;
    
    if (!navigationAction.targetFrame) {
        if ([app canOpenURL:url]) {
            [app openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    if ([url.scheme isEqualToString:@"tel"])
    {
        if ([app canOpenURL:url])
        {
            [app openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    if ([url.scheme isEqualToString:@"mailto"])
    {
        if ([app canOpenURL:url])
        {
            [app openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void) setNavTitle:(NSString *) title{
        if (title && ![[title trimmedString] isEqualToString:@""]) {
            self.navigationItem.title = [title trimmedString];
        }
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable object, NSError * _Nullable error) {
//        [self setNavTitle:object];
    }];
    [self stopLoading];
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self startLoading];
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self stopLoading];
    [webView loadHTMLString:[self loadErrorView:error] baseURL:nil];
}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self stopLoading];
    [webView loadHTMLString:[self loadErrorView:error] baseURL:nil];
}

//WKWebview End

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}

-(void) setActivityIndicator{
    indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    indicator.tintColor = [UIColor whiteColor];
    indicator.color = [UIColor whiteColor];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:indicator];
    
    NSMutableArray *arr = self.navigationItem.rightBarButtonItems.mutableCopy;
    if (arr == nil){
        arr = [NSMutableArray new];
    }
    [arr addObject:barButton];
    [self navigationItem].rightBarButtonItems = arr;
}

-(NSString *) loadErrorView: (NSError *)error {
    
    
    NSString *content = [NSBundle loadHtmlStringForClass:[self class] fileName:@"error-view"];
    if (content.length > 0) {
        UIImage *img = [NSBundle loadImageFromResourceBundlePNG:[self class] imageName:@"connectivity_icon"];
        
        NSData *data = UIImagePNGRepresentation(img);
        
        NSString *imgString = [data base64EncodedStringWithOptions:0];
        
        NSString *imgHtml = [NSString stringWithFormat:@"data:application/png;base64,%@",imgString];
        
        NSString *imgHTMLTag = [NSString stringWithFormat:@"<img src=\"%@\" style=\"height: 150px;width:150px;\" />", imgHtml];
        
        
        content = [content stringByReplacingOccurrencesOfString:@"#TITLE" withString:@"SOME THING WENT WRONG".localized];
        
        content = [content stringByReplacingOccurrencesOfString:@"#MESSAGE" withString:error.localizedDescription];
        
        content = [content stringByReplacingOccurrencesOfString:@"#IMAGE_PATH" withString:imgHTMLTag];
        
        return content;
    }
    return @"";
}
//TODO: Need observer for relaod request on network status change
- (void)networkObserverReachabilityDidChange:(PBJNetworkObserver *)networkObserver
{
    if (!self.isWebViewLoading) {
        if (!self.shouldLoadSameWebPage) {
            [self loadRequest];
        }else {
            [self setUpRequestBeforeRefresh];
            [self.webView loadRequest:dataModel.request];
        }
    }
    
}


-(void) loadRequest {
    isErrorInPage = NO;
    [self setUpRequestBeforeLoad];
    [self.webView loadRequest:dataModel.request];
}

-(void) loadInitialRequestIncaseOfErrorInPage {
    isErrorInPage = NO;
//    [self.webView loadRequest:dataModel.initialRequest];
    [self.webView reload];
}

-(void) stopLoading{
    self.isWebViewLoading = NO;
    [indicator stopAnimating];
    [self.refreshControl endRefreshing];
    [UIApplication dismissDDLoaderAnimation];
}


-(void) startLoading{
    self.isWebViewLoading = YES;
    [indicator startAnimating];
}

-(void) checkErrorOnPage:(NSURL *) url {
    if (url && url.absoluteString && [url.absoluteString.URLQueryParameters valueForKey:@"__error_dc"]){
        isErrorInPage = YES;
    }
}

-(void) checkExternalURL:(NSURL *) url {
    if (url && url.absoluteString && [url.absoluteString.URLQueryParameters valueForKey:@"__error_dc"]){
        isErrorInPage = YES;
    }
}

-(BOOL) processRequest:(NSURL *) URL{
    
    __weak __typeof(self) weakSelf = self;
    if (URL != nil){
        [self checkErrorOnPage:URL];
        if ([URL.absoluteString.URLQueryParameters valueForKey:@"back"]) {
            [self.webView loadHTMLString:@"<html><body></body></html>" baseURL:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf loadInitialRequestIncaseOfErrorInPage];
            });
            
        }
        if (self.dataModel.urlChange != nil) {
            DDUIWebActions *action = [[DDUIWebActions alloc]initWithURL:URL.absoluteString];
            if (action.type == DDUIWebActionTypeBack) {
                [self goBackWithCompletion:nil];
                return NO;
            }
            return self.dataModel.urlChange(action, self);
//            return NO;
        }
    }
    
    return YES;
}

-(NSMutableDictionary *) getParameters:(NSString *) value{
    if (value){
        NSString *queryString = [value stringByReplacingOccurrencesOfString:@"'" withString:@""];;
        NSData *objectData = [queryString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *jsonError;
        if (objectData) {
            NSDictionary *parameters = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:&jsonError];
            if (parameters != nil){
                return [[NSMutableDictionary alloc] initWithDictionary:parameters];
            }
        }
    }
    return [[NSMutableDictionary alloc] init];
}
-(void)setActivityIndicatorTintColor:(UIColor *)color {
    [indicator setTintColor:color];
}
-(void)setUpRequestBeforeRefresh {
    
}
+(NSArray<DDUIRouterM *> *)deeplinkRoutes {
    DDUIRouterM *route = [DDUIRouterM new];
    route.route_link = DD_Nav_UI_Web_View_General;
    route.should_embed_in_nav = YES;
    route.transition = DDUITransitionPresent;
    return @[route];
}
@end
