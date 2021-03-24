//
//  DDChooseEditOptionVC.m
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 24/04/2020.
//

#import "DDChooseEditOptionVC.h"
#import "DDEditConfigM.h"
@interface DDChooseEditOptionVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readonly, nonatomic) NSArray <DDEditConfigM *> *configs;

@end

@implementation DDChooseEditOptionVC
-(NSArray <DDEditConfigM *> *)configs {
    return (NSArray <DDEditConfigM *> *)self.navigation.routerModel.data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setThemeNavigationBar];
    self.navigationController.navigationBar.barTintColor = DDUIThemeManager.shared.selected_theme.app_theme.colorValue;
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = UIColor.whiteColor;
    [self addBackArrowNavigtaionItemWithtitle:@"Back".localized];
    [self.tableView reloadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)designUI {
    self.view.backgroundColor = DDUIThemeManager.shared.selected_theme.app_theme.colorValue;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.configs.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDEditConfigM *config = self.configs[indexPath.row];
    UITableViewCell *cell = [UITableViewCell.alloc initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@""];
    cell.backgroundColor = UIColor.clearColor;
    cell.textLabel.text = config.title;
    cell.textLabel.textColor = UIColor.whiteColor;
    cell.textLabel.font = [UIFont DDBoldFont:16];
    cell.detailTextLabel.text = config.key;
    cell.detailTextLabel.textColor = UIColor.whiteColor;
    cell.detailTextLabel.font = [UIFont DDRegularFont:14];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    DDEditConfigM *config = self.configs[indexPath.row];
    [self.navigation.routerModel sendDataCallback:nil withData:config withController:self];
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
