//
//  DDWelcomeViewController.m
//  DDAuthUI
//
//  Created by Syed Qamar Abbas on 13/06/2020.
//

#import "DDWelcomeViewController.h"
#import <TYCyclePagerView/TYCyclePagerView.h>
#import <TYCyclePagerView/TYPageControl.h>
#import <DDUI.h>
#import "DDAuthUIConstants.h"
#import "DDWelcomePageCVC.h"
#import "DDAuthUIManager.h"
#import "DDLocationsUI.h"
#import "DDCoreLocation.h"
#import "DDAuth.h"
@interface DDWelcomeViewController ()<TYCyclePagerViewDelegate, TYCyclePagerViewDataSource, DDCoreLocationDelegate>
@property (weak, nonatomic) IBOutlet TYCyclePagerView *pageCollectionView;
@property (weak, nonatomic) IBOutlet TYPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *browseMerchantBtn;
@property (weak, nonatomic) IBOutlet UIButton *continueWithEmailBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) NSMutableArray <DDGeneralVM *> *pagesData;
@end


@implementation DDWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[DDCoreLocation shared] setDelegate:self];
    [[DDCoreLocation shared] requestUserLocation];
    [self setDefaultDeliveryLocation];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setStatusBarStyle:(UIStatusBarStyleLightContent)];
    [self setNavigationBarHidden:YES animated:YES];
}
-(void)locationPermissionDidChanged {
    [self setDefaultDeliveryLocation];
}
-(void)locationDidFetched {
    [self setDefaultDeliveryLocation];
}
-(void)setDefaultDeliveryLocation {
    if (DDCoreLocation.shared.isLocationServicesDenied) {
        DDLocationsManager.shared.selectedCashlessDeliveryLocation = DDAuthManager.shared.config.data.default_location;
    }else {
        [DDLocationsManager.shared getCurrentDeliveryLocationWithGeoAdress:^(DDDeliveryAddressM * _Nullable addr) {
            DDLocationsManager.shared.selectedCashlessDeliveryLocation = addr;
        }];
    }
}
-(void)designUI {
    
    self.pagesData = [NSMutableArray new];
    [self.pagesData addObject:[DDGeneralVM.alloc initWithTitle:PAGE_1_Title.localized andSubtitle:PAGE_1_Sub_Title.localized andImage:@""]];
    [self.pagesData addObject:[DDGeneralVM.alloc initWithTitle:PAGE_2_Title.localized andSubtitle:PAGE_2_Sub_Title.localized andImage:@""]];
    [self.pagesData addObject:[DDGeneralVM.alloc initWithTitle:PAGE_3_Title.localized andSubtitle:PAGE_3_Sub_Title.localized andImage:@""]];
    
    self.browseMerchantBtn.titleLabel.font = [UIFont DDMediumFont:17];
    self.continueWithEmailBtn.titleLabel.font = [UIFont DDMediumFont:17];
    [self.browseMerchantBtn setTitleColor:THEME.text_white.colorValue forState:UIControlStateNormal];
    [self.continueWithEmailBtn setTitleColor:THEME.text_white.colorValue forState:UIControlStateNormal];
    [self.browseMerchantBtn setTitle:BROWSE_NEARBY_MERCHANT.localized forState:UIControlStateNormal];
    [self.continueWithEmailBtn setTitle:CONTINUE_WITH_EMAIL.localized forState:UIControlStateNormal];
    self.continueWithEmailBtn.cornerR = 12;
    self.continueWithEmailBtn.clipsToBounds = YES;
    self.bgImageView.image = [@"landing_bg.png" pngImage:self.class];
    self.logoImageView.image = [@"logo_transparDD.png" pngImage:self.class];
    
    self.pageControl.currentPageIndicatorTintColor = THEME.bg_white.colorValue;
    self.pageControl.pageIndicatorTintColor = [THEME.bg_white.colorValue colorWithAlphaComponent:0.5];
    self.pageControl.currentPageIndicatorSize = CGSizeMake(6, 6);
    self.pageControl.pageIndicatorSize = CGSizeMake(6, 6);
    [self.pageCollectionView.collectionView registerCellWithNibNames:@[@"DDWelcomePageCVC"] forClass:self.class withIdentifiers:@[@"DDWelcomePageCVC"]];
    self.pageCollectionView.delegate = self;
    self.pageCollectionView.dataSource = self;
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.pageCollectionView reloadData];
}
- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}
-(NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    NSInteger count = self.pagesData.count;
    self.pageControl.numberOfPages = count;
    return count;
}
-(UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    DDWelcomePageCVC *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"DDWelcomePageCVC" forIndex:index];
    [cell setData:self.pagesData[index]];
    return cell;
}
-(TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [TYCyclePagerViewLayout.alloc init];
    layout.isInfiniteLoop = NO;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, pageView.frame.size.height - 20);
    layout.itemSpacing = 0.0;
    return layout;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)didTapBrowseMerchantBtn:(id)sender {
    if (DDCoreLocation.shared.isLocationServicesDenied) {
        [self goBackWithCompletion:^{
            [self enterInApp];
        }];
    }else {
        DDLocationsManager.shared.locationPickerPermission = DDDeliveryLocationPickerPermissionSetButNotSave;
        [DDLocationsUIManager.shared showAddNewLocationsVCFrom:self withData:DDLocationsManager.shared.selectedCashlessDeliveryLocation andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
            [controller dismissViewControllerAnimated:YES completion:^{
                if (data != nil) {
                    [self enterInApp];
                }
            }];
        }];
    }
    
}
-(void)enterInApp {
    DDUserManager.shared.isSkipped = YES;
    [self.navigation.routerModel sendDataCallback:nil withData:nil withController:self];
}
-(IBAction)didTapContinueWithEmailBtn:(id)sender {
    [DDAuthUIManager showLoginOptionsOnController:self WithcallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        self.navigation.routerModel.is_animated = NO;
        [self goBackWithCompletion:^{
            [self.navigation.routerModel sendDataCallback:nil withData:nil withController:self];
        }];
    }];
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Auth_Welcome andModuleName:@"DDAuthUI" withClassRef:self.class];
}
@end
