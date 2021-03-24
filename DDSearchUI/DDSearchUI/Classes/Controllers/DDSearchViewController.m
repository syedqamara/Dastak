//
//  DDSearchViewController.m
//  DDSearchUI
//
//  Created by Syed Qamar Abbas on 14/01/2020.
//

#import "DDSearchViewController.h"
#import "DDSearchRestaurantsTVC.h"
#import "DDSearchDishesTVC.h"
#import <DDModels.h>
#import <DDSearch.h>
#import "DDLocationsManager.h"
#import "DDHomeUI.h"
@interface DDSearchViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *crossImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UIButton *clearTFBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIImageView *searchImageView;
@property (weak, nonatomic) IBOutlet UIView *searchContainerView;
@property (strong, nonatomic) DDSearchApiM *apiModel;
@property (strong, nonatomic) DDSearchRM *searchRequestM;
@end

@implementation DDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchRequestM = [DDSearchRM new];
    [self loadData:YES];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadData:(BOOL)showHUD {
    if (self.navigation.routerModel.data != nil) {
        DDBaseRequestModel *req = self.navigation.routerModel.data;
        [self.searchRequestM addCustomParams:req.toDictionary];
    }
    
    [DDSearchManager.shared searchWithRequest:self.searchRequestM showHUD:showHUD completion:^(DDSearchApiM * _Nullable model, NSError * _Nullable error) {
        self.apiModel = model;
        [self.tableView reloadData];
    }];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarHidden:YES animated:YES];
    [self shouldHideClearTFButton:YES];
}
-(void)designUI {
    [self setNavigationBarHidden:YES animated:YES];
    [self.tableView registerCellWithNibNames:@[@"DDSearchRestaurantsTVC", @"DDSearchDishesTVC"] forClass:self.class withIdentifiers:@[@"DDSearchRestaurantsTVC", @"DDSearchDishesTVC"]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchContainerView.borderW = 1;
    self.searchContainerView.borderColor = SEARCH_THEME.app_theme.colorValue;
    [self.searchImageView loadImageWithString:@"ic-saerch.png" forClass:self.class];
    self.crossImageView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"cross.png"];
//    self.clearTFBtn.imageView.tintColor = UIColor.clearColor;
    self.cancelBtn.titleLabel.font = [UIFont DDMediumFont:17];
    self.searchTF.placeholder = @"Search any grocery or item".localized;
    self.searchTF.font = [UIFont DDRegularFont:15];
    [self.cancelBtn setTitleColor:SEARCH_THEME.text_grey_111.colorValue forState:(UIControlStateNormal)];
    [self.cancelBtn setTitle:@"Cancel".localized forState:(UIControlStateNormal)];
    self.searchTF.textColor = SEARCH_THEME.text_black.colorValue;
    [self.searchTF addTarget:self action:@selector(didChangeText) forControlEvents:(UIControlEventEditingChanged)];
}
-(void)didChangeText{
    self.searchRequestM.query = self.searchTF.text;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.searchTF.text isEqualToString:self.searchRequestM.query]) {
            [self loadData:NO];
        }
    });
    [self.tableView reloadData];
    [self shouldHideClearTFButton:self.searchTF.text.length == 0];
}
-(void)shouldHideClearTFButton:(BOOL)shouldHide {
    [UIView animateWithDuration:0.2 animations:^{
        [self.clearTFBtn.superview setHidden:shouldHide];
        [self.crossImageView setHidden:shouldHide];
    }];
}
- (IBAction)didTapClearTFButton:(id)sender {
    self.searchTF.text = @"";
    [self didChangeText];
}

- (IBAction)didTapCancelButton:(id)sender {
    [self goBackWithCompletion:nil];
}

#pragma UITableViewDataSourceDelegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.apiModel.data.results.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DDSearchSectionM *sect = self.apiModel.data.results[section];
    return sect.section_list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDSearchSectionM *sect = self.apiModel.data.results[indexPath.section];
    DDSearchSectionListM *list = sect.section_list[indexPath.row];
    list.search_text = self.searchTF.text;
    if (sect.type == DDSearchSectionTypeMerchant) {
        DDSearchRestaurantsTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDSearchRestaurantsTVC"];
        
        [cell setData:list];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        return cell;
    }
    else if (sect.type == DDSearchSectionTypeItems) {
        DDSearchDishesTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDSearchDishesTVC"];
        [cell setData:list];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        return cell;
    }
    return [UITableViewCell new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDSearchSectionM *sect = self.apiModel.data.results[indexPath.section];
    DDSearchSectionListM *list = sect.section_list[indexPath.row];
    
    DDMerchantRM *outletRM = [DDMerchantRM new];
    outletRM.outlet_id = list.outlet_id;
    outletRM.merchant_id = list.merchant_id;
    outletRM.category_id = list.category_id;
    [outletRM addCustomParams:list.api_params];
    outletRM.selected_delivery_lat = DDLocationsManager.shared.selectedCashlessDeliveryLocation.latitude;
    outletRM.selected_delivery_lng = DDLocationsManager.shared.selectedCashlessDeliveryLocation.longitude;
    [DDHomeUIManager.shared showMerchantDetail:self withReqModel:outletRM andControllerCallBack:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

+(NSArray<DDUIRouterM *> *)deeplinkRoutes {
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Search_Search;
    route.transition = DDUITransitionPresent;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    return @[route];
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Search_Search andModuleName:@"" withClassRef:self.class];
}
@end
