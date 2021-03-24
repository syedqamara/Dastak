//
//  DDSUIViewController.m
//  DDSearchUI
//
//  Created by etDev24 on 01/14/2020.
//  Copyright (c) 2020 etDev24. All rights reserved.
//

#import "DDSUIViewController.h"
#import <DDUI.h>

@interface DDSUIViewController ()<DDUIPaginatedTableViewDelegate> {
    NSInteger rows;
    BOOL isLoading;
}
@property (weak, nonatomic) IBOutlet DDUIPaginatedTableView *tblView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end

@implementation DDSUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    rows = 20;
    self.tblView.shouldShowPaginationCell = YES;
    self.tblView.paginationDataSource = self;
    [self.tblView reloadData];
	// Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)paginatedTV:(DDUIPaginatedTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rows;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = UIColor.blueColor;
    }else {
        cell.backgroundColor = UIColor.orangeColor;
    }
    return cell;
}
-(UITableViewCell *)cellForPaginationPaginatedTV:(DDUIPaginatedTableView *)tableView {
    DDSUIPaginationAnimationTableViewCell *cell = [DDSUIPaginationAnimationTableViewCell.alloc initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"123"];
    cell.backgroundColor = UIColor.blackColor;
    cell.textLabel.textColor = UIColor.whiteColor;
    cell.textLabel.font = [UIFont systemFontOfSize:17 weight:(UIFontWeightBold)];
    cell.textLabel.text = @"Fetching...";
    cell.textLabel.backgroundColor = UIColor.clearColor;
    return cell;
}
-(UITableViewCell *)paginatedTV:(DDUIPaginatedTableView *)tableView cellForRowAt:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell.alloc initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"123"];
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = UIColor.whiteColor;
        
    }else {
        cell.backgroundColor = UIColor.whiteColor;
    }
    cell.textLabel.textColor = UIColor.blackColor;
    cell.textLabel.font = [UIFont systemFontOfSize:17 weight:(UIFontWeightBold)];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell Number %ld",(long)indexPath.row];
    return cell;
}
-(void)paginatedTV:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    rows = 20;
    self.tblView.shouldShowPaginationCell = YES;
    [self.tblView reloadData];
}
-(void)shouldStartPagination:(DDUIPaginatedTableView *)tableView withCell:(DDSUIPaginationAnimationTableViewCell *)cell {
    [self startApiCall];
}
-(void)startApiCall {
    [self setTopBarHeight:50];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadAfterApiCall];
    });
}
-(void)setTopBarHeight:(CGFloat)height {
    if (height == 0) {
        [self.activity stopAnimating];
    }else {
        [self.activity startAnimating];
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.heightConstraint.constant = height;
        [self.view layoutIfNeeded];
    }];
}
-(void)reloadAfterApiCall {
    NSInteger dif = rows;
    rows = rows + 5;
    [self setTopBarHeight:0];
    if (rows >= 50) {
        self.tblView.shouldShowPaginationCell = NO;
        [self.tblView reloadData];
        return;
    }
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (NSInteger index = dif; index < rows; index ++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
    }
    [self.tblView reloadPaginationsAtIndexPath:indexPaths];
}
-(CGFloat)paginatedTV:(DDUIPaginatedTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
