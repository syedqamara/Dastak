
//
//  DDCashlessOrderItemTVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 15/04/2020.
//

#import "DDCashlessOrderItemTVC.h"
#import "DDCashlessOrderMenuItemTVC.h"
#import "DDOrderDetailSectionM.h"
#import "DDCashlessUIConstants.h"
#import "DDCashlessThemeManager.h"
#import "DDCashlessOrderNumberTHFV.h"
#import "DDCashlessOrderTotalTVC.h"

@interface DDCashlessOrderItemTVC() <UITableViewDataSource, UITableViewDelegate>{
    DDOrderDetailSectionM *orderDetail;
}
@end
@implementation DDCashlessOrderItemTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedSectionHeaderHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setScrollEnabled:NO];
    NSArray *cells = @[CashlessOrderMenuItemTVC, CashlessOrderTotalTVC];
    NSArray *headers = @[CashlessOrderNumberTHFV];
    [self.tableView registerHeaderFooterWithNibNames:headers forClass:self.class withIdentifiers:headers];
    [self.tableView registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    // Initialization code
}
-(void)setData:(id)data {
    orderDetail = data;
    [self updateSuperViewHeight];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf updateSuperViewHeight];
    });
}
-(void)updateSuperViewHeight {
    if(!orderDetail.isExpanded) {
        UITableView *tbl = (UITableView *)self.superview;
        [tbl beginUpdates];
        self.tableViewHeightConstraint.constant = 2;
        [self setNeedsLayout];
        [self layoutIfNeeded];
        [tbl endUpdates];
        return;
    }
    [UIView performWithoutAnimation:^{
        UITableView *tbl = (UITableView *)self.superview;
        [tbl beginUpdates];
        self.tableViewHeightConstraint.constant = CGFLOAT_MAX;
        [self.tableView reloadData];
        [self.tableView layoutIfNeeded];
        [self layoutIfNeeded];
        self.tableViewHeightConstraint.constant = self.tableView.contentSize.height;
        [self layoutIfNeeded];
        [tbl endUpdates];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DDCashlessOrderNumberTHFV *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessOrderNumberTHFV];
    [header setData:orderDetail.order];
    return header;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return orderDetail.order.order_items.count + 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < orderDetail.order.order_items.count) {
        DDCashlessOrderMenuItemTVC *cell = [tableView dequeueReusableCellWithIdentifier:CashlessOrderMenuItemTVC];
        DDOrderItems* item = orderDetail.order.order_items[indexPath.item];
        [cell setData:item];
        return cell;
    }
    DDCashlessOrderTotalTVC *cell = [tableView dequeueReusableCellWithIdentifier:CashlessOrderTotalTVC];
    [cell setData:orderDetail.order];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
