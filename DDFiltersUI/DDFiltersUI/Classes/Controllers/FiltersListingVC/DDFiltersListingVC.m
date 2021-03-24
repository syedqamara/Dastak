//
//  DDFiltersListingVC.m
//  DDFiltersUI
//
//  Created by Umair on 30/01/2020.
//

#import "DDFiltersListingVC.h"
#import "DDFiltersListingTVC.h"
#import "DDFiltersScreenRequestM.h"
@interface DDFiltersListingVC () <UITableViewDelegate, UITableViewDataSource, DDFiltersListingTVCDelegate>

@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray <DDFiltersSectionM *> *filtersSections;
@property (strong, nonatomic) NSMutableArray <DDFiltersSectionM *> *filtersCopy;
@property (readonly, nonatomic) DDFiltersScreenRequestM *requestModel;
@end

@implementation DDFiltersListingVC

#pragma mark - View LifeCycle
-(DDFiltersScreenRequestM *)requestModel {
    return (DDFiltersScreenRequestM *)self.navigation.routerModel.data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.requestModel mapPrevSelectedFilters];
    [self setupData];
    [self setupTableView];
}

#pragma mark ---- Other

- (void)designUI {
    
    self.resetBtn.titleLabel.font = [UIFont DDMediumFont:17];
    [self.resetBtn setTitle:RESET.localized forState:(UIControlStateNormal)];
    [self.resetBtn setTitleColor:DDFiltersThemeManager.shared.selected_theme.text_theme.colorValue forState:(UIControlStateNormal)];
    
    [self.closeBtn loadImageWithStringWithoutTemplate:@"filter_close.png" forClass:self.class];
    [self.closeBtn setTintColor:DDFiltersThemeManager.shared.selected_theme.bg_grey_199.colorValue];
    
    self.titleLbl.font = [UIFont DDBoldFont:17];
    self.titleLbl.textColor = DDFiltersThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    [self.bottomBtn setTitleColor:DDFiltersThemeManager.shared.selected_theme.text_white.colorValue forState:UIControlStateNormal];
    [self.bottomBtn setBackgroundColor:DDFiltersThemeManager.shared.selected_theme.app_theme.colorValue];
    self.bottomBtn.cornerR = 12;
    self.bottomBtn.clipsToBounds = YES;
    self.bottomBtn.titleLabel.font = [UIFont DDBoldFont:17];
    [self setBottomButtonText:1];
}

-(void)setBottomButtonText:(NSInteger)outletCount {
    [self.bottomBtn setTitle:[DDFiltersManager.shared getShowResultsTitleWithCount:outletCount] forState:UIControlStateNormal];
}

#pragma mark - API call

-(void)setupData {
    self.filtersSections = DDFiltersManager.shared.filtersData.filter_sections.mutableCopy;
    self.filtersCopy = DDFiltersManager.shared.filtersDeepCopy.mutableCopy;
    if (self.filtersSections.count == 0) {
        //loader was not showing bcz of in view did load
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf fetchFiltersWithHUD:YES];
        });
    }
}

-(void)fetchFiltersWithHUD:(BOOL)hud {
    self.filtersSections = self.requestModel.filters.mutableCopy;
    [self.tableView reloadData];
}

-(void)fetchOutletCountWithFilters {
    DDBaseRequestModel *req = [DDBaseRequestModel new];
    [req.custom_parameters addEntriesFromDictionary:DDFiltersManager.shared.getSelectedFiltersParams];
    __weak typeof(self) weakSelf = self;
    [DDFiltersManager.shared outletCountForSelectedFilters:req andCompletion:^(DDFiltersApiModel * _Nullable model, NSError * _Nullable error) {
        if (model.data != nil) {
            [weakSelf setBottomButtonText:model.data.outletCount];
        }else {
            [weakSelf setBottomButtonText:0];
        }
    }];
}

#pragma mark - UITableView

- (void)setupTableView{
    [self.tableView registerCellWithNibNames:@[FiltersListingTVC] forClass:self.class withIdentifiers:@[FiltersListingTVC]];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = 28.0;
    self.tableView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filtersSections.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DDFiltersListingTVC *cell = [tableView dequeueReusableCellWithIdentifier:FiltersListingTVC];
    cell.filterRequest = self.requestModel;
    DDFiltersSectionM *filterSection = [self.filtersSections objectAtIndex:indexPath.row];
    [cell setData:filterSection];
    [cell setDelegate:self];
    return cell;
}

#pragma mark - IBActions

- (IBAction)resetBtnAction:(id)sender {
    [DDFiltersManager.shared resetAllFilters];
    [self.tableView reloadData];
    [self fetchFiltersWithHUD:NO];
}

- (IBAction)closeBtnAction:(id)sender {
    if (self.filtersCopy.count) {
        self.requestModel.filters = self.filtersCopy.mutableCopy;
    }
    [self goBackWithCompletion:nil];
}

- (IBAction)showResultsAction:(id)sender {
    [self goBackWithCompletion:nil];
    [self.navigation.routerModel sendDataCallback:nil withData:self.requestModel withController:self];
}

#pragma mark - DDFiltersListingTVCDelegate
-(void)refreshFilters {
    [self.tableView reloadData];
    NSDictionary *lastChanges = self.requestModel.getSelectedFiltersParams;
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *newChange = self.requestModel.getSelectedFiltersParams;
        if ([lastChanges isEqualToDictionary:newChange]) {
            [weakSelf fetchFiltersWithHUD:NO];
        }
    });
}

@end
