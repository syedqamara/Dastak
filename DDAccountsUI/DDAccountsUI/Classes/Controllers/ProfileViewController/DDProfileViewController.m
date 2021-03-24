//
//  DDProfileViewController.m
//  DDAccountsUI
//
//  Created by Syed Qamar Abbas on 27/01/2020.
//

#import "DDProfileViewController.h"
#import "UITableView+DDRegistration.h"
#import "DDUIThemeTableViewCell.h"
#import <DDAccounts/DDAccounts.h>
#import <DDCommons/DDCommons.h>
#import "DDAccountUIThemeManager.h"
#import "DDProfileSectionView.h"
#import "UIFont+DDFont.h"
#import "DDAuthUI.h"
#import <DDUI/DDUI.h>
#import "DDAccountUIManager.h"
#import "DDProfileProductTVC.h"
#import <DDAnalyticsManager.h>

@interface DDProfileViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, DDProfileProductTVCDelegate> {
    NSArray *identifiers;
    BOOL isFirstTimeLoading;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic) NSMutableArray *sections;
@property (weak, nonatomic) IBOutlet UIView *navigationContainerView;
@end

@implementation DDProfileViewController
@synthesize sections;

-(UITabBarItem *)tabBarItem {
    
    return [[UITabBarItem alloc]initWithTitle:@"Profile" image:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icInactiveProfile"] tag:4];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    sections = [[NSMutableArray alloc] initWithCapacity:3];
    NSDictionary <NSString *, NSString *> *cells = @{
        @"profile": @"DDProfileTVC",
        @"our_products": @"DDProfileProductTVC",
        @"family_friends": @"DDProfileFamilyTVC"
    };
    
    [self.tableView registerCell:cells forClass:self.class];
    [self.tableView registerHeaderFooterWithNibNames:@[@"DDProfileSectionView"] forClass:[self class] withIdentifiers:@[@"sectionView"]];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionHeaderHeight = 60;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self designUI];
        
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[NSBundle loadImageFromResourceBundlePNG:[self class] imageName:@"icSettings"] style:UIBarButtonItemStyleDone target:self action:@selector(settingsButtonTapped:)];
    
    [self addObservers];
    [self checkAndHitDeeplink];
    isFirstTimeLoading = YES;
    [self loadData:YES];
}
-(void)checkAndHitDeeplink {
    if (self.navigation.routerModel.deeplinkModel != nil && self.view_did_loaded) {
        [self hitNextDeeplink];
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self setThemeNavigationBar];
    [self largeNavigationBar];
    self.title = @"Profile".localized;
    if (!isFirstTimeLoading){
        [self loadData:NO];
    }else{
        isFirstTimeLoading = NO;
    }
    [APP_ANALYTICS trackEvent:APPBOY_EVDD_ProfileTab withType:DDEventTypeBraze andParam:@{} andEventDescription:@""];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)designUI{
    [super designUI];
    self.navigationContainerView.backgroundColor = [DDAccountUIThemeManager shared].selected_theme.app_theme.colorValue;
}

-(void)setNavigation:(DDUIRouterInfoM *)navigation {
    [super setNavigation:navigation];
    [self.tabBarController setSelectedIndex:4];
    [self.navigationController popViewControllerAnimated:NO];
    [self removeAllPresentedScreens];
    [self checkAndHitDeeplink];
}

-(void)hitNextDeeplink {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigation.routerModel sendDeeplinkCallbackWithData:@{@"key": @"value"} withController:self];
    });
}

-(void)removeAllPresentedScreens {
    if (self.presentingViewController != nil) {
        [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
        [self removeAllPresentedScreens];
    }
}

-(void)sendAnalyticsForDeeplinkAction:(NSString *)deeplink withData:(NSDictionary *)deeplinkParamData {
    if ([deeplink isEqualToString:LOCATIONS_SCHEME]) {
    }
    [super sendAnalyticsForDeeplinkAction:deeplink withData:deeplinkParamData];
}


-(void)addObservers{
    
    __weak typeof(self) weakSelf = self;

    [NSNotificationCenter.defaultCenter addObserverForName:DDUpdateSmilesList object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf getSmiles:NO];
      }];
}

