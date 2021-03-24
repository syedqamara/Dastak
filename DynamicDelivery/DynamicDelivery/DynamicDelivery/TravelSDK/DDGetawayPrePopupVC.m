//
//  DDGetawayPrePopupVC.m
//  theDDERTAINER_Example
//
//  Created by Zubair Ahmad on 31/03/2020.
//

#import "DDGetawayPrePopupVC.h"
#import "DDGetawayPrePopupTVC.h"
#import "SDWebImage.h"
#import <DDLocations/DDLocations.h>
#import <DDAuthUI/DDAuthUI.h>

@interface DDGetawayPrePopupVC () <UITableViewDelegate, UITableViewDataSource, DDGetawayPrePopupTVCDelegate>
{
    DDGetawayPrePopuInfoM *model;
}
@end

@implementation DDGetawayPrePopupVC

-(UITabBarItem *)tabBarItem {
    return [[UITabBarItem alloc]initWithTitle:@"Travel" image:[UIImage imageNamed:@"icInactiveTravel"] tag:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DDGetawayPrePopupTVC" bundle:nil] forCellReuseIdentifier:@"DDGetawayPrePopupTVC"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.mainBackgroundImg sd_setImageWithURL:[NSURL URLWithString:model.background_image]];
    self.lblTitle.textColor = DDUIThemeManager.shared.selected_theme.text_black_40.colorValue;
}

- (void)  viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    model = [DDUserManager shared].configData.getaways_popup_info;
    self.lblTitle.text = model.screen_title;
    if (!model || !model.show_getaways_pre_popup ||  !model.show_getaways_pre_popup.boolValue) {
        // open getaway  directly
    }
    [self.navigationController setNavigationBarHidden:YES];
    [self.tableView reloadData];
    [self setStatusBarStyle:(UIStatusBarStyleDefault)];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - UITableView Delegate and Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return model.sections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DDGetawayPrePopupTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDGetawayPrePopupTVC"];
    
     DDGetawayPrePopuInfoSectionM *object = model.sections[indexPath.row];
    
    cell.model = object;
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)startBookingAction {
    [DDDatabaseManager.shared saveDefaultContext];
    [self initTravelSDKWithCallback:^(BOOL isSDKDismissed, BOOL isLogout, NSString *msg) {
        [DDDatabaseManager.shared reloadDefaultContextIntoMR];
    }];
}

- (void)hotelWorldWideAction {
    
//    NSString *categoryId = @"";
//    if ([DDUserManager sharedManager].selectedHomeCategory != nil){
//        categoryId = [DDUserManager sharedManager].selectedHomeCategory.analytics_category;
//    }
//    [[DDCustomAppAnalytics defaultAnalytics]trackisNewScreen:NO parameters:@{@"current_screen":@"VIEW OFFERS",@"action":@"click_explore_offers", @"category_id":categoryId}];
//    [self dismissViewControllerAnimated:true completion:nil];
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_App_Travel_Destinations;
    route.transition = DDUITransitionPresentWithPan2;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.panModelHeight  =  455;
    route.callback = ^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
        [self openOutletsModuleWithTravelCategoryForCountry:identifier];
    };
    [DDUIRouterManager.shared navigateTo:@[route] onController:self];
}

- (void) openOutletsModuleWithTravelCategoryForCountry:(NSString *)country {
    DDOutletsRequestM *model = [[DDOutletsRequestM alloc] init];
    [model getOutletsReqParams];
    model.billing_country = country;
    model.category = @"Travel";
    model.include_travel_outlets = @(1);
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.data = model;
    route.route_link = DD_Nav_Outlets_Listing;
    route.callback = ^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
        
    };
    [DDUIRouterManager.shared navigateTo:@[route] onController:self];
}

- (void)didBookingButtonTap{
    if ([DDUserManager shared].isLoggedIn){
        [self startBookingAction];
    }else{
        [self showLoginViewController:^(BOOL isLoggedIn) {
            if (isLoggedIn){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self startBookingAction];
                });
            }
        }];
    }
}

- (void)didOfferButtonTap{
    [self performSelector:@selector(hotelWorldWideAction) withObject:nil];
}

-(void) showLoginViewController:(void (^)(BOOL isLoggedIn))completion{
    [DDAuthUIManager showLoginScreenOnController:self WithcallBack:^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:YES completion:nil];
        if ([DDUserManager shared].isLoggedIn) {
            completion(YES);
        }else {
            completion(NO);
        }
    }];
}


#pragma mark - GETAWAY POD
-(void) setGetAwaysSDKPreferences{
    DDTravelSDKSharedPreferences.sharedInstance.boldFont = [UIFont DDBoldFont:1];
    DDTravelSDKSharedPreferences.sharedInstance.mediumFont = [UIFont DDMediumFont:1] ;
    DDTravelSDKSharedPreferences.sharedInstance.regularFont = [UIFont DDRegularFont:1];
    DDTravelSDKSharedPreferences.sharedInstance.lightFont = [UIFont DDLightFont:1];
    DDTravelSDKSharedPreferences.sharedInstance.dateSelectionColor = UIColor.DDThemeColor;
}

-(void) initTravelSDKWithCallback:(void (^)(BOOL isSDKDismissed, BOOL isLogout, NSString* msg))callBack {
    
    if (!DDUserManager.shared.isLoggedIn) return;
    [self setGetAwaysSDKPreferences];
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:@(4) forKey:@"category_id"];
    if (DDLocationsManager.shared.appLocation.location_id) {
        [params setObject:DDLocationsManager.shared.appLocation.location_id forKey:@"location_id"];
    }
    [[DDTravelSDK sharedManager] initSDKAndShowHomeView:DDUserManager.shared.currentUser.session_token baseURL:DDCAppConfigManager.shared.api_config.GETAWAY_API_URL params:params callBack:callBack];
    
}

@end
