//
//  DDHomeVC.m
//  DDHomeUI
//
//  Created by Syed Qamar Abbas on 22/06/2020.
//

#import "DDHomeVC.h"
#import "DDLocations.h"
#import "DDHomeUIManager.h"
#import "DDSearch.h"
#import "DDCategoryTVC.h"
#import "DDHomeTileTVC.h"
#import "DDLocations.h"
#import "DDAuth.h"
#import "DDCoreLocation.h"
@interface DDHomeVC ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, DDCategoryTVCDelegate, DDHomeTileTVCDelegate>
@property (weak, nonatomic) IBOutlet UIView *searchContainer;
@property (weak, nonatomic) IBOutlet UIImageView *searchImageView;
@property (weak, nonatomic) IBOutlet UIImageView *filterImageView;
@property (weak, nonatomic) IBOutlet UILabel *deliverToLbl;
@property (weak, nonatomic) IBOutlet UILabel *locationTitleLbl;
@property (weak, nonatomic) IBOutlet UIButton *locationSelectionBtn;
@property (weak, nonatomic) IBOutlet UILabel *notificationCount;
@property (weak, nonatomic) IBOutlet UIView *notificationContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *notificationImageView;
@property (weak, nonatomic) IBOutlet UIImageView *locationDropdownImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (strong, nonatomic) DDHomeApiM *apiModel;
@end

@implementation DDHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [DDHomeUIManager.shared proceedInAppAfterAuthentication:self onCompletion:^{
        if (DDCoreLocation.shared.isLocationServicesDenied) {
            DDLocationsManager.shared.selectedCashlessDeliveryLocation = DDAuthManager.shared.config.data.default_location;
        }
        [self reload];
    }];
    [self setupPullToRefreshOn:self.tableView withStartRefreshing:^{
        [self loadData:NO];
    }];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarHidden:YES animated:YES];
    if (DDLocationsManager.shared.selectedCashlessDeliveryLocation != nil) {
        self.locationTitleLbl.text = DDLocationsManager.shared.selectedCashlessDeliveryLocation.getTitle;
    }
}
-(void)reload {
    if (DDLocationsManager.shared.selectedCashlessDeliveryLocation != nil) {
        self.locationTitleLbl.text = DDLocationsManager.shared.selectedCashlessDeliveryLocation.getTitle;
        [self loadData:YES];
    }else {
        [DDLocationsManager.shared getCurrentDeliveryLocationWithGeoAdress:^(DDDeliveryAddressM * _Nullable addr) {
            DDLocationsManager.shared.selectedCashlessDeliveryLocation = addr;
            [self reload];
        }];
    }
}
-(void)loadData:(BOOL)showHUD {
    DDBaseRequestModel *requestModel = [DDBaseRequestModel new];
    [requestModel addCustomParams:DDLocationsManager.shared.selectedCashlessDeliveryLocation.toApiCoordinates];
    __weak typeof(self) weakSelf = self;
    [DDHomeManager.shared fetchHomeDataWithReq:requestModel showHUD:showHUD onCompletion:^(DDHomeApiM * _Nullable model, NSError * _Nullable error) {
        DDHomeUIManager.shared.categories = model.data.c_2_c_goods_type;
        weakSelf.apiModel = model;
        [self stopPullToRefresh];
        [weakSelf.tableView reloadData];
    }];
}
-(UITabBarItem *)tabBarItem {
    UITabBarItem *item = [[UITabBarItem alloc] init];
    item.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"ic-home"];
