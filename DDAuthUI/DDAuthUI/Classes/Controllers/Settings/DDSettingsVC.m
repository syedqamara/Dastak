//
//  DDSettingsVC.m
//  DDAuthUI
//
//  Created by Syed Qamar Abbas on 23/07/2020.
//

#import "DDSettingsVC.h"
#import "DDSettingsVM.h"
#import "DDSettingsTVC.h"
#import "DDAuthUIThemeManager.h"
#import "DDAuthUIManager.h"
@interface DDSettingsVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray <DDSettingsSectionVM *> *settingSections;
@end

@implementation DDSettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = [self getSeparatorView];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadData {
    ///Change Section
    DDSettingsSectionVM *changeSect = [DDSettingsSectionVM new];
    DDSettingsVM *emailChange = [DDSettingsVM new];
    emailChange.title = @"Change Email".localized;
    emailChange.type = DDSettingsTypeChangeEmail;
    
    DDSettingsVM *passwordChange = [DDSettingsVM new];
    passwordChange.title = @"Change Password".localized;
    passwordChange.type = DDSettingsTypeChangePassword;
    changeSect.rows = @[emailChange, passwordChange];
    
    self.settingSections = @[changeSect];
    [self.tableView reloadData];
}
-(void)designUI {
    self.title = @"Settings".localized;
    [self setNavigationBarHidden:NO animated:YES];
    [self addBackArrowNavigtaionItemWithtitle:@""];
    [self.tableView registerCells:@[@"DDSettingsTVC"] forClass:self.class];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56.0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.settingSections.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settingSections[section].rows.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDSettingsTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDSettingsTVC"];
    [cell setData:self.settingSections[indexPath.section].rows[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(self.settingSections[indexPath.section].rows[indexPath.row].type == DDSettingsTypeChangeEmail) {
        [DDAuthUIManager showChangeEmailOnController:self WithcallBack:nil];
    }
    else if(self.settingSections[indexPath.section].rows[indexPath.row].type == DDSettingsTypeChangePassword) {
        [DDAuthUIManager showChangePasswordOnController:self WithcallBack:nil];
    }
    else if(self.settingSections[indexPath.section].rows[indexPath.row].type == DDSettingsTypeLanguage) {
        [DDAuthUIManager showLanguagePicker:self withcallBack:nil];
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
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Accounts_Settings andModuleName:@"DDAuthUI" withClassRef:self];
}
@end
