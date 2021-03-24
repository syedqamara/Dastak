//
//  DDUIBaseViewController.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 26/12/2019.
//

#import "DDUIBaseViewController.h"
#import <DDCommons/DDCommons.h>
#import "DDUIRouterManager.h"
#import "DDDraggableNavigationController.h"
#import "DDUIRefreshControl.h"
#import "DDUIBaseViewController+Navigation.h"
@interface DDUIBaseViewController () {
    DDUIRefreshControl *refreshControl;
    VoidCompletionCallBack refreshCallBack;
    UIStatusBarStyle _statusBarStyle;
}

@end

@implementation DDUIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view_did_loaded = YES;
    [self checkForDeeplinkAnalytics];
    [self registerLoadDataNotification];
    [self setNeedsStatusBarAppearanceUpdate];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setStatusBarStyle:UIStatusBarStyleDarkContent];
}
-(void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:hidden animated:animated];
}

#pragma mark - Pull To Refresh
-(void)setScrollViewVerticalContentOffset:(CGFloat)yOffset {
    if (refreshControl) {
        [refreshControl setScrollViewVerticalContentOffset:yOffset];
    }
}
-(void)setupPullToRefreshOn:(UITableView*)tableView withStartRefreshing:(VoidCompletionCallBack)withCompletion {
    refreshControl = [DDUIRefreshControl new];
    refreshCallBack = withCompletion;
    [refreshControl addTarget:self action:@selector(pullToRefreshAction) forControlEvents:(UIControlEventValueChanged)];
    tableView.refreshControl = refreshControl;
}

-(void)pullToRefreshAction {
    if (refreshCallBack!=nil)
        refreshCallBack();
}

-(void)stopPullToRefresh {
    [refreshControl endRefreshing];
}

#pragma mark - Deeplinks

-(void)checkForDeeplinkAnalytics {
    //TODO:- Find New Mechanism to Send Analytics
}

-(void)sendAnalyticsForDeeplinkAction:(NSString *)deeplink withData:(NSDictionary *)deeplinkParamData {
    //TODO:- This is not a proper way to send analytics via deeplink.
//    [DDUIRouterManager.shared navigateDeeplinkTo:@[] onController:self];
}


#pragma mark - RelaodData

-(void) registerLoadDataNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNotification:) name:REFRESH_CONTROLLER_NOTIFICATION object:nil];
}

-(void)refreshNotification:(NSNotification*)notification {
    [self refreshHomeViewOnly:notification.userInfo];
    [self refreshControllerWithData:notification.userInfo];
}

-(void)refreshControllerWithData:(id)data {

}

-(void)refreshHomeViewOnly:(id)data {

}

#pragma mark - PanModel
- (void)panTransiotionToFullScreen {
    if ([self.navigationController isKindOfClass:[DDDraggableNavigationController class]]) {
        [(DDDraggableNavigationController*)self.navigationController panTransiotionToFullScreen];
    }
}

- (BOOL)isPanInFullScreen {
    return ((DDDraggableNavigationController*)self.navigationController).isFullScreen;
}

#pragma mark - Status Bar

- (UIStatusBarStyle)preferredStatusBarStyle {
    return DDCAppConfigManager.shared.statusBarStyle;
}

#pragma mark - Other

-(void)goBackWithCompletion:(void (^ __nullable)(void))completion {
    NSUInteger count = self.navigationController.viewControllers.count;
    if (count > 1) {
        [self.navigationController popViewControllerAnimated:self.navigation.routerModel.is_animated];
        if (completion) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.33 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                completion();
            });
        }
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
           [self dismissViewControllerAnimated:self.navigation.routerModel.is_animated completion:completion];
        });
    }
}

+(void)setRouteConfiguration{
    
}
-(CGFloat)dragableHeight {
    return 0.0;
}
-(void)panIsBeingDismissed {
    
}
@end
