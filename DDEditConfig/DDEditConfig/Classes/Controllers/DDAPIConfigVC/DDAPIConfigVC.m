//
//  DDApiBreakPointVC.m
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 24/04/2020.
//

#import "DDAPIConfigVC.h"
#import "DDAPIConfigTVC.h"
#import "DDEditConfigManager.h"
#import "DDNetwork.h"
#import "DDUI.h"
@interface DDAPIConfigVC ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *all_configs;
@property (strong, nonatomic) NSArray *filters_configs;
@end

@implementation DDAPIConfigVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    [self setThemeNavigationBar];
    self.view.backgroundColor = DDUIThemeManager.shared.selected_theme.bg_black.colorValue;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"Api Configurations".localized;
    self.all_configs = DDNetworkManager.shared.copyApiConfig.allValues;
    self.filters_configs = self.all_configs;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = UIColor.whiteColor;
    self.tableView.allowsSelection = NO;
    self.navigationController.navigationBar.barTintColor = DDUIThemeManager.shared.selected_theme.app_theme.colorValue;
    [self.tableView registerCellWithNibNames:@[@"DDAPIConfigTVC"] forClass:self.class withIdentifiers:@[@"DDAPIConfigTVC"]];
    [self addNavigationItemWithTitle:@"Done" identifier:@"done" tintColor:UIColor.whiteColor direction:(DDNavigationItemDirectionRight)];
    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filters_configs.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DDApisConfiguration *config = self.filters_configs[indexPath.row];
    DDAPIConfigTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDAPIConfigTVC"];
    [cell setData:config];
    return cell;
}
-(void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    if (sender.direction == DDNavigationItemDirectionRight) {
        NSMutableDictionary <NSString *, DDApisConfiguration *> *configs = [NSMutableDictionary new];
        for (DDApisConfiguration *config in self.all_configs) {
            [configs setObject:config forKey:config.identifier];
        }
        DDNetworkManager.shared.api_dictionary = configs;
        [DDNetworkManager.shared saveCache];
        [self goBackWithCompletion:nil];
    }
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.filters_configs = self.all_configs;
    }else {
        NSPredicate *pred = [NSPredicate predicateWithBlock:^BOOL(DDApisConfiguration * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            if ([evaluatedObject.identifier.lowercaseString containsString:searchText.lowercaseString]) {
                return YES;
            }
            if ([evaluatedObject.end_point.lowercaseString containsString:searchText.lowercaseString]) {
                return YES;
            }
            return NO;
        }];
        self.filters_configs = [self.all_configs filteredArrayUsingPredicate:pred];
    }
    [self.tableView reloadData];
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
