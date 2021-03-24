//
//  DDFiltersViewController.m
//  DDSearchUI
//
//  Created by Syed Qamar Abbas on 12/07/2020.
//

#import "DDFiltersViewController.h"
#import "DDSearch.h"
#import "DDFilterCheckboxCell.h"
#import "DDFilterSectionTHFV.h"
#import "DDFilterButtonTVC.h"
#import "DDSearchUIThemeManager.h"

#define TVCID_DDFilterCheckboxCell @"DDFilterCheckboxCell"
#define TVCID_DDFilterButtonTVC @"DDFilterButtonTVC"
#define THFVID_DDFilterSectionTHFV @"DDFilterSectionTHFV"

@interface DDFiltersViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DDFiltersApiM *apiModel;
@end

@implementation DDFiltersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadFilters];
    [self addCrossImageWithColor:SEARCH_THEME.app_theme.colorValue withDirection:(DDNavigationItemDirectionLeft)];
    [self addNavigationItemWithTitle:@"Save" identifier:@"save" tintColor:SEARCH_THEME.app_theme.colorValue direction:(DDNavigationItemDirectionRight)];
    // Do any additional setup after loading the view from its nib.
}
-(void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    if (sender.direction == DDNavigationItemDirectionRight) {
        [self goBackWithCompletion:^{
            [self didTapSaveButton:sender];
        }];
    }
    [super didTapOnNavigationItem:sender];
}
-(void)didTapSaveButton:(DDNavigationItem *)sender {
    if (DDSearchManager.shared.filterModel.selected_filter_param.count > 0) {
        [self.navigation.routerModel sendDataCallback:nil withData:nil withController:self];
    }
}
-(void)designUI {
    [self.tableView setSeparatorColor:UIColor.clearColor];
    [self.tableView registerCells:@[TVCID_DDFilterCheckboxCell,TVCID_DDFilterButtonTVC] forClass:self.class];
    [self.tableView registerTHFV:@[THFVID_DDFilterSectionTHFV] forClass:self.class];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = @"Filters".localized;
    
}
-(void)loadFilters {
    if (DDSearchManager.shared.filterModel == nil) {
        [DDSearchManager.shared fetchFiltersWithRequest:DDBaseRequestModel.new showHUD:YES completion:^(DDFiltersApiM * _Nullable model, NSError * _Nullable error) {
            DDSearchManager.shared.filterModel = model;
            [self loadFiltersWithModel:model];
        }];
    }else {
        [self loadFiltersWithModel:DDSearchManager.shared.filterModel];
    }
}
-(void)loadFiltersWithModel:(DDFiltersApiM *)model {
    self.apiModel = model;
    [self.tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.apiModel.data.filters.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DDFilterSectionM *filter = self.apiModel.data.filters[section];
    if (filter.type == DDFilterSectionTypeCheckbox) {
        return filter.section_list.count;
    }
    if (filter.type == DDFilterSectionTypeButtons) {
        return 1;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDFilterSectionM *sectionM = self.apiModel.data.filters[indexPath.section];
    
    if (sectionM.type == DDFilterSectionTypeCheckbox) {
        DDFilterSectionListM *rowM = sectionM.section_list[indexPath.row];
        return [self filterCheckBoxCellOfSection:sectionM withRow:rowM];
    }
    if (sectionM.type == DDFilterSectionTypeButtons) {
        return [self filterButtonsCellOfSection:sectionM withRow:nil];
    }
    return UITableViewCell.new;
}
-(UITableViewCell *)filterCheckBoxCellOfSection:(DDFilterSectionM *)sectionM withRow:(DDFilterSectionListM *)rowM {
    DDFilterCheckboxCell *cell = [self.tableView dequeueReusableCellWithIdentifier:TVCID_DDFilterCheckboxCell];
    [cell setData:rowM];
    return cell;
}

-(UITableViewCell *)filterButtonsCellOfSection:(DDFilterSectionM *)sectionM withRow:(DDFilterSectionListM *)rowM {
    DDFilterButtonTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:TVCID_DDFilterButtonTVC];
    [cell setData:sectionM];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDFilterSectionM *sectionM = self.apiModel.data.filters[indexPath.section];
    if (sectionM.type == DDFilterSectionTypeCheckbox) {
        DDFilterSectionListM *rowM = sectionM.section_list[indexPath.row];
        for (DDFilterSectionListM *sect in sectionM.section_list) {
            sect.is_selected = @(NO);
        }
        rowM.is_selected = @(YES);
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DDFilterSectionM *sectionM = self.apiModel.data.filters[section];
    DDFilterSectionTHFV *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:THFVID_DDFilterSectionTHFV];
    [header setData:sectionM];
    return header;
}
-(CGFloat)dragableHeight {
    return UIScreen.mainScreen.bounds.size.height - 50;
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
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Filter_Listing andModuleName:@"DDSearch" withClassRef:self.class];
}
@end
