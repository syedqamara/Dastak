//
//  DDMerchantInfoRatingVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 04/09/2020.
//

#import "DDMerchantInfoRatingVC.h"
#import "DDHomeThemeManager.h"
#import "DDHomeManager.h"
#import "DDHomeManager.h"
#import "DDMerchantInfoVC.h"
#import "DDMerchantRatingVC.h"
@interface DDMerchantInfoRatingVC () {
    DDMerchantRatingVC *ratingVC;
    DDMerchantInfoVC *infoVC;
}

@property (unsafe_unretained, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *infoContainerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *reviewContainerView;

@end

@implementation DDMerchantInfoRatingVC
-(DDMerchantM *)merchant {
    return self.navigation.routerModel.data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.segmentControl addTarget:self action:@selector(checkAndEnabledSelectedTab) forControlEvents:(UIControlEventValueChanged)];
    self.title = [self merchant].name;
    [self addCrossImageWithColor:HOME_THEME.app_theme.colorValue withDirection:(DDNavigationItemDirectionLeft)];
    [self loadViewControllers];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadViewControllers {
    [self.segmentControl setTitle:@"Info".localized forSegmentAtIndex:0];
    [self.segmentControl setTitle:@"Reviews".localized forSegmentAtIndex:1];
    ratingVC = [DDMerchantRatingVC.alloc initWithNibName:@"DDMerchantRatingVC" forClass:DDMerchantRatingVC.class];
    infoVC = [DDMerchantInfoVC.alloc initWithNibName:@"DDMerchantInfoVC" forClass:DDMerchantInfoVC.class];
    infoVC.merchant = [self merchant];
    ratingVC.merchant = [self merchant];
    [infoVC reloadInputViews];
    [self addChildViewController:ratingVC inContainerView:self.reviewContainerView];
    [self addChildViewController:infoVC inContainerView:self.infoContainerView];
    [self checkAndEnabledSelectedTab];
}
-(void)checkAndEnabledSelectedTab {
    [self.infoContainerView setHidden:self.segmentControl.selectedSegmentIndex == 1];
    [self.reviewContainerView setHidden:self.segmentControl.selectedSegmentIndex == 0];
}

-(CGFloat)dragableHeight {
    return UIScreen.mainScreen.bounds.size.height - 100;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Merchant_Info_Container andModuleName:@"DDHomeUI" withClassRef:self];
}
@end
