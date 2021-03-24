//
//  DDSettingsViewController.m
//  DDAccountsUI
//
//  Created by M.Jabbar on 12/02/2020.
//

#import "DDSettingsViewController.h"
#import <DDModels/DDModels.h>
#import <DDAccounts/DDAccounts.h>
#import "DDSettingsTableViewCell.h"
#import "DDSettingsSwitchTableViewCell.h"
#import <DDAuthUI/DDAuthUI.h>
#import "DDAccountUIThemeManager.h"
#import "DDAccountUIManager.h"
#import <DDLocationsUI/DDLocationsUI.h>
#import <DDCommons/DDCommons.h>
#import <DDAuth/DDAuth.h>
#import <DDProductsUI/DDProductsUI.h>

@interface DDSettingsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic) IBOutlet UITableView* tableView;
@property(nonatomic)NSMutableArray <DDSettingsSectionM> *settings;
@end

@implementation DDSettingsViewController
@synthesize settings;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setThemeNavigationBar];
    self.title = @"Settings".localized;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor] ,NSFontAttributeName : [UIFont DDBoldFont:20]};
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    DDSettingsSectionListM *itemsList = (DDSettingsSectionListM*)self.navigation.routerModel.data;
    if (itemsList && itemsList.list.count){
        self.settings = itemsList.list.mutableCopy;
    }else {
        NSMutableArray <DDSettingsSectionM> *tempsettings = [DDAccountManager shared].profileSettings.mutableCopy;
        if (tempsettings.count > 0 && [[DDLocationsManager shared] isLocationServicesEnable]){
            tempsettings = [self filterSettingsDataForLocationSelectionField:tempsettings];
        }
        self.settings = tempsettings;
    }
    [self setupTableView];
    if (self.settings == nil || self.settings.count <=0) {
        [self loadSettingsData];
    }
    [self hitNextDeeplink];
    [self standardNavigationBar];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.settings && self.settings.count > 0 && [[DDLocationsManager shared] isLocationServicesEnable]){
        self.settings = [self filterSettingsDataForLocationSelectionField:self.settings];
    }
    [self.tableView reloadData];
}

-(void)hitNextDeeplink {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigation.routerModel sendDeeplinkCallbackWithData:@{@"key": @"value"} withController:self];
    });
}

- (void)sendAnalyticsForDeeplinkAction:(NSString *)deeplink withData:(NSDictionary *)deeplinkParamData {
    
}

