//
//  DDRemoveCustomizationVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 28/08/2020.
//

#import "DDRemoveCustomizationVC.h"
#import "DDRemoveCustomzationTVC.h"
#import "DDModels.h"
#import "DDHomeThemeManager.h"

@interface DDRemoveCustomizationVC ()<UITableViewDelegate, UITableViewDataSource>
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic, readonly) NSArray <DDMerchantDeliveryMenuItemM *> *items;
@end

@implementation DDRemoveCustomizationVC
-(NSArray <DDMerchantDeliveryMenuItemM *> *)items {
    return self.navigation.routerModel.data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Remove Item".localized;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self addCrossImageWithColor:HOME_THEME.app_theme.colorValue withDirection:(DDNavigationItemDirectionLeft)];
    [self addNavigationItemWithTitle:@"Delete All" identifier:@"delete" tintColor:@"fd4f57".colorValue direction:(DDNavigationItemDirectionRight)];
    [self.tableView registerCells:@[@"DDRemoveCustomzationTVC"] forClass:self.class];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDRemoveCustomzationTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDRemoveCustomzationTVC"];
    [cell setData:self.items[indexPath.row]];
    cell.deleteButton.tag = indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(didTapDeleteButton:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}
-(void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    if (sender.direction == DDNavigationItemDirectionRight) {
        [self goBackWithCompletion:^{
            [self.navigation.routerModel sendDataCallback:@"all" withData:self.items.firstObject withController:self];
        }];
    }else {
        [super didTapOnNavigationItem:sender];
    }
}
-(void)didTapDeleteButton:(UIButton *)button {
    [self.navigation.routerModel sendDataCallback:@"" withData:self.items[button.tag] withController:self];
    NSMutableArray *arr = self.items.mutableCopy;
    [arr removeObjectAtIndex:button.tag];
    self.navigation.routerModel.data = arr;
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:button.tag inSection:0]] withRowAnimation:(UITableViewRowAnimationLeft)];
    [self.tableView endUpdates];
    [self.tableView reloadData];
}
-(CGFloat)dragableHeight {
    if (self.items.count * 106 < (UIScreen.mainScreen.bounds.size.height - 100)) {
        return self.items.count * 106;
    }
    return UIScreen.mainScreen.bounds.size.height - 100;
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
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Remove_Items andModuleName:@"" withClassRef:self];
}
@end
