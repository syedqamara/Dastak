//
//  DDOutletListingVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 04/08/2020.
//

#import "DDOutletListingVC.h"
#import "DDHomeThemeManager.h"
#import "DDHomeUIManager.h"
#import "DDModels.h"
#import "DDHomeManager.h"
#import "DDOutletsTVC.h"
#import "DDLocations.h"
#import "DDSearch.h"
@interface DDOutletListingVC ()<UITableViewDelegate, UITableViewDataSource> {
    DDNavigationItem *navItem;
}
@property (weak, nonatomic) IBOutlet UILabel *filterTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *filterImageView;
@property (weak, nonatomic) IBOutlet UILabel *cuisineTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cuisineImageView;
@property (weak, nonatomic) IBOutlet UILabel *searchTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *searchImageView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DDOutletApiM *apiModel;
@end

@implementation DDOutletListingVC

-(DDBaseRequestModel *)requestModel {
    DDBaseRequestModel * req = self.navigation.routerModel.data;
    return req;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPullToRefreshOn:self.tableView withStartRefreshing:^{
        [self loadData:NO];
    }];
    [self addNavigationItemWithTitle:@"" image:@"icArrowDown.png" identifier:@"location_picker" tintColor:HOME_THEME.text_black_40.colorValue direction:(DDNavigationItemDirectionCenter)];
    navItem = [self navigationItemWithIdentifier:@"location_picker"];
    UIStackView *stack = (UIStackView *)navItem.imageView.superview;
    [stack removeArrangedSubview:navItem.imageView];
    [stack addArrangedSubview:navItem.imageView];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadData:(BOOL)showHUD {
    DDMerchantRM *req = [[self requestModel].toDictionary decodeTo:DDMerchantRM.class];
    if (DDSearchManager.shared.filterModel.selected_filter_param.count > 0) {
        [req addCustomParams:DDSearchManager.shared.filterModel.selected_filter_param];
    }
    req.selected_delivery_lat = DDLocationsManager.shared.selectedCashlessDeliveryLocation.latitude;
    req.selected_delivery_lng = DDLocationsManager.shared.selectedCashlessDeliveryLocation.longitude;
    [DDHomeManager.shared fetchOutletListingWithReq:req showHUD:showHUD onCompletion:^(DDOutletApiM * _Nullable model, NSError * _Nullable error) {
        self.apiModel = model;
        [self.tableView reloadData];
        [self stopPullToRefresh];
    }];
}
-(void)goBackWithCompletion:(void (^)(void))completion {
    [super goBackWithCompletion:^{
        [DDSearchManager.shared.filterModel reset];
        if (completion) {
            completion();
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self setNavigationBarBackgroundColor:UIColor.whiteColor];
    if (![navItem.text isEqualToString:DDLocationsManager.shared.selectedCashlessDeliveryLocation.getTitle]) {
        [self loadData:YES];
    }
    self->navItem.text = DDLocationsManager.shared.selectedCashlessDeliveryLocation.getTitle;
    
}
-(void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    [super didTapOnNavigationItem:sender];
    if (sender.direction == DDNavigationItemDirectionCenter) {
        [self didTapSelectLocation];
    }
}
-(void)didTapSelectLocation {
    [DDHomeUIManager.shared showDeliveryLocationsVCFrom:self withData:nil andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:YES completion:^{
            self->navItem.text = DDLocationsManager.shared.selectedCashlessDeliveryLocation.getTitle;
        }];
    }];
}
-(void)designUI {
    
    
    [self addBackArrowNavigtaionItemWithtitle:nil];
    self.filterTitleLabel.font = [UIFont DDRegularFont:13];
    self.filterTitleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.cuisineTitleLabel.font = [UIFont DDRegularFont:13];
    self.cuisineTitleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.searchTitleLabel.font = [UIFont DDRegularFont:13];
    self.searchTitleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    [self.filterImageView loadImageWithString:@"ic-filter.png" forClass:self.class];
    [self.cuisineImageView loadImageWithString:@"ic-cusine.png" forClass:self.class];
    self.searchImageView.tintColor = @"232323".colorValue;
    [self.searchImageView loadTemplateImageWithString:@"ic-saerch.png" forClass:self.class];
    
    self.filterTitleLabel.text = @"Filters".localized;
    self.cuisineTitleLabel.text = @"Cuisine".localized;
    self.searchTitleLabel.text = @"Search".localized;
    
    [self.tableView registerCells:@[@"DDOutletsTVC"] forClass:self.class];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apiModel.data.outlets.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDOutletsTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDOutletsTVC"];
    DDOutletM *outlet = self.apiModel.data.outlets[indexPath.row];
    [cell setData:outlet];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setScrollViewVerticalContentOffset:scrollView.contentOffset.y];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDOutletM *outlet = self.apiModel.data.outlets[indexPath.row];
    DDMerchantRM *outletRM = [DDMerchantRM new];
    outletRM.outlet_id = outlet.outlet_id;
    outletRM.merchant_id = outlet.merchant_id;
    outletRM.selected_delivery_lat = DDLocationsManager.shared.selectedCashlessDeliveryLocation.latitude;
    outletRM.selected_delivery_lng = DDLocationsManager.shared.selectedCashlessDeliveryLocation.longitude;
    [outletRM addCustomParams:outlet.api_params];
    NSMutableDictionary *dict = outlet.api_params.mutableCopy;
    [dict addEntriesFromDictionary:[self requestModel].toDictionary];
    [outletRM addCustomParams:dict];
    
    [DDHomeUIManager.shared showMerchantDetail:self withReqModel:outletRM andControllerCallBack:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTapFilterButton:(id)sender {
    [DDHomeUIManager.shared openFilterScreenOnController:self withCallback:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        [self requestModel];
        [self loadData:YES];
    }];
}
- (IBAction)didTapCuisineButton:(id)sender {
    [self didTapFilterButton:sender];
}
- (IBAction)didTapSearchButton:(id)sender {
    [DDHomeUIManager.shared openSearchScreenOnController:self withData:[self requestModel]];
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Outlets_Listing andModuleName:@"DDHomeUI" withClassRef:self];
}
@end
