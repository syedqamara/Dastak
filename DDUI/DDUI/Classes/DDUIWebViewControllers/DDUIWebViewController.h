//
//  DDUIWebViewController.h
//  DDUI
//
//  Created by M.Jabbar on 16/01/2020.
//

#import <UIKit/UIKit.h>
#import "DDUIBaseViewController.h"
#import <WebKit/WebKit.h>
#import "DDUIWebViewVM.h"
NS_ASSUME_NONNULL_BEGIN






@interface DDUIWebViewController : DDUIBaseViewController

@property(strong,nonatomic) WKWebView *webView;
@property(assign) BOOL shouldLoadSameWebPage;
@property(assign) BOOL isWebViewLoading;
@property (nonatomic, strong) DDUIWebViewVM *dataModel;
-(BOOL) processRequest:(NSURL *) URL;
-(void) checkAndSendAnalaytics;
-(void) setActivityIndicator;
-(void)setActivityIndicatorTintColor:(UIColor *)color;
-(void)setUpRequestBeforeLoad;
-(void)setUpRequestBeforeRefresh;
-(void)addRefreshControllInWebView;
-(BOOL)shouldPerformAction:(DDUIWebActions *)action;
@end

NS_ASSUME_NONNULL_END
