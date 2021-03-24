//
//  DDCashlessOutletListingVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 12/03/2020.
//

#import "DDCashlessOutletListingVC.h"
#import "DDCashlessOutletTVC.h"
#import "DDCashlessOutletListingTitleHFV.h"
#import "DDCashlessOutletListingVM.h"
#import "DDCashlessCuisinesTVC.h"
#import "DDFiltersUI.h"
#import <DDAnalyticsManager.h>

#define PAGE_LIMIT 60

@interface DDCashlessOutletListingVC () <UITableViewDelegate, UITableViewDataSource, DDCashlessOutletListingTitleHFVDelegate, DDCashlessCuisinesTVCDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *searchBarConatiner;
@property (weak, nonatomic) IBOutlet UIImageView *searchIcon;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (assign) BOOL stopPagination;
@property (strong, nonatomic) DDCashlessOutletListingVM *listingData;

@end

@implementation DDCashlessOutletListingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listingData = [DDCashlessOutletListingVM new];
    [self setupTableView];
    [self loadDataFromServerWithOffset:0];
    [self loadCashlessFilters];
    [APP_ANALYTICS trackEvent:APPBOY_EVDD_DeliverySection withType:DDEventTypeBraze andParam:@{} andEventDescription:@""];
}

- (void)deliveryLocationChanged {
    [self loadDataFromServerWithOffset:0];
}


-(DDOutletsRequestM*)getRequestM {
    DDOutletsRequestM *reqM = [DDOutletsRequestM new];
    [reqM getOutletsReqParams];
    [reqM addCustomParams:self.navigation.routerModel.deeplinkModel.toApiDictionary];
    [reqM addCustomParams:DDFiltersManager.shared.getSelectedDeliveryFiltersParams];
    [reqM addCustomParams:DDLocationsManager.shared.selectedCashlessDeliveryLocation.getLocationParams];
    NSDictionary *temp = @{
        @"is_cinema_society_enabled" : @(1),
        @"is_last_mile_enabled" : @(1),
    };
    reqM.only_distinct_outlets = @(YES);
    [reqM addCustomParams:temp];
    return reqM;
}


-(void)loadDataFromServerWithOffset:(NSUInteger)offset {
    if (self.stopPagination && offset > 0) return;
    __weak typeof(self) weakSelf = self;
    DDOutletsRequestM *reqM = [self getRequestM];
    reqM.offset = @(offset);
    [DDCashlessManager.shared fetchOuteltsWithRequest:reqM showLoader: offset==0 completion:^(DDOutletApiM * _Nullable model, NSError * _Nullable error) {
        if (model) {
            if (model.successfulApi) {
                [weakSelf.listingData setUpApiDataIntoVM:model];
                weakSelf.stopPagination = model.data.outlets.count == 0;
                [weakSelf responseReceived];
            }
            else {
                [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:nil];
            }
        }
        else {
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
        }
    }];
}


-(void)loadOutletsForMerchant:(NSNumber*)m_id withCompletion:(void (^)(NSArray * _Nullable))completion {
    DDOutletsRequestM *reqM = [self getRequestM];
    reqM.m_ids = m_id;
    [DDCashlessManager.shared fetchOuteltsWithRequest:reqM showLoader:YES completion:^(DDOutletApiM * _Nullable model, NSError * _Nullable error) {
        if (model) {
            if (model.successfulApi) {
                completion(model.data.outlets);
            }
            else {
                [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:nil];
            }
        }
        else {
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
        }
    }];
}

-(void)responseReceived {
    
    [self stopPullToRefresh];
    [UIApplication dismissDDLoaderAnimation];

    if (self.stopPagination) {
        [self.tableView hideLoadMode];
    }
    else {
        [self.tableView showLoadMore];
    }
    
    [self.tableView reloadData];
}

-(void)setupFiltersData {
    
}

#pragma mark - Super Class Methods
- (void)designUI {
    
    [self.searchIcon loadImageWithString:@"icSearch.png" forClass:self.class];
    
    self.searchTF.font = [UIFont DDRegularFont:17];
    self.searchTF.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.searchBarConatiner.cornerR = 12;
    self.searchBarConatiner.borderW = 0.5;
    self.searchBarConatiner.borderColor = DDCashlessThemeManager.shared.selected_theme.border_grey_199.colorValue;
    self.searchBarConatiner.clipsToBounds = YES;
}

