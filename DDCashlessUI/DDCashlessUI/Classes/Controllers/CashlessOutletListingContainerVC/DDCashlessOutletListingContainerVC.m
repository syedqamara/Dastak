//
//  DDCashlessOutletListingContainerVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 20/03/2020.
//

#import "DDCashlessOutletListingContainerVC.h"
#import "DDCashlessOutletListingVC.h"

@interface DDCashlessOutletListingContainerVC () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *tabsContainerView;
@property (weak, nonatomic) IBOutlet UIView *pageContainerView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (strong, nonatomic) UIPageViewController *pager;
@property (strong, nonatomic) NSMutableArray *contentVCs;
@end

@implementation DDCashlessOutletListingContainerVC

- (void)viewDidLoad {
    [self setupPager];
    [self checkIFDeeplink];
    [super viewDidLoad];
}
-(BOOL)shouldHideOptionButton {
    return YES;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavBarLocation];
    if (![self shouldLoadNavigationBar]) {
        [self setNativeNavigationBarSettings];
    }else {
        [self.navigationController setNavigationBarHidden:YES];
    }
    [self setStatusBarStyle:(UIStatusBarStyleLightContent)];
}
-(void)checkIFDeeplink {
    if (self.navigation.routerModel.deeplinkModel.is_take_away.boolValue) {
        self.segmentControl.selectedSegmentIndex = 1;
        [self showSelectedViewController];
    }
}

- (void)deliveryLocationChanged {
    for (DDCashlessNavBaseVC *vc in self.contentVCs) {
        [vc deliveryLocationChanged];
    }
}

-(void)setupNavBarLocation {
    [self.navigationBar setData:DDLocationsManager.shared.selectedCashlessDeliveryLocation];
    [self deliveryLocationChanged];
}

-(void)initcontentVCs {
    self.contentVCs = [NSMutableArray new];
    DDCashlessOutletListingVC *deliveryVC = [[DDCashlessOutletListingVC alloc] initWithNibName:NSStringFromClass(DDCashlessOutletListingVC.class) forClass:DDCashlessOutletListingVC.class];
    deliveryVC.type = DDCashlessTypeDelivery;
    deliveryVC.navigation = self.navigation;
    if (!self.navigation.routerModel.deeplinkModel.is_take_away.boolValue) {
        [self.contentVCs addObject:deliveryVC];
    }
    
    
    DDCashlessOutletListingVC *takeAwayVC = [[DDCashlessOutletListingVC alloc] initWithNibName:NSStringFromClass(DDCashlessOutletListingVC.class) forClass:DDCashlessOutletListingVC.class];
    takeAwayVC.navigation = self.navigation;
    takeAwayVC.type = DDCashlessTypeTakeaway;
    if (self.navigation.routerModel.deeplinkModel.is_take_away.boolValue) {
        [self.contentVCs addObject:takeAwayVC];
    }
    
}

-(void)setupPager {
    self.pager = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                 navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                               options:nil];
    self.pager.dataSource = self;
    self.pager.delegate = self;
    self.pager.view.frame = self.pageContainerView.bounds;
    [self initcontentVCs];
    [self.pager setViewControllers:@[self.contentVCs.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self addChildViewController:self.pager inContainerView:self.pageContainerView];
    [self.pager didMoveToParentViewController:self];
}



#pragma mark - Super Class Methods
-(void)setNativeNavigationBarSettings {
    self.navigationController.view.backgroundColor = CASHLESS_THEME.app_theme.colorValue;
    self.navigationController.navigationBar.barTintColor = CASHLESS_THEME.app_theme.colorValue;
    self.navigationController.navigationBar.tintColor = CASHLESS_THEME.text_white.colorValue;
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationItem.title = @"Takeaways".localized;
}
- (void)designUI {
    [self setNativeNavigationBarSettings];
    [super designUI];
}

-(BOOL)shouldLoadNavigationBar {
    return self.segmentControl.selectedSegmentIndex == 0;
}

#pragma mark - UIPageViewController

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.contentVCs indexOfObject:viewController];
    index--;
    if ( index<0) {
        return nil;
    }
    return [self.contentVCs objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.contentVCs indexOfObject:viewController];
    index++;
    if (index >= self.contentVCs.count) {
        return nil;
    }
    return [self.contentVCs objectAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        NSInteger index = [self.contentVCs indexOfObject:self.pager.viewControllers.firstObject];
        self.segmentControl.selectedSegmentIndex = index;
    }
}


- (IBAction)segmentChanged:(UISegmentedControl*)sender {
    [self showSelectedViewController];
    [self showNavBarWithDuration:0.4];
}
-(void)showSelectedViewController {
    NSInteger index = self.segmentControl.selectedSegmentIndex;
    UIViewController *vc = [self.contentVCs objectAtIndex:0];
    NSInteger direction = UIPageViewControllerNavigationDirectionReverse;
    if(index >= self.contentVCs.count-1){
        direction = UIPageViewControllerNavigationDirectionForward;
    }
    [self.pager setViewControllers:@[vc] direction:direction animated:YES completion:nil];
}
+(NSArray<DDUIRouterM *> *)deeplinkRoutes {
    DDUIRouterM *r1 = [[DDUIRouterM alloc]init];
    r1.route_link = DD_Nav_Cashless_Outlet_Listing_Continer;
    r1.transition = DDUITransitionPush;
    r1.is_animated = YES;
    r1.should_embed_in_nav = NO;
    return @[r1];
}

@end
