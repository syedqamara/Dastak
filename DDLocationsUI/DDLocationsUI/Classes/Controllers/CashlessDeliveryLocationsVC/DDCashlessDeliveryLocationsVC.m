//
//  DDCashlessDeliveryLocationsVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 13/02/2020.
//

#import "DDCashlessDeliveryLocationsVC.h"
#import "DDCashlessDeliveryLocationsTVC.h"
#import "DDCashlessDeliveryLocationsTHFV.h"
#import "DDLocationsUIConstants.h"
#import "DDCoreLocation.h"
#import "DDAuthManager.h"
@interface DDCashlessDeliveryLocationsVC () <UITableViewDelegate, UITableViewDataSource, DDCashlessDeliveryLocationsTHFVDelegate, DDDraggableNavigationControllerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *searchContainer;
@property (weak, nonatomic) IBOutlet UIImageView *searchImage;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DDCashlessDeliveryLocationsVM* cashlesslocationsVM;
@end

@implementation DDCashlessDeliveryLocationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    self.searchTF.delegate = self;
    if ([self.navigationController isKindOfClass:[DDDraggableNavigationController class]]) {
        [(DDDraggableNavigationController*)self.navigationController setPanModelDelegate:self];
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self panTransiotionToFullScreen];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setWhiteDragableNavigationBar];
    [self getCashlessDeliveryLocations];
}

