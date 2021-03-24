//
//  DDApiBreakPointVC.m
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 24/04/2020.
//

#import "DDApiBreakPointVC.h"
#import "DDBreakPointTVC.h"
#import "DDEdiConfigBreakPointM.h"
#import "DDEditConfigManager.h"
#import "DDUI.h"
@interface DDApiBreakPointVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) DDEditConfigBreakPointM *breakPoint;
@end

@implementation DDApiBreakPointVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setThemeNavigationBar];
    self.view.backgroundColor = DDUIThemeManager.shared.selected_theme.app_theme.colorValue;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"Api Breakpoints".localized;
    self.breakPoint = DDEditConfigBreakPointM.apiBreakPoints;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = UIColor.whiteColor;
    self.tableView.allowsSelection = NO;
    self.navigationController.navigationBar.barTintColor = DDUIThemeManager.shared.selected_theme.app_theme.colorValue;
    [self.tableView registerCellWithNibNames:@[@"DDBreakPointTVC"] forClass:self.class withIdentifiers:@[@"DDBreakPointTVC"]];
    [self addNavigationItemWithTitle:@"Done" identifier:@"done" tintColor:UIColor.whiteColor direction:(DDNavigationItemDirectionRight)];
    [self.textField addTarget:self action:@selector(didChangeText) forControlEvents:(UIControlEventEditingChanged)];
    self.textField.placeholder = @"Search API by name or endpoint";
    // Do any additional setup after loading the view from its nib.
}
-(void)didChangeText {
    NSString *text = self.textField.text;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.textField.text isEqualToString:text]) {
            [self.tableView reloadData];
        }
    });
}
-(NSMutableArray *)array {
    return [self.breakPoint arrayWithText:self.textField.text];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self array].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DDBreakPointM *breakPoint = [self array][indexPath.row];
    DDBreakPointTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDBreakPointTVC"];
    [cell setData:breakPoint];
    return cell;
}
-(void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    if (sender.direction == DDNavigationItemDirectionRight) {
        DDEditConfigBreakPointM.apiBreakPoints = self.breakPoint;
        [self goBackWithCompletion:^{}];
    }
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