//    item.selectedImage = [[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"ic-home"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    item.title = [@"Home" localized];
    item.tag = 0;
    return item;
}
-(void)designUI {
    self.searchTF.delegate = self;
    self.locationTitleLbl.text = @"";
    [self.tableView registerCellWithNibNames:@[@"DDCategoryTVC", @"DDHomeTileTVC"] forClass:self.class withIdentifiers:@[@"DDCategoryTVC", @"DDHomeTileTVC"]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.deliverToLbl.text = DELIVER_TO.localized;
    self.deliverToLbl.font = [UIFont DDRegularFont:15];
    self.locationTitleLbl.font = [UIFont DDSemiBoldFont:17];
    self.notificationCount.font = [UIFont DDSemiBoldFont:10];
    self.deliverToLbl.textColor = HOME_THEME.text_black.colorValue;
    self.locationTitleLbl.textColor = HOME_THEME.text_black.colorValue;
    self.notificationCount.textColor = HOME_THEME.text_white.colorValue;
    self.searchContainer.backgroundColor = HOME_THEME.bg_grey_248.colorValue;
    self.searchContainer.layer.borderColor = HOME_THEME.text_grey_238.colorValue.CGColor;
    
    
    [self.notificationImageView loadImageWithString:@"ic-notifications.png" forClass:self.class];
    [self.locationDropdownImage loadImageWithString:@"ic-arrow-down.png" forClass:self.class];
    self.searchImageView.tintColor = HOME_THEME.app_theme.colorValue;
    [self.searchImageView loadTemplateImageWithString:@"icSearch.png" forClass:self.class];
    [self.filterImageView loadImageWithString:@"ic-filter.png" forClass:self.class];
    self.searchTF.placeholder = @"Search any grocery or item".localized;
    [self.locationSelectionBtn addTarget:self action:@selector(didTapSelectLocation) forControlEvents:(UIControlEventTouchUpInside)];
}
-(void)didTapSelectLocation {
    [DDHomeUIManager.shared showDeliveryLocationsVCFrom:self withData:nil andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        [self reload];
    }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apiModel.data.sections.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDHomeSectionM *sect = self.apiModel.data.sections[indexPath.row];
    if (sect.type == DDHomeSectionTypeExplore) {
        return [self exploreCellForSection:sect atIndexPath:indexPath];
    }else if (sect.type == DDHomeSectionTypeFeature) {
        return [self featuredCellForSection:sect atIndexPath:indexPath];
    }
    return [UITableViewCell new];
}
-(UITableViewCell *)exploreCellForSection:(DDHomeSectionM *)section atIndexPath:(NSIndexPath *)indexPath {
    DDCategoryTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:@"DDCategoryTVC"];
    cell.delegate = self;
    [cell setData:section];
    return cell;
}
-(UITableViewCell *)featuredCellForSection:(DDHomeSectionM *)section atIndexPath:(NSIndexPath *)indexPath {
    DDHomeTileTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:@"DDHomeTileTVC"];
    cell.delegate = self;
    [cell setData:section];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [DDHomeUIManager.shared openSearchScreenOnController:self withData:nil];
    return NO;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setScrollViewVerticalContentOffset:scrollView.contentOffset.y];
}
-(void)didSelect:(DDHomeSectionListM *)category ofSection:(DDHomeSectionM *)sectionM {
    if (category != nil) {
        if (category.outlet_id.integerValue > 0 ) {
            DDMerchantRM *outletRM = [DDMerchantRM new];
            outletRM.outlet_id = category.outlet_id;
            outletRM.merchant_id = category.merchant_id;
            outletRM.category_id = category.category_id;
            outletRM.selected_delivery_lat = DDLocationsManager.shared.selectedCashlessDeliveryLocation.latitude;
            outletRM.selected_delivery_lng = DDLocationsManager.shared.selectedCashlessDeliveryLocation.longitude;
            [outletRM addCustomParams:category.api_params];
            [DDHomeUIManager.shared showMerchantDetail:self withReqModel:outletRM andControllerCallBack:nil];
        }else {
            [self openOutletListingWithDictionary:category.toApiDictionary];
        }
    }else {
        [self openOutletListingWithDictionary:sectionM.api_param];
    }
}
-(void)openOutletListingWithDictionary:(NSDictionary *)dict {
    DDBaseRequestModel *req = [DDBaseRequestModel new];
    if (dict.count > 0) {
        [req addCustomParams:dict];
    }
    [DDHomeUIManager.shared showOutletsListingOn:self withReqModel:req andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        
    }];
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
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Home_Home andModuleName:@"" withClassRef:DDHomeVC.class];
}
- (IBAction)didTapFilterButton:(id)sender {
    [DDHomeUIManager.shared openFilterScreenOnController:self withCallback:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        NSDictionary *dict = DDSearchManager.shared.filterModel.selected_filter_param;
        if (dict.count > 0) {
            [self openOutletListingWithDictionary:dict];
        }
    }];
//    [DDHomeUIManager.shared showSettingsOnController:self WithcallBack:nil];
    
}
@end
