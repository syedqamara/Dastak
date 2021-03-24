//
//  DDEditConfigVC.m
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 06/04/2020.
//

#import "DDEditConfigVC.h"
#import "DDEditConfigTVC.h"
#import "DDEditConfigM.h"
@interface DDEditConfigVC ()<UITableViewDataSource, UITableViewDelegate> {
    NSArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DDEditConfigVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setThemeNavigationBar];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationItem setTitle:@"Change Configuration"];
    dataArray = self.navigation.routerModel.data;
    [self.tableView registerCellWithNibNames:@[@"DDEditConfigTVC"] forClass:self.class withIdentifiers:@[@"DDEditConfigTVC"]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addNavigationItemWithTitle:@"Done" identifier:@"done" tintColor:DDUIThemeManager.shared.selected_theme.text_white.colorValue direction:(DDNavigationItemDirectionRight)];
    
    [self.tableView setAllowsSelection:NO];
    
    CGRect rect = UIScreen.mainScreen.bounds;
    rect.size.height = 30;
    UIButton *button = [UIButton.alloc initWithFrame:rect];
    [button setTitle:@"RESET" forState:(UIControlStateNormal)];
    [button setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont DDBoldFont:17];
    [button addTarget:self action:@selector(didTapResetButton) forControlEvents:(UIControlEventTouchUpInside)];
    self.tableView.tableFooterView = button;
    
    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDEditConfigM *config = dataArray[indexPath.row];
    DDEditConfigTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDEditConfigTVC"];
    [cell setData:config];
    return cell;
}
-(void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (sender.direction == DDNavigationItemDirectionRight) {
        NSDictionary *dict = [self updatedDict];
        if (dict != nil) {
            [self.navigation.routerModel sendDataCallback:@"save" withData:dict withController:nil];
        }else {
            [self showAlert];
        }
        
    }
}
-(void)showAlert {
    [DDAlertUtils showOkAlertWithTitle:@"Cannot Save Empty" subtitle:[NSString stringWithFormat:@"Please insert value for %@", [self emptyDataTitle]] completion:^{
        
    }];
}
-(NSDictionary *)updatedDict {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (DDEditConfigM *config in dataArray) {
        if (config.data.length > 0) {
            [dict setObject:config.data forKey:config.key];
        }
        else {
            return nil;
        }
    }
    return dict;
}
-(NSString *)emptyDataTitle {
    for (DDEditConfigM *config in dataArray) {
        if (config.data.length == 0) {
            return config.title;
        }
    }
    return nil;
}
-(void)didTapResetButton {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSDictionary *dict = @{};
    [self.navigation.routerModel sendDataCallback:@"reset" withData:dict withController:nil];
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
