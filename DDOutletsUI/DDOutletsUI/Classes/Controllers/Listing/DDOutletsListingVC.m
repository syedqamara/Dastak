//
//  DDOutletsListingVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 27/01/2020.
//

#import "DDOutletsListingVC.h"
#import "DDOutletsManager.h"
#import <DDCommons/DDCommons.h>
#import "DDOutletsThemeManager.h"
#import "DDOutletListingTVC.h"
#import "DDOutletListingPaginationTVC.h"
#import "DDOutletsUIManager.h"
#import <DDFilters/DDFilters.h>
#import "DDOutletsUIManager.h"
#import <DDAnalyticsManager.h>

@interface DDOutletsListingVC () <UITableViewDelegate, UITableViewDataSource, DDNavSearchViewDelegate> {
    DDOutletsRequestM *reqModel;
    NSMutableArray <DDOutletM*> *outlets;
    DDFiltersScreenRequestM *filtersRequest;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *navSearchBarConatiner;
@property (weak, nonatomic) IBOutlet UIImageView *filtersImageView;
@property (weak, nonatomic) IBOutlet UILabel *filtersLabel;
@property (weak, nonatomic) IBOutlet UIView *filtersView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filtersBottomConstraint;

@property (strong, nonatomic) DDNavSearchView *navSearchView;
@property (assign) BOOL stopPagination;

@end

@implementation DDOutletsListingVC

@synthesize navSearchView;

-(void)setupTableView {
    NSArray *cells = @[DDOutletListingTVCell];
    [self.tableView registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 120.0;
    __weak typeof(self) weakSelf = self;
    [self setupPullToRefreshOn:self.tableView withStartRefreshing:^{
        [weakSelf refreshTable];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    filtersRequest = [DDFiltersScreenRequestM new];
    [self setupTableView];
    
    self.filtersBottomConstraint.constant = -100;
    
    reqModel = (DDOutletsRequestM*)self.navigation.routerModel.data;
    if (reqModel == nil){
        reqModel = [[DDOutletsRequestM alloc] init];
        [reqModel getOutletsReqParams];
    }
    if ([reqModel.category isEqualToString:kFoodAndDrink]){
        [APP_ANALYTICS trackEvent:APPBOY_EVDD_FoodNDrink withType:DDEventTypeBraze andParam:@{} andEventDescription:@""];
    }
    if ([reqModel.category isEqualToString:kBeautyAndFitness]){
        [APP_ANALYTICS trackEvent:APPBOY_EVDD_BeautyNFitness withType:DDEventTypeBraze andParam:@{} andEventDescription:@""];
    }
    reqModel.radius = nil;
    outlets = [NSMutableArray new];
    
    [self.navigationController setNavigationBarHidden:YES];
    [self loadData:YES];
    DDFiltersManager.shared.filtersData = nil;
}

- (void)refreshControllerWithData:(id)data {
    [self refreshTable];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self setStatusBarStyle:(UIStatusBarStyleDefault)];
    [self.tableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)designUI{
    if (navSearchView == nil){
        [self setupSearchNavBar];
    }
    self.navSearchView.backgroundColor = [UIColor clearColor];
    self.navSearchBarConatiner.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = DDOutletsThemeManager.shared.selected_theme.bg_white.colorValue;
    self.view.backgroundColor = DDOutletsThemeManager.shared.selected_theme.app_grey_248.colorValue;
    
    self.filtersLabel.textColor = DDOutletsThemeManager.shared.selected_theme.text_white.colorValue;
       self.filtersLabel.font = [UIFont DDBoldFont:17];
    self.filtersView.cornerR = 12;
       self.filtersView.backgroundColor = DDOutletsThemeManager.shared.selected_theme.app_theme.colorValue;
       self.filtersImageView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icFilter"];
       self.filtersLabel.text = @"Filters".localized;
    
    [self.view layoutIfNeeded];
}

#pragma mark - Search Bar

-(void)setupSearchNavBar {
    navSearchView = [DDNavSearchView nibInstanceOfClass:DDNavSearchView.class];
    [self.navSearchBarConatiner addSubview:navSearchView];
    [navSearchView setData:@""];
    [navSearchView setDelegate:self];
}

- (void)openSearchScreen {
    [[DDOutletsUIManager shared] showSearchScreenFrom:self withControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
    }];
}

- (void)navSearchViewBackButtonTapped {
    [self goBackWithCompletion:nil];
}

#pragma mark - API DATA handling

- (void)refreshTable {
    reqModel.offset = @(0);
    [self loadData:NO];
}

- (void) loadData : (BOOL) showLoader{
    [self showHideFiltersView:NO];
    __weak typeof(self) weakSelf = self;
    
    if (filtersRequest.selected_filters.count > 0) {
        reqModel.selected_fitlers = [filtersRequest getSelectedFiltersParams];
    }
    reqModel.only_distinct_outlets = @(YES);
    [[DDOutletsManager shared] fetchListOfOutlets:reqModel showLoader:showLoader andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            [weakSelf processData:(DDOutletApiM*) model];
        }else{
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
        }
    }];
}

-(void) processData : (DDOutletApiM*)outletModel {

    [self stopPullToRefresh];
    self.stopPagination = outletModel.data.outlets.count == 0;
    
    if (self.stopPagination) {
        [self.tableView hideLoadMode];
    }
    else {
        [self.tableView showLoadMore];
    }
    
    if (reqModel.offset.integerValue == 0) {
        outlets = [NSMutableArray new];
    }
    
    if (outletModel.data.filters != nil) {
        filtersRequest.filters = outletModel.data.filters.mutableCopy;
    }
    
    if (outletModel != nil){
        if (outlets.count == 0) {
            outlets = outletModel.data.outlets.mutableCopy;
            if (outletModel.data.featured_merchants.count > 0) {
                int index = 0;
                for (DDMerchantFeaturedM *fmObject in outletModel.data.featured_merchants){
                    DDOutletM *otlt = (DDOutletM*)fmObject.outletObject;
                    otlt.is_featured = fmObject.is_featured;
                    if (otlt != nil){
                        [outlets insertObject:otlt atIndex:index];
                        index = index +1;
                    }
                }
            }
        } else {
            [outlets addObjectsFromArray:outletModel.data.outlets];
        }
    }
    
    [self showHideFiltersView:(outlets.count>0)];

    if (outlets.count == 0) {
        DDEmptyViewModel *emptyVM = [[DDOutletsUIManager shared] getEmptyViewModelForOutletsListing];
        [DDEmptyView showInConatiner:self.tableView withEmptyViewModel:emptyVM completion:^{}];
    }
    
    [self.tableView reloadData];
}

#pragma mark - TABLE VIEW

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return outlets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDOutletM *outlet = outlets[indexPath.row];
    DDOutletListingTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:DDOutletListingTVCell forIndexPath:indexPath];
    [cell setData:outlet];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDOutletM *outlet = outlets[indexPath.row];
    [self openMerchantDetails:outlet];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.stopPagination && indexPath.row == outlets.count-1 ) {
        reqModel.offset = @(outlets.count);
        [self loadData:NO];
    }
}


#pragma mark - FILTERS
- (void) showHideFiltersView : (BOOL) isShow {
    [UIView animateWithDuration:0.3 animations:^{
        self.filtersBottomConstraint.constant = isShow ? 24 : -100;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)filtersAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    [DDOutletsUIManager.shared openFiltersWithFilters:filtersRequest onController:self onCompletion:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        self->filtersRequest = data;
        [self->reqModel addCustomParams:self->filtersRequest.selected_filters];
        [weakSelf loadData:YES];
    }];
}

#pragma mark - GO TO DETAILS

- (void) openMerchantDetails : (DDOutletM*) outlet {
    [[DDOutletsUIManager shared] showMerchantDetailsFrom:self withOutlet:outlet andControllerCallBack:^(NSString * _Nonnull identifier, id _Nonnull data, UIViewController * _Nonnull controller) {
        [self refreshTable];
    }];
    
}
+(NSArray<DDUIRouterM *> *)deeplinkRoutes {
    DDOutletsRequestM *reqM = [DDOutletsRequestM new];
    [reqM getOutletsReqParams];
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.data = reqM;
    route.route_link = DD_Nav_Outlets_Listing;
    return @[route];
}
@end