-(void)getCashlessDeliveryLocations {
    __weak typeof (self) weakSelf = self;
    [DDLocationsManager.shared fetchCashlessDeliveryLocationsWithCompletion:^(DDDeliveryLocationsAPI * _Nullable model, NSError * _Nullable error) {
        if (model != nil) {
            if (model.successfulApi) {
                weakSelf.cashlesslocationsVM = [DDCashlessDeliveryLocationsVM setupDataFromSavedDeliveryArray:model.data.delivery_locations];
                DDLocationsManager.shared.cashlessDeliveryLocationTags = model.data.location_tags.mutableCopy;
//                weakSelf.cashlesslocationsVM = [DDCashlessDeliveryLocationsVM setupDataFromSavedDeliveryArray:DDLocationsManager.shared.cashlessDeliveryLocations];
                [weakSelf textDidChange:weakSelf.searchTF.text];
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

#pragma mark - UITableView

-(void)setupTableView {
    NSArray *cells = @[CashlessDeliveryLocationsTVC];
    [self.tableView registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    NSArray *headers = @[CashlessDeliveryLocationsTHFV];
    [self.tableView registerHeaderFooterWithNibNames:headers forClass:self.class withIdentifiers:headers];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 58;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = 58;
    self.tableView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cashlesslocationsVM.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.cashlesslocationsVM.sections objectAtIndex:section] locations].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDCashlessDeliveryLocationsTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:CashlessDeliveryLocationsTVC forIndexPath:indexPath];
    DDCashlessDeliveryLocationsSectionVM *sectionVM = [self.cashlesslocationsVM.sections objectAtIndex:indexPath.section];
    DDDeliveryAddressM *data = [sectionVM.locations objectAtIndex:indexPath.row];
    [cell setData:data];
    cell.editButton.tag = indexPath.row;
    cell.selectionButton.tag = indexPath.row;
    [cell.editButton addTarget:self action:@selector(didTapEditButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectionButton addTarget:self action:@selector(didTapDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)didTapEditButton:(UIButton *)btn {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag inSection:self.cashlesslocationsVM.sections.count - 1];
    DDCashlessDeliveryLocationsSectionVM *sectionVM = [self.cashlesslocationsVM.sections objectAtIndex:indexPath.section];
    DDDeliveryAddressM *location = [sectionVM.locations objectAtIndex:indexPath.row];
    [self editLocation:location completion:nil];
}
-(void)didTapDeleteButton:(UIButton *)btn {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag inSection:self.cashlesslocationsVM.sections.count - 1];
    
    DDCashlessDeliveryLocationsSectionVM *sectionVM = [self.cashlesslocationsVM.sections objectAtIndex:indexPath.section];
    DDDeliveryAddressM *location = [sectionVM.locations objectAtIndex:indexPath.row];
    if (DDLocationsManager.shared.selectedCashlessDeliveryLocation.delivery_location_id.integerValue == location.delivery_location_id.integerValue) {
        [self setDefaultDeliveryLocation];
    }
    [self deleteLocation:location completion:^{
        [(NSMutableArray*)sectionVM.locations removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    }];
    
    
}
-(void)setDefaultDeliveryLocation {
    if (DDCoreLocation.shared.isLocationServicesDenied) {
        DDLocationsManager.shared.selectedCashlessDeliveryLocation = DDAuthManager.shared.config.data.default_location;
    }else {
        [DDLocationsManager.shared getCurrentDeliveryLocationWithGeoAdress:^(DDDeliveryAddressM * _Nullable addr) {
            DDLocationsManager.shared.selectedCashlessDeliveryLocation = addr;
        }];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DDCashlessDeliveryLocationsTHFV *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessDeliveryLocationsTHFV];
    DDCashlessDeliveryLocationsSectionVM *sectionVM = [self.cashlesslocationsVM.sections objectAtIndex:section];
    [view setData:sectionVM];
    [view setDelegate:self];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDCashlessDeliveryLocationsSectionVM *sectionVM = [self.cashlesslocationsVM.sections objectAtIndex:indexPath.section];
    DDDeliveryAddressM *location = [sectionVM.locations objectAtIndex:indexPath.row];
    if (DDLocationsManager.shared.locationPickerPermission != DDDeliveryLocationPickerPermissionNotSetNotSave) {
        DDLocationsManager.shared.selectedCashlessDeliveryLocation = location;
    }
    [self goBackWithCompletion:^{
        [self.navigation.routerModel sendDataCallback:nil withData:location withController:self];
    }];
}

#pragma mark - Other

-(void)deleteLocation:(DDDeliveryAddressM*)location completion:(void (^ _Nullable)(void))completion {
    NSString *msg = [NSString stringWithFormat:@"Do you want to delete this \n %@?",location.getTitle].localized;
    [DDAlertUtils showAlertWithTitle:nil subtitle:msg buttonNames:@[@"Yes", @"No"] onClick:^(int index) {
        if (index == 0) {
            DDCashlessLocationsRequestM *req = [DDCashlessLocationsRequestM new];
            req.delivery_location_id = location.delivery_location_id;
            [DDLocationsManager.shared deleteCashlessDeliveryLocationWithRequest:req callBack:^(DDDeliveryLocationsAPI * _Nullable model, NSError * _Nullable error) {
                if (model) {
                    if (model.successfulApi) {
                        if (completion != nil) {
                            completion();
                        }
                    }
                    else {
                        [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:nil];
                    }
                }
                else {
                    [DDAlertUtils showOkAlertWithTitle:@"" subtitle:msg completion:nil];
                }
            }];
        }
    }];
}

-(void)editLocation:(DDDeliveryAddressM*)location completion:(void (^ _Nullable)(void))completion {
//    [self moveToLocationDetailsVC:location];
    [self moveToNewLocationVC:location];
}

- (void)addNewLocationTapped {
    __weak typeof (self) weakSelf = self;
    [UIApplication showDDLoaderAnimation];
    [DDLocationsManager.shared getCurrentDeliveryLocationWithGeoAdress:^(DDDeliveryAddressM * _Nullable adrs) {
        [UIApplication dismissDDLoaderAnimation];
        if (adrs) {
            adrs.is_new_location = @(1);
            adrs.is_current_location = @(0);
            [weakSelf moveToNewLocationVC:adrs];
        }
    }];
}

- (void)currentLocationTapped {
    __weak typeof (self) weakSelf = self;
    [UIApplication showDDLoaderAnimation];
    [DDLocationsManager.shared getCurrentDeliveryLocationWithGeoAdress:^(DDDeliveryAddressM * _Nullable adrs) {
        [UIApplication dismissDDLoaderAnimation];
        if (adrs) {
            adrs.is_current_location = @(0);
            [weakSelf moveToLocationDetailsVC:adrs];
        }
    }];
}

-(void)moveToLocationDetailsVC:(id)data {
    [self panTransiotionToFullScreen];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [DDLocationsUIManager.shared showCashlessLocationDetailsVCFrom:self withData:data andControllerCallBack:self.navigation.routerModel.callback];
    });
}

-(void)moveToNewLocationVC:(id)data {
    [self panTransiotionToFullScreen];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [DDLocationsUIManager.shared showAddNewLocationsVCFrom:self withData:data andControllerCallBack:self.navigation.routerModel.callback];
    });
}

#pragma mark - Overridden methods

- (void)designUI {
    
    
    self.searchTF.font = [UIFont DDRegularFont:15];
    self.searchTF.textColor = LOCATION_THEME.text_black.colorValue;
    self.titleLbl.font = [UIFont DDSemiBoldFont:17];
    self.titleLbl.textColor = LOCATION_THEME.text_black.colorValue;
    [self.searchImage loadImageWithString:@"ic-saerch.png" forClass:self.class];
    self.searchContainer.backgroundColor = LOCATION_THEME.bg_grey_248.colorValue;
    self.searchContainer.borderColor = LOCATION_THEME.text_grey_238.colorValue;
    self.searchContainer.borderW = 1;
    self.searchContainer.cornerR = 12;
    [self.searchContainer setClipsToBounds:YES];
    self.searchTF.placeholder = L_SEARCH_FOR_ANY_LOCATION.localized;
    self.titleLbl.text = L_DELIVER_TO.localized;
    if ([self.navigation.routerModel.data isKindOfClass:NSString.class]) {
        NSString *str = self.navigation.routerModel.data;
        if (str.length > 0) {
            self.titleLbl.text = str;
        }
    }
    [self.searchTF addTarget:self action:@selector(didChangeText:) forControlEvents:(UIControlEventEditingChanged)];
}
-(void)didChangeText:(UITextField *)textField {
    [self textDidChange:textField.text];
}
-(void)textDidChange:(NSString *)text {
    DDCashlessDeliveryLocationsSectionVM *sect = self.cashlesslocationsVM.sections.lastObject;
    if (text.length == 0) {
        sect.locations = DDLocationsManager.shared.cashlessDeliveryLocations;
    }else {
        NSPredicate *pred = [NSPredicate predicateWithBlock:^BOOL(DDDeliveryAddressM *  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            if ([evaluatedObject.getTitle isNonCaseContains:text]) {
                return YES;
            }
            if ([evaluatedObject.flat isNonCaseContains:text]) {
                return YES;
            }
            if ([evaluatedObject.building isNonCaseContains:text]) {
                return YES;
            }
            if ([evaluatedObject.street isNonCaseContains:text]) {
                return YES;
            }
            if ([evaluatedObject.area isNonCaseContains:text]) {
                return YES;
            }
            return NO;
        }];
        
        
        sect.locations = [DDLocationsManager.shared.cashlessDeliveryLocations filteredArrayUsingPredicate:pred];
    }
    [self.tableView reloadData];
}
- (void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    [self goBackWithCompletion:nil];
}
-(CGFloat)dragableHeight {
    return 400;
}

+(void)setRouteConfiguration{
    NSString *moduleName = @"DDLocations";
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Locations andModuleName:moduleName withClassRef:self.class];
}
@end
