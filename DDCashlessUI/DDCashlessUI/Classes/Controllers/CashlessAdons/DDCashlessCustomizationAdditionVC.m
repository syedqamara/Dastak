//
//  DDCashlessCustomizationAdditionVC.m
//  DDCashlessUI
//
//  Created by Syed Qamar Abbas on 12/03/2020.
//

#import "DDCashlessCustomizationAdditionVC.h"
#import "DDCustomiseCell.h"
#import "DDCustomiseHeaderView.h"

#define CELL_IDDDIFIER @"DDCustomiseCell"

@interface DDCashlessCustomizationAdditionVC ()<UITableViewDelegate, UITableViewDataSource>
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *crossButton;

@end

@implementation DDCashlessCustomizationAdditionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //_productNameLabel.text = [NSString stringWithFormat:@"Customise %@", _product.itemName];
    self.product = self.navigation.routerModel.data;
    
    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
    [self.navigationController.navigationBar setBarTintColor:UIColor.whiteColor];
    [self setStatusBarStyle:(UIStatusBarStyleDefault)];
    
    [self.tableView registerCellWithNibNames:@[CELL_IDDDIFIER] forClass:self.class withIdentifiers:@[CELL_IDDDIFIER]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 305.0;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView reloadData];
}
-(void)designUI {
    [self.addButton setTitleColor:DDCashlessThemeManager.shared.selected_theme.text_white.colorValue forState:(UIControlStateNormal)];
    self.addButton.backgroundColor = DDCashlessThemeManager.shared.selected_theme.app_theme.colorValue;
    self.addButton.layer.cornerRadius = 5;
    [self.addButton setClipsToBounds:YES];
    [self.addButton setTitle:@"Add".localized forState:(UIControlStateNormal)];
    [self.crossButton setImage:[NSBundle loadImageFromResourceBundleGIF:self.class imageName:@"cross"] forState:(UIControlStateNormal)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView delegates and datasource

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.product.customizations.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //DDCustomisationM *customization = [self.product.customizations objectAtIndex:section];
    //return customization.options.count;
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDCustomiseCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDDDIFIER];
    
    DDCashlessItemCustomizationM *customization = [self.product.customizations objectAtIndex:indexPath.section];
    
    cell.datasource = customization.options;
    cell.cust = customization;
    
    
    cell.product = self.product;
    [cell reloadTableView];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DDCustomiseHeaderView *headerView = [DDCustomiseHeaderView nibInstanceOfClass:DDCustomiseHeaderView.class];
    
    DDCashlessItemCustomizationM *customization = (DDCashlessItemCustomizationM *)[self.product.customizations objectAtIndex:section];
    headerView.nameLabel.text = customization.section_title;
    headerView.isHeaderSelected = customization.is_selected.boolValue;
    headerView.index = section;
    if (customization.show_selection.boolValue) {
        headerView.delegate = self;
    }
    headerView.checkMarkView.hidden = (customization.show_selection.boolValue == NO);
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 305;
//}

-(void)addItems:(NSArray <DDCashlessItemCustomizationOptionItemM *>*)allItems inArray:(NSMutableArray <DDCashlessItemCustomizationOptionItemM *> *)selectedArray {
    BOOL isSame = allItems.count != selectedArray.count;
    [selectedArray removeAllObjects];
    if (isSame) {
        for (DDCashlessItemCustomizationOptionItemM *subitem in allItems) {
            [selectedArray addObject:subitem];
        }
    }
}

#pragma mark - IBActions

-(void)reloadVisibleCells {
    NSArray *cells = [self.tableView visibleCells];
    for (UITableViewCell *cell in cells) {
        [cell layoutIfNeeded];
    }
}

-(void)checkOptionItemCountValidation {
    
    
    for (DDCashlessItemCustomizationM *cust in self.product.customizations) {
        
        if (![cust isShowCheckbox] || ([cust isShowCheckbox] && [cust isSelected])){
            for (DDCashlessCustomizationOptionM *order_cust in cust.options) {
                if (order_cust.minimum_option_selection != nil && order_cust.minimum_option_selection.intValue != 0) {
                    NSInteger selectedOptionCount = [order_cust itemCount];
                    if (selectedOptionCount < order_cust.minimum_option_selection.integerValue) {
                        order_cust.selectionMissing = @(1);
                        [self reloadVisibleCells];
                        [self showWarningAlert:order_cust.validation_message];
                        [self scrollToSelected:order_cust cust:cust];
                        return;
                    }
                }
                
                if (order_cust.maximum_option_selection != nil && order_cust.maximum_option_selection.intValue != 0 ){
                    NSInteger selectedOptionCount = [order_cust itemCount];
                    if (selectedOptionCount > order_cust.maximum_option_selection.integerValue) {
                        order_cust.selectionMissing = @(1);
                        [self reloadVisibleCells];
                        [self showWarningAlert:order_cust.maximum_validation_message];
                        [self scrollToSelected:order_cust cust:cust];
                        return;
                    }
                }
            }
        }
    }
    [self.product setSelectedCustomisations];
    [self allOptionsAreValidToAddInBasket];
    
}

-(void) scrollToSelected:(DDCashlessCustomizationOptionM *)order_cust cust:(DDCashlessItemCustomizationM *)cust{
    
//    int section = 0;
//    for (DDCustomisationM *cust in self.product.customizations){
//        NSInteger index = [cust.options indexOfObject:order_cust];
//        if (index != NSNotFound){
//
//            DDCustomiseCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:section]];
//            UITableView *tbleView = [cell getChildTableView];
//            CGRect rect = [tbleView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:section]];
//            rect.size.height = 300;
//            [self.tableView scrollRectToVisible:rect animated:NO];
//        }
//
//        section++;
//    }
//
//    return;
//    NSArray *visibleRows = self.tableView.indexPathsForVisibleRows;
//
//    for (NSIndexPath *path in visibleRows) {
//         DDCustomiseCell *cell = [self.tableView cellForRowAtIndexPath:path];
//         NSInteger index = [cell.cust.options indexOfObject:order_cust];
//         UITableView *tbleView = [cell getChildTableView];
//        if (index < cell.cust.options.count){
//            CGRect rect = [tbleView rectForRowAtIndexPath:path];
//            rect.size.height = 300;
//            [self.tableView scrollRectToVisible:rect animated:NO];
//        }
//    }
//
//    return;
    
    NSArray *cells = self.tableView.visibleCells;
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 5) animated:NO];
    
    BOOL isVerified = false;
    
    for (DDCustomiseCell *cell in cells){
        NSInteger index = [cell.cust.options indexOfObject:order_cust];
        UITableView *tbleView = [cell getChildTableView];
        if (index < cell.cust.options.count){
            CGRect rect = [tbleView rectForSection:index];
            rect.size.height = 300;
            [self.tableView scrollRectToVisible:rect animated:NO];
            isVerified = true;
        }
    }
}

