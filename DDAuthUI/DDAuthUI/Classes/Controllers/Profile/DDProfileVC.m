//
//  DDProfileVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 23/07/2020.
//

#import "DDProfileVC.h"
#import "DDSettingsVM.h"
#import "DDSettingsTVC.h"
#import "DDAuthUIThemeManager.h"
#import "DDAuthUIManager.h"
#import "DDUserManager.h"
@interface DDProfileVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray <DDSettingsSectionVM *> *profileSections;
@end

@implementation DDProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = [self getSeparatorView];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
-(UITabBarItem *)tabBarItem {
    UITabBarItem *item = [[UITabBarItem alloc] init];
    item.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"ic-profile"];
//    item.selectedImage = [[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"ic-profile"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    item.title = [@"Profile" localized];
    item.tag = 0;
    return item;
}

-(void)loadData {
    ///Change Section
    DDSettingsSectionVM *s1 = [DDSettingsSectionVM new];
    DDSettingsVM *s1r1 = [DDSettingsVM new];
    s1r1.title = @"Personal Details".localized;
    s1r1.image = @"file-text.png";
    s1r1.type = DDSettingsTypePersonal;
    
//    DDSettingsVM *s1r2 = [DDSettingsVM new];
//    s1r2.title = @"Payment method";
//    s1r2.image = @"dollar-sign (1).png";
//    s1r2.type = DDSettingsTypePayment;
    
    DDSettingsVM *s1r3 = [DDSettingsVM new];
    s1r3.title = @"Delivery addresses".localized;
    s1r3.image = @"map-pin.png";
    s1r3.type = DDSettingsTypeAddress;
    
//    DDSettingsVM *s1r4 = [DDSettingsVM new];
//    s1r4.title = @"Notifications";
//    s1r4.image = @"bell.png";
//    s1r4.type = DDSettingsTypeNotification;
    
    s1.rows = @[s1r1,s1r3];
    
    DDSettingsSectionVM *s2 = [DDSettingsSectionVM new];
    DDSettingsVM *s2r1 = [DDSettingsVM new];
    s2r1.title = @"Help".localized;
    s2r1.image = @"help-circle.png";
    s2r1.type = DDSettingsTypeHelp;
    s2r1.link = DDCAppConfigManager.shared.app_config.HELP_PAGE;
    
    DDSettingsVM *s2r2 = [DDSettingsVM new];
    s2r2.title = @"Settings".localized;
    s2r2.image = @"settings.png";
    s2r2.type = DDSettingsTypeSettings;
    
    DDSettingsVM *s2r3 = [DDSettingsVM new];
    s2r3.title = @"Contact us".localized;
    s2r3.image = @"message-square.png";
    s2r3.type = DDSettingsTypeContactUs;
    s2r3.link = DDCAppConfigManager.shared.app_config.HELP_PAGE;
    
    s2.rows = @[s2r1,s2r2,s2r3];
    
    DDSettingsSectionVM *s3 = [DDSettingsSectionVM new];
    DDSettingsVM *s3r1 = [DDSettingsVM new];
    s3r1.title = @"Log out".localized;
    s3r1.image = @"log-out.png";
    s3r1.type = DDSettingsTypeLogout;
    
    s3.rows = @[s3r1];
    
    
    
    
    self.profileSections = @[s1, s2, s3];
    [self.tableView reloadData];
}
-(void)designUI {
    self.title = @"Profile".localized;
    [self setNavigationBarHidden:NO animated:YES];
    [self.tableView registerCells:@[@"DDSettingsTVC"] forClass:self.class];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56.0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.profileSections.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.profileSections[section].rows.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDSettingsTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDSettingsTVC"];
    [cell setData:self.profileSections[indexPath.section].rows[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.profileSections[indexPath.section].rows[indexPath.row].type == DDSettingsTypeSettings) {
        [DDAuthUIManager showSettingsOnController:self WithcallBack:nil];
    }
    if(self.profileSections[indexPath.section].rows[indexPath.row].type == DDSettingsTypeHelp || self.profileSections[indexPath.section].rows[indexPath.row].type == DDSettingsTypeContactUs || self.profileSections[indexPath.section].rows[indexPath.row].type == DDSettingsTypePayment) {
        [DDWebManager.shared openURL:self.profileSections[indexPath.section].rows[indexPath.row].url title:self.profileSections[indexPath.section].section_title onController:self];
    }
    if(self.profileSections[indexPath.section].rows[indexPath.row].type == DDSettingsTypeSettings) {
        [DDAuthUIManager showSettingsOnController:self WithcallBack:nil];
    }
    
    if(self.profileSections[indexPath.section].rows[indexPath.row].type == DDSettingsTypeAddress) {
        [DDAuthUIManager showDeliveryLocationsVCFrom:self withData:nil andControllerCallBack:nil];
    }
    
    if(self.profileSections[indexPath.section].rows[indexPath.row].type == DDSettingsTypePersonal) {
        [DDAuthUIManager showPersonalDetailVCFrom:self withData:nil andControllerCallBack:nil];
    }
    
    if(self.profileSections[indexPath.section].rows[indexPath.row].type == DDSettingsTypeLogout) {
        [DDAlertUtils showAlertWithTitle:@"" subtitle:@"Are you sure you want to logout?".localized buttonNames:@[@"Yes".localized, @"No".localized] onClick:^(int index) {
            if (index == 0) {
                [DDAuthManager.shared logout];
            }
        }];
    }
    
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return [self getSeparatorView];
//}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self getSeparatorView];
}
-(UIView *)getSeparatorView {
    UIView *view = [UIView.alloc initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 8)];
    view.backgroundColor = AUTH_THEME.text_grey_238.colorValue;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0111;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
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
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Accounts_Profile andModuleName:@"DDAuthUI" withClassRef:self];
}
@end