-(void)setupTableView{
    NSDictionary *cells = @{
        @"DDSettingsTableViewCell": @"DDSettingsTableViewCell",
        @"DDSettingsSwitchTableViewCell": @"DDSettingsSwitchTableViewCell"
    };
    [self.tableView registerCell:cells forClass:self.class];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

- (void)checkForDeeplinkAnalytics {
    
}

-(void)loadSettingsData {
    __weak typeof(self) weakSelf = self;
    [[DDAccountManager shared] settingsWithParams:@{} completion:^(DDSettingsApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        weakSelf.settings = [[NSMutableArray<DDSettingsSectionM> alloc] init];
        if (model) {
            if (model.data.profile) {
                [weakSelf setSettingsDataInAccountManager:model.data.profile.mutableCopy];
                NSMutableArray <DDSettingsSectionM> *tempsettings = model.data.profile.mutableCopy;
                if (tempsettings.count > 0 && [[DDLocationsManager shared] isLocationServicesEnable]){
                    tempsettings = [weakSelf filterSettingsDataForLocationSelectionField:tempsettings];
                }
                weakSelf.settings = tempsettings;
            }
        }
        [weakSelf.tableView reloadData];
    }];
}

- (NSMutableArray <DDSettingsSectionM> *) filterSettingsDataForLocationSelectionField :(NSMutableArray<DDSettingsSectionM>*)settings {
    NSMutableArray <DDSettingsSectionM> *filteredSettings = [settings mutableCopy];
    NSMutableArray <DDSettingsSectionM> *newSettings  = [[NSMutableArray<DDSettingsSectionM> alloc] init];
    for (DDSettingsSectionM *section in filteredSettings){
        DDSettingsSectionM *newSection = [section.toDictionary decodeTo:DDSettingsSectionM.class];
        [newSettings addObject:newSection];
        if ([section.section_identifier isEqualToString:@"general_settings"]){
            NSMutableArray *section_list = section.section_list.mutableCopy;
            for (DDSettingsSectionListM *item in section_list){
                if ([item itemType] == DDSettingsSectionListTypeLocation){
                    [section_list removeObject:item];
                    newSection.section_list = section_list.mutableCopy;
                    break;
                }
            }
        }
    }
    return newSettings;
}

- (void) setSettingsDataInAccountManager:(NSMutableArray<DDSettingsSectionM>*)settings {
    [DDAccountManager shared].profileSettings = settings;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.settings.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DDSettingsSectionM *sectionM = self.settings[section];
    return sectionM.section_list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DDSettingsSectionM *sectionM = self.settings[indexPath.section];
    DDSettingsSectionListM *item = sectionM.section_list[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    
    if ([item itemType] == DDSettingsSectionListTypePushNotifications) {
        DDSettingsSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"DDSettingsSwitchTableViewCell" forIndexPath:indexPath];
        [cell setData:item];
        cell.callBackAfterSwitchStateChange = ^(DDSettingsSectionListM* item, BOOL switchState){
            [weakSelf actionForIndexPath:item switchState:switchState];
        };
        return cell;
    }else{
        DDSettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"DDSettingsTableViewCell" forIndexPath:indexPath];
        [cell setData:item];
        return cell;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [DDAccountUIThemeManager shared].selected_theme.bg_grey_240.colorValue;
    return headerView;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDSettingsSectionM *sectionM = self.settings[indexPath.section];
    DDSettingsSectionListM *item = sectionM.section_list[indexPath.row];
    [self selectItemForIndexPath:item];
}
#pragma mark - Helpers

-(void)actionForIndexPath:(DDSettingsSectionListM *)item  switchState:(BOOL)switchState{
    if (!UIApplication.isInternetConnected){
        [DDAlertUtils showOkAlertWithTitle:@"" subtitle:@"Your Internet connection appears to be offline. Please try again later.".localized completion:nil];
        [self.tableView reloadData];
        return;
    }
    NSNumber *user_default_set_apns_value = [DDUserManager shared].currentUser.push_notifications;
    if (switchState == YES){
        [DDUserManager shared].currentUser.push_notifications = @(1);
    } else {
        [DDUserManager shared].currentUser.push_notifications = @(0);
    }
    __weak typeof(self) weakSelf = self;
    DDUserProfileRequestM *req = [DDUserProfileRequestM new];
    DDUserM *user = DDUserManager.shared.currentUser;
    NSString *dob = user.date_of_birth;
    if (dob != nil && [dob containsString:@"-"]){
        user.date_of_birth = [dob getDayMonthYearDateStringWithSlashes];
    }
    req.user = user;
    [DDAuthManager.shared updateProfileInfo:req andCompletion:^(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            [DDAlertUtils showOkAlertWithTitle:@"" subtitle:error.localizedDescription completion:nil];
            [DDUserManager shared].currentUser.push_notifications = user_default_set_apns_value;
            [[DDUserManager shared] updateUserPushSettingsOnAppBoy:[DDUserManager shared].currentUser.push_notifications.boolValue];
        }else {
            if (model && !model.successfulApi)  {
                [DDAlertUtils showOkAlertWithTitle:@"" subtitle:model.message completion:nil];
            }
        }
        [weakSelf.tableView reloadData];
    }];
}
-(void)selectItemForIndexPath:(DDSettingsSectionListM *)item{
    if (item.list.count > 0) {
        [DDAccountUIManager showSubItems:item onController:self];
    }else{
        [self openScreenByIdentifierOfItem:item];
    }
}
-(void)openScreenByIdentifierOfItem:(DDSettingsSectionListM *)item {
    if(item.web_url.length > 0) {
        NSString *urlString = item.web_url;
        if ([urlString hasPrefix:@"http://"]){
            urlString = [urlString stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
        }
        switch (item.itemType) {
            case DDSettingsSectionListTypeEmailPreferences:{
                urlString = [NSString stringWithFormat:@"%@?language=%@&app_version=%@&__t=%@",urlString,NSString.deviceLanguage,DDCCommonParamManager.shared.default_web_parameters.app_version,DDCCommonParamManager.shared.default_web_parameters.__t];
            }
                break;
            case DDSettingsSectionListTypeWallet: {
                urlString = [NSString stringWithFormat:@"%@?language=%@&app_version=%@&__t=%@",urlString,NSString.deviceLanguage,DDCCommonParamManager.shared.default_web_parameters.app_version,DDCCommonParamManager.shared.default_web_parameters.__t];
            }
                break;
            default:
            {
                if ([urlString containsString:@"http"]){
                    urlString = [NSString stringWithFormat:@"%@?language=%@",urlString,NSString.deviceLanguage];
                }
            }
                break;
        }
        [DDWebManager.shared openURL:urlString title:item.title onController:self];
    }else {
        switch (item.itemType) {
            case DDSettingsSectionListTypeSignOut:
                if (UIApplication.isInternetConnected) {
                    DDAccountManager.shared.smiles = nil;
                    [[DDAuthManager shared] logout];
                }
                break;
            case DDSettingsSectionListTypeMyFamily:
                [DDAccountUIManager showMyFamilyList:item onController:self];
                break;
            case DDSettingsSectionListTypeMyFriends:
                [DDAccountUIManager showMyFriendsList:item onController:self];
                break;
            case DDSettingsSectionListTypeRedemptions:
                [DDAccountUIManager showMyRedemptionsList:item onController:self];
                break;
            case DDSettingsSectionListTypeReservations:
                [DDAccountUIManager showMyReservationsList:item onController:self];
                break;
            case DDSettingsSectionListTypeOrders:
                [DDAccountUIManager showMyOrdersList:item onController:self];
                break;
            case DDSettingsSectionListTypePings:
                [DDAccountUIManager showMyPingsList:item onController:self];
                break;
            case DDSettingsSectionListTypeLocation:
            {
                [DDLocationsUIManager.shared showAppLocationsVCFrom:self withData:nil andControllerCallBack:^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
                    [self.tableView reloadData];
                }];
                break;
            }
            case DDSettingsSectionListTypeMyAccount:
                [DDAccountUIManager showMyAccount:item onController:self];
                break;
            case DDSettingsSectionListTypeProducts:
                [DDProductsUIManager showProductsPurchsaeHistoryOnVC:self data:nil onCompletion:nil];
                break;
            default:
                break;
        }
    }
}
+(NSArray<DDUIRouterM *> *)deeplinkRoutes {
    DDUIRouterM *settings = [[DDUIRouterM alloc]init];
    settings.route_link = DD_Nav_Accounts_Settings;
    settings.should_embed_in_nav = YES;
    settings.transition = DDUITransitionPush;
    settings.is_animated = YES;
    settings.auth_permission = DDUIRouterAuthPermissionTypeAsk;
    return @[settings];
}
@end
