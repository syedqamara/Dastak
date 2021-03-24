//
//  DDCashlessSearchLocationsVC.m
//  DDLocationsUI
//
//  Created by Awais Shahid on 17/02/2020.
//

#import "DDCashlessSearchLocationsVC.h"
#import "DDCashlessDeliveryLocationsTVC.h"
#import "DDCashlessDeliveryLocationsTHFV.h"
#import "DDCoreLocation.h"
@interface DDCashlessSearchLocationsVC () <UITableViewDelegate, UITableViewDataSource, DDCashlessDeliveryLocationsTHFVDelegate>
@property (weak, nonatomic) IBOutlet UIView *tfContainer;
@property (weak, nonatomic) IBOutlet UIImageView *searchIcon;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSMutableArray<GMSAutocompletePrediction *> *predictions;
@end

@implementation DDCashlessSearchLocationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupTextField];
}

-(void)setupTextField {
    [self.searchTF addTarget:self  action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - TableView

-(void)setupTableView {
    NSArray *cells = @[CashlessDeliveryLocationsTVC];
    [self.tableView registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    NSArray *footers = @[CashlessDeliveryLocationsTHFV];
    [self.tableView registerHeaderFooterWithNibNames:footers forClass:self.class withIdentifiers:footers];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 58;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionFooterHeight = 58;
    self.tableView.estimatedSectionFooterHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (DDLocationsManager.shared.isLocationServicesEnable) {
        return self.predictions.count + 1;
    }
    return self.predictions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDCashlessDeliveryLocationsTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:CashlessDeliveryLocationsTVC forIndexPath:indexPath];
    if (indexPath.row < self.predictions.count) {
        GMSAutocompletePrediction *prediction = [self.predictions objectAtIndex:indexPath.row];
        [cell setPrediction:prediction];
    }else {
        [cell setAddress:[self currentLocationAddress]];
    }
    return cell;
}
-(DDDeliveryAddressM *)currentLocationAddress {
    DDDeliveryAddressM *add = [DDDeliveryAddressM new];
    add.latitude = @(DDCoreLocation.shared.currentLocation.coordinate.latitude).stringValue;
    add.longitude = @(DDCoreLocation.shared.currentLocation.coordinate.longitude).stringValue;
    add.is_current_location = @(YES);
    return add;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.predictions.count) {
        GMSAutocompletePrediction *prediction = [self.predictions objectAtIndex:indexPath.row];
        __weak typeof (self) weakSelf = self;
        [DDGoogleApiManager.shared lookUpPlaceById:prediction.placeID completionCallBack:^(GMSPlace * _Nullable place) {
            [weakSelf sendCallback:place];
        }];
    }
    else {
        [self sendCallback:[self currentLocationAddress]];
    }
}
-(void)sendCallback:(id)place {
    [self goBackWithCompletion:^{
        [self.navigation.routerModel sendDataCallback:@"GoogleAutoCompletePlace" withData:place withController:nil];
    }];
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    DDCashlessDeliveryLocationsTHFV *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessDeliveryLocationsTHFV];
//    DDCashlessDeliveryLocationsSectionVM *data = [DDCashlessDeliveryLocationsSectionVM new];
//    data.is_manual_section = @(1);
//    [view setData:data];
//    [view setDelegate:self];
//    return view;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return UITableViewAutomaticDimension;
//}

#pragma mark - Overridden methods
- (void)designUI {
    self.title = K_CASHLESS_SEARCH_LOCATION.localized;
    [self addBackArrowNavigtaionItemWithtitle:BACK];
    
    self.tfContainer.cornerR = 12;
    self.tfContainer.borderW = 0.5;
    self.tfContainer.borderColor = DDLocationsThemeManager.shared.selected_theme.app_theme.colorValue;
    self.tfContainer.clipsToBounds = YES;
    
    self.searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTF.textColor = DDLocationsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.searchTF.placeholder = SEARCH.localized;
    self.searchTF.font = [UIFont DDLightFont:17];
    self.searchIcon.tintColor = THEME.app_theme.colorValue;
    [self.searchIcon loadTemplateImageWithString:@"ic-saerch.png" forClass:self.class];
    
    [self.cancelBtn setTitle:CANCEL.localized forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:DDLocationsThemeManager.shared.selected_theme.text_grey_111.colorValue forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = [UIFont DDMediumFont:17];
}


#pragma mark - Other

-(void)textFieldDidChange:(UITextField*)textField {
    NSString *text = textField.text.trimmedString;
    __weak typeof (self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (text.length && [text isEqualToString:textField.text.trimmedString]) {
            [weakSelf performSearchPlaces];
        }
    });
}


- (IBAction)cancelTapped:(UIButton *)sender {
    [self goBackWithCompletion:nil];
}

#pragma mark - Section Footer Callback

- (void)manualLocationTapped {
    [self goBackWithCompletion:nil];
}

#pragma mark - GooglePlaces

-(void)performSearchPlaces {
    GMSCoordinateBounds *bound = (GMSCoordinateBounds*)self.navigation.routerModel.data;
    __weak typeof (self) weakSelf = self;
    [DDGoogleApiManager.shared searchLocationsFromText:self.searchTF.text inBounds:bound withCompletion:^(NSArray * _Nonnull array) {
        weakSelf.predictions = array.mutableCopy;
        [weakSelf.tableView reloadData];
    }];
}
+(void)setRouteConfiguration {
    NSString *moduleName = @"DDLocations";
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Search_Location andModuleName:moduleName withClassRef:self.class];
}
@end











