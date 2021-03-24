//
//  DDCashlessOutletSelectionVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 10/04/2020.
//

#import "DDCashlessOutletSelectionVC.h"
#import "DDCashlessOutletDistanceTVC.h"
#import "DDCashlessMerchantInfoTHFV.h"

@interface DDCashlessOutletSelectionVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *outlets;
@end

@implementation DDCashlessOutletSelectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigation.routerModel.data isKindOfClass:[NSArray class]]) {
        self.outlets = self.navigation.routerModel.data;
    }
    [self setupTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)designUI {
    self.title = @"Delivery Details";
    [self setNativeNavigationBar];
}


#pragma mark - UITableView
-(void)setupTableView {
    NSArray *cells = @[CashlessOutletDistanceTVC];
    [self.tableView registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    NSArray *header = @[CashlessMerchantInfoTHFV];
    [self.tableView registerHeaderFooterWithNibNames:header forClass:self.class withIdentifiers:header];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 60.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = 50.0;
    self.tableView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.outlets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDCashlessOutletDistanceTVC *cell = [tableView dequeueReusableCellWithIdentifier:CashlessOutletDistanceTVC forIndexPath:indexPath];
    DDOutletM *outlet = [self.outlets objectAtIndex:indexPath.row];
    [cell setData:outlet];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DDCashlessMerchantInfoTHFV *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessMerchantInfoTHFV];
    DDOutletM *outlet = [self.outlets objectAtIndex:section];
    [view setData:outlet];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDOutletM *outlet = [self.outlets objectAtIndex:indexPath.row];
    [self goBackWithCompletion:^{
        self.navigation.routerModel.callback(nil, outlet, self);
    }];
}

@end
