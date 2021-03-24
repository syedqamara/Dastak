//
//  DDMerchantInfoVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 04/09/2020.
//

#import "DDMerchantInfoVC.h"
#import "DDMerchantInfoTVC.h"
#import "DDHomeUIManager.h"
#import "DDMerchantInfoTHFV.h"
#import "DDMerchantInfoTVC.h"
@interface DDMerchantInfoVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DDMerchantInfoVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerCells:@[@"DDMerchantInfoTVC"] forClass:self.class];
    [self.tableView registerTHFV:@[@"DDMerchantInfoTHFV"] forClass:self.class];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedSectionHeaderHeight = 65;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.sectionFooterHeight = 1.0;
    self.tableView.estimatedSectionFooterHeight = 1.0;
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.tableView reloadData];
    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.merchant.info.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DDMerchantInfoSectionM *sect = self.merchant.info[section];
    return sect.list.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DDMerchantInfoTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DDMerchantInfoTHFV"];
    [view setData:self.merchant.info[section]];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView.alloc initWithFrame:CGRectMake(53, 0, UIScreen.mainScreen.bounds.size.width - (53-16), 1)];
    view.backgroundColor = [@"333333".colorValue colorWithAlphaComponent:0.2];
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDMerchantInfoTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDMerchantInfoTVC"];
    DDMerchantInfoSectionM *sect = self.merchant.info[indexPath.section];
    [cell setData:sect.list[indexPath.row]];
    return cell;
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
