//
//  DDUIBaseViewController.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 26/12/2019.
//

#import <UIKit/UIKit.h>
#import "DDUIThemeViewController.h"
#import "DDNavigationProtocol.h"
#import "DDNavigationItem.h"
#import "UIViewController+DDViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDUIBaseViewController : DDUIThemeViewController <DDNavigationProtocol>
@property (strong, nonatomic) DDUIRouterInfoM *navigation;
@property (strong, nonatomic) NSMutableArray <DDNavigationItem *> *navigationItems;
@property (assign, nonatomic) BOOL view_did_loaded;
@property (assign, nonatomic) BOOL isPanInFullScreen;
-(void)goBackWithCompletion:(void (^ __nullable)(void))completion;
-(void)sendAnalyticsForDeeplinkAction:(NSString *)deeplink withData:(NSDictionary *)deeplinkParamData;
-(void)checkForDeeplinkAnalytics;
-(void)refreshControllerWithData:(id)data;
-(void)refreshHomeViewOnly:(id)data;
-(void)setupPullToRefreshOn:(UITableView*)tableView withStartRefreshing:(VoidCompletionCallBack)withCompletion;
-(void)stopPullToRefresh;
-(void)panTransiotionToFullScreen;
-(void)setScrollViewVerticalContentOffset:(CGFloat)yOffset;
+(NSArray <DDUIRouterM *> *)deeplinkRoutes;
-(void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;
+(void)setRouteConfiguration;
-(CGFloat)dragableHeight;
-(void)panIsBeingDismissed;
@end

NS_ASSUME_NONNULL_END
