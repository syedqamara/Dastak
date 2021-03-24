//
//  DDAddCustomisationVC.m
//  ANStepperView
//
//  Created by Syed Qamar Abbas on 30/07/2020.
//

#import "DDAddCustomisationVC.h"
#import "DDAddCustomisationTVC.h"
#import "DDAddCustomisationTHFV.h"
#import "DDHomeThemeManager.h"
#import "DDModels.h"

@interface DDAddCustomisationVC ()<UITableViewDelegate, UITableViewDataSource, DDAddCustomisationTHFVDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *addButton;
@property (readonly) DDMerchantDeliveryMenuItemM *item;
@end

@implementation DDAddCustomisationVC
-(DDMerchantDeliveryMenuItemM *)item {
    return self.navigation.routerModel.data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerTHFV:@[@"DDAddCustomisationTHFV"] forClass:self.class];
    [self.tableView registerCells:@[@"DDAddCustomisationTVC"] forClass:self.class];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedSectionHeaderHeight = 64;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    [self addCrossImageWithColor:HOME_THEME.app_theme.colorValue withDirection:(DDNavigationItemDirectionLeft)];
    self.title = self.item.name;
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.item.customizations.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    DDMerchantMenuItemCustomizationM *cust = self.item.customizations[section];
    if (cust.isOpened) {
        return cust.options.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDAddCustomisationTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDAddCustomisationTVC"];
    DDMerchantMenuItemCustomizationM *cust = self.item.customizations[indexPath.section];
    DDMerchantMenuItemCustomizationOptionM *option = cust.options[indexPath.row];
    option.currency = self.item.currency;
    [cell setData:option];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DDAddCustomisationTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DDAddCustomisationTHFV"];
    view.delegate = self;
    [view setData:self.item.customizations[section]];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
-(void)didTapExpandCollapseButtonWithCust:(DDMerchantMenuItemCustomizationM *)cust {
    NSInteger section = [self.item.customizations indexOfObject:cust];
    [self.tableView beginUpdates];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    [self.tableView endUpdates];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDMerchantMenuItemCustomizationM *cust = self.item.customizations[indexPath.section];
    DDMerchantMenuItemCustomizationOptionM *option = cust.options[indexPath.row];
    
    [self.item insertAdon:option inCust:cust];
//    if (cust.allowSingleSelection) {
//        [cust resetAllSelection];
//        option.is_selected = @(YES);
//    }else {
//        [option toggle];
//    }
//
    [self didTapExpandCollapseButtonWithCust:cust];
}
-(CGFloat)dragableHeight {
    return UIScreen.mainScreen.bounds.size.height;
}
-(IBAction)didTapAddButton:(id)sender {
    [self goBackWithCompletion:^{
        [self saveAllSelectedAdons];
    }];
    
}
-(void)saveAllSelectedAdons {
    NSMutableArray *arr = [NSMutableArray new];
    
    for (DDMerchantMenuItemCustomizationM *cust in self.item.customizations) {
        for (DDMerchantMenuItemCustomizationOptionM *opt in cust.options) {
            if (opt.isSelected) {
                [arr addObject:opt];
            }
        }
    }
    self.item.selected_options = arr;
    [self.navigation.routerModel sendDataCallback:nil withData:self.item withController:self];
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Item_Customization andModuleName:@"DDHomeUI" withClassRef:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