-(void)allOptionsAreValidToAddInBasket {
//    if (_delegate != nil && [_delegate respondsToSelector:@selector(didSelectConfirmButtonWithItem:)]) {
//        [_delegate didSelectConfirmButtonWithItem:self.product];
//    }
    [self dismissViewControllerAnimated:YES completion:^{
        [self.navigation.routerModel sendDataCallback:nil withData:self.product withController:self];
    }];
}
- (IBAction)didTapCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
-(void)showWarningAlert:(NSString *)alertText {
//    [DDAlertUtil.sharedInstance showDeliverySingleButtonAlert:@"" message:alertText yesButtonTitle:@"OK" img:@"delivery_warning" completion:^(bool isSuccess) {}];
}
#pragma mark - Delegate

-(void)didHeaderSelectedWithMode:(DDCustomiseOption)mode atIndex:(NSInteger)index
{
    DDCashlessItemCustomizationM *customization = [self.product.customizations objectAtIndex:index];
    customization.is_selected = @(!mode);
    for (DDCashlessCustomizationOptionM *order_cust in customization.options) {
        order_cust.selectionMissing = @(0);
    }
    if (mode == DDCustomiseOptionRemove) {
        [customization removeAllSubItems];
    }
    [self reloadVisibleCells];
}
- (IBAction)didTapAddButton:(id)sender {
    [self checkOptionItemCountValidation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTapCrossButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