#pragma mark - UITableView
-(void)setupTableView {
    NSArray *cells = @[CashlessOutletTVC, CashlessCuisinesTVC];
    [self.tableView registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    NSArray *header = @[CashlessOutletListingTitleHFV];
    [self.tableView registerHeaderFooterWithNibNames:header forClass:self.class withIdentifiers:header];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 120.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = 50.0;
    self.tableView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    __weak typeof(self) weakSelf = self;
    [self setupPullToRefreshOn:self.tableView withStartRefreshing:^{
        [weakSelf loadDataFromServerWithOffset:0];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listingData.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DDCashlessOutletListingSectionVM *sectionVM = [self.listingData.sections objectAtIndex:section];
    if (sectionVM.type == DDCOListingSectionVMTypeFilters) {
        return 1;
    }
    else if (sectionVM.type == DDCOListingSectionVMTypeOutlets) {
        return sectionVM.outlets.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDCashlessOutletListingSectionVM *sectionVM = [self.listingData.sections objectAtIndex:indexPath.section];
    if (sectionVM.type == DDCOListingSectionVMTypeFilters) {
        DDCashlessCuisinesTVC *cell = [tableView dequeueReusableCellWithIdentifier:CashlessCuisinesTVC forIndexPath:indexPath];
        [cell setDelegate:self];
        [cell setData:sectionVM];
        return cell;
    }
    else if (sectionVM.type == DDCOListingSectionVMTypeOutlets) {
        DDCashlessOutletTVC *cell = [tableView dequeueReusableCellWithIdentifier:CashlessOutletTVC forIndexPath:indexPath];
        DDOutletM *outlet = [sectionVM.outlets objectAtIndex:indexPath.row];
        [cell setData:outlet];
        return cell;
    }
    return [UITableViewCell new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DDCashlessOutletListingTitleHFV *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessOutletListingTitleHFV];
    DDCashlessOutletListingSectionVM *sectionVM = [self.listingData.sections objectAtIndex:section];
    [view setData:sectionVM];
    view.delegate = self;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    DDCashlessOutletListingSectionVM *sectionVM = [self.listingData.sections objectAtIndex:section];
    return sectionVM.section_title.length ? UITableViewAutomaticDimension : 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDCashlessOutletListingSectionVM *sectionVM = [self.listingData.sections objectAtIndex:indexPath.section];
    if (sectionVM.type == DDCOListingSectionVMTypeOutlets) {
        DDOutletM *outlet = [sectionVM.outlets objectAtIndex:indexPath.row];
        if (outlet.shouldShowOutletSelectionDCVC) {
            __weak typeof(self) weakSelf = self;
            [self loadOutletsForMerchant:outlet.merchant.merchant_id withCompletion:^(NSArray * _Nullable data) {
                [weakSelf showOutletSelectionWithData:data];
            }];
        }
        else {
            [self showMerchnatDetailWithData:outlet];
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    DDCashlessOutletListingSectionVM *sectionVM = [self.listingData.sections objectAtIndex:indexPath.section];
    if (sectionVM.type == DDCOListingSectionVMTypeOutlets) {
        if (!self.stopPagination && indexPath.row == sectionVM.outlets.count-1 ) {
            [self loadDataFromServerWithOffset:sectionVM.outlets.count];
        }
    }
    
}


-(void)showOutletSelectionWithData:(id)data {
    __weak typeof(self) weakSelf = self;
    [DDCashlessUIManager.shared showCashlessOutletSelectionVCFrom:self withData:data andControllerCallBack:^(NSString * _Nonnull txt, id _Nonnull data, UIViewController * _Nonnull controller) {
        [weakSelf showMerchnatDetailWithData:data];
    }];
}

-(void)showMerchnatDetailWithData:(DDOutletM *)data{
    
    DDCashlessRequestM *req = [DDCashlessRequestM new];
    req.merchant_id = data.merchant.merchant_id;
    req.outlet_id = data.outlet_id;
    req.cashless_delivery_param = data.cashless_delivery_params;
    req.api_params = data.api_params;
    req.is_new_order_status_flow = @(YES);
    req.is_delivery_tab_selected = @(self.type == DDCashlessTypeDelivery);
    [DDCashlessUIManager.shared showCashlessMerchantDetailVCFrom:self withData:req andControllerCallBack:nil];
}

#pragma mark - Filters

-(void)loadCashlessFilters {
    if (self.navigation.routerModel.deeplinkModel.is_take_away.boolValue) return;
    __weak typeof(self) weakSelf = self;
    [DDCashlessManager.shared fetchCashlessFiltersWithCompletion:^(DDFiltersApiModel * _Nullable model, NSError * _Nullable error) {
        if (model.successfulApi) {
            [weakSelf.listingData setUpApiDataIntoVM:model];
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)cuisineSelected {
    // for selected image in main cuisine collection view
    NSMutableArray *ary = DDFiltersManager.shared.getSelectedDeliveryFilters;
    DDCashlessOutletListingSectionVM *sec = self.listingData.sections.firstObject;
    for (DDFiltersOptionM *option in sec.filtersData.options) {
        for (DDFiltersOptionM *selected in ary) {
            if ([selected.uid isEqualToString:option.uid])
                option.selected = @(1);
        }
    }
    [self.tableView reloadData];
    [self loadDataFromServerWithOffset:0];
}

- (void)didTapOnCashlessOutletListingTitleHFVButton:(id)data {
    if (self.listingData.sections.count == 0) return;
    DDCashlessOutletListingSectionVM *sec = self.listingData.sections.firstObject;
    if (sec.filtersData.options.count == 0) return;
    
    DDFiltersSectionM *filtersSection = [DDFiltersSectionM new];
    filtersSection.options = sec.filtersData.options;
    filtersSection.minimum_option_display = sec.filtersData.minimum_option_display;
    
    __weak typeof(self) weakSelf = self;
    [DDCashlessUIManager openFilterOptionsFrom:self withData:filtersSection andControllerCallBack:^(NSString * _Nonnull txt, id _Nonnull data, UIViewController * _Nonnull from) {
        [weakSelf.tableView reloadData];
        [weakSelf loadDataFromServerWithOffset:0];
    }];
}

@end