-(void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self name:DDUpdateSmilesList object:nil];
}

-(IBAction)settingsButtonTapped:(id)sender{
    [DDAccountUIManager showProfileSettingsDetail:nil onController:self];
}

-(void)reloadTableView{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

-(void)updateUserGamifications{
    [DDUserManager shared].currentUser.smiles = [DDAccountManager shared].smiles.current_smiles;
}

-(void)loadData: (BOOL)showHud {
    sections = [[NSMutableArray alloc] initWithCapacity:3];
    [self loadProfileData:showHud];
    [self loadProductsData:showHud];
    [self loadLeaderboadMembersData:showHud];
    [self reloadTableView];
}

-(void)loadProfileData: (BOOL)showHud {
    DDProfileSectionM *userSection = [[DDProfileSectionM alloc] init];
    DDUserM *user = [DDUserManager shared].currentUser;
    
    userSection.section_identifier = @"profile";
    userSection.section_title = user.name;
    userSection.section_subtitle = user.email;
    userSection.image_url = user.profile_image;

    
    DDProfileSectionListM *savingSectionList = [[DDProfileSectionListM alloc] init];
    savingSectionList.title = @"Savings";
    savingSectionList.subtitle = [NSString stringWithFormat:@"%@",user.savings ?: @"0.0"];
    savingSectionList.detail = [NSString stringWithFormat:@"%@",user.currency ?: @"AED"];
    savingSectionList.bg_color_l = [DDAccountUIThemeManager shared].selected_theme.app_saving_color;
    savingSectionList.bg_color_d = [DDAccountUIThemeManager shared].selected_theme.app_saving_color;

    DDProfileSectionListM *smileSectionList = [[DDProfileSectionListM alloc] init];
    smileSectionList.title = @"Smiles";
    smileSectionList.subtitle = [NSString stringWithFormat:@"%@",[DDAccountManager shared].smiles.current_smiles ?: @"0.0"];
    smileSectionList.detail = @"";
    smileSectionList.bg_color_l = [DDAccountUIThemeManager shared].selected_theme.app_smiles_color;
    smileSectionList.bg_color_d = [DDAccountUIThemeManager shared].selected_theme.app_smiles_color;

    userSection.section_list = [[NSArray<DDProfileSectionListM,Optional>  alloc] initWithObjects:savingSectionList,smileSectionList , nil];
    
    [sections insertObject:userSection atIndex:0];
    
    [[DDAuthManager shared] userProfileWithCompletion:showHud completion:^(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    }];
    [self getSmiles:showHud];
}

-(void)getSmiles: (BOOL)showHud {
    __weak typeof(self) weakSelf = self;
    [[DDAccountManager shared] getSmiles:@{} completion:^(PSSmilesData * _Nullable model, NSString * _Nullable error) {
        if (model) {
            DDProfileSectionM *userSection = weakSelf.sections[0];
            DDProfileSectionListM *smiles =  userSection.section_list[1];
            smiles.subtitle = [NSString stringWithFormat:@"%@",model.current_smiles ?: @0.0];
            [weakSelf reloadTableView];
            [weakSelf updateUserGamifications];
        }
    }];
}

-(void)loadProductsData: (BOOL)showHud {
    DDProfileSectionM *productsSection = [[DDProfileSectionM alloc] init];
    productsSection.section_identifier = @"our_products";
    productsSection.section_title = @"Buy Products";
    productsSection.see_all_button_title_color_d = [DDAccountUIThemeManager shared].selected_theme.text_theme;
    productsSection.see_all_button_title_color_l = [DDAccountUIThemeManager shared].selected_theme.text_theme;
    productsSection.see_all_button_title = @"See All";
    
    DDProfileSectionListM *product1 = [[DDProfileSectionListM alloc] init];
    product1.is_dummy = [NSNumber numberWithBool:YES];

    DDProfileSectionListM *product2 = [[DDProfileSectionListM alloc] init];
    product2.is_dummy = [NSNumber numberWithBool:YES];

    productsSection.section_list = [[NSArray<DDProfileSectionListM,Optional>  alloc] initWithObjects:product1,product2 , nil];
    [sections insertObject:productsSection atIndex:1];
    
    __weak typeof(self) weakSelf = self;
    [[DDAccountManager shared] profileProductsWithCompletion:^(DDProfileApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (model) {
            if (model.data.products) {
                DDProfileSectionM *userSection = weakSelf.sections[1];
                userSection.section_list = model.data.products;
                [weakSelf reloadTableView];
            }
        }
    }];
}

-(void)loadLeaderboadMembersData: (BOOL)showHud {
    DDProfileSectionM *friendsSection = [[DDProfileSectionM alloc] init];
    friendsSection.section_identifier = @"family_friends";
    friendsSection.section_title = @"Family and Friends Leaderboard".localized;
    friendsSection.user_friends_ranking = [[NSArray<DDFriend> alloc] init];
    friendsSection.section_list = [[NSArray<DDProfileSectionListM> alloc] init];
    [sections insertObject:friendsSection atIndex:2];
    
    __weak typeof(self) weakSelf = self;
    [[DDAccountManager shared] profileFamilyWithCompletion:showHud completion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDFriendsAPI * friendM = (DDFriendsAPI*)model;
        if (friendM && friendM.data.user_friends_ranking.count) {
            DDProfileSectionM *friendsSection = weakSelf.sections[2];
            friendsSection.user_friends_ranking = friendM.data.user_friends_ranking;
            [weakSelf reloadTableView];
        }
    }];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    DDProfileSectionM *sectionInfo = sections[section];
    if (![sectionInfo.section_identifier isEqualToString:@"profile"]) {
        DDProfileSectionView *sectionView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionView"];
        if (sectionView) {
            [sectionView setData:sectionInfo];
        }
        return sectionView;
    }
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    DDProfileSectionM *sectionInfo = sections[section];

    if (![sectionInfo.section_identifier isEqualToString:@"profile"]) {
        return 50;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    DDProfileSectionM *sectionInfo = sections[section];
    if ([sectionInfo.section_identifier isEqualToString:@"family_friends"]) {
        return sectionInfo.user_friends_ranking.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DDProfileSectionM *sectionInfo = sections[indexPath.section];
    
    if ([sectionInfo.section_identifier isEqualToString:@"our_products"]) {
        DDProfileProductTVC *cell = [tableView dequeueReusableCellWithIdentifier:sectionInfo.section_identifier];
        cell.delegate = self;
        [cell setData:sectionInfo];
        cell.selectionStyle = UITableViewScrollPositionNone;
        return cell;
    }
    
    DDUIThemeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionInfo.section_identifier];
    if ([sectionInfo.section_identifier isEqualToString:@"family_friends"]) {
        if (indexPath.row < sectionInfo.user_friends_ranking.count){
            [cell setData:sectionInfo.user_friends_ranking[indexPath.row]];
        }else{
            return [UITableViewCell new];
        }
    }else{
        [cell setData:sectionInfo];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DDProfileSectionM *sectionInfo = sections[indexPath.section];
    if ([sectionInfo.section_identifier isEqualToString:@"family_friends"]) {
        DDFriend *friend = sectionInfo.user_friends_ranking[indexPath.row];
        if (friend.user_id != DDUserManager.shared.currentUser.user_id){
            [DDAccountUIManager showLeaderboardMemberDetail:friend onController:self];
        }
    }
}

-(void)didTapProductItem:(DDProfileSectionListM *)item {
    NSString *deepLink = item.deeplink;
    if (deepLink && deepLink.length){
        [DDWebManager.shared openURL:deepLink.noRequireRefreshGlobally title:@"" onController:self];
    }
}

+(NSArray<DDUIRouterM *> *)deeplinkRoutes {
    DDUIRouterM *profile = [[DDUIRouterM alloc]init];
    profile.route_link = DD_Nav_Accounts_Profile;
    profile.should_embed_in_nav = YES;
    profile.transition = DDUITransitionEmbedInTab;
    profile.auth_permission = DDUIRouterAuthPermissionTypeAsk;
    profile.select_tab_tabbar_controller = YES;
    return @[profile];
}
@end
