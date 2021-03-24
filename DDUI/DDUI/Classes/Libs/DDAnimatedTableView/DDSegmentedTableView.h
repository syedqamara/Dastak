//
//  DDSegmentedTableView.h
//  SomeSDK_Example
//
//  Created by mac on 03/02/2020.
//  Copyright © 2020 syedhasnain0035. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHorizontalTagMenu.h"
NS_ASSUME_NONNULL_BEGIN

@protocol DDSegmentedTableViewDataSource <NSObject>
@required
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (nullable UITableViewHeaderFooterView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (nullable DDTagM *)tableView:(UITableView *)tableView tagForHeaderInSection:(NSInteger)section;
- (void)horizontalMenuToggleHidden:(BOOL)isHidden;
-(void)scrollViewDidScroll:(UIScrollView *)scrollView;
@end

@interface DDSegmentedTableView : UIView
//@property (weak, nonatomic) id<UITableViewDelegate> delegate;
@property (weak, nonatomic) id<DDSegmentedTableViewDataSource> dataSource;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (weak, nonatomic) UIView *tableHeaderView;
@property (assign, nonatomic) UIEdgeInsets contentInsets;
@property (assign, nonatomic) CGFloat estimatedHeaderHeight;
@property (strong, nonatomic) UIColor *selectionBackgroundColor;
@property (strong, nonatomic) UIColor *upperViewBackgroundColor;
@property (strong, nonatomic) UIColor *upperViewTableViewSeparatorColor;
-(void)reload;
-(void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
-(void)reloadSections:(NSIndexSet *)indexSet withRowAnimation:(UITableViewRowAnimation)animation;
-(void)registerCells:(NSArray<NSString *> *)nibNames andIdentifier:(NSArray<NSString *> *)identifiers;
-(void)registerHeaderFooter:(NSArray<NSString *> *)nibNames andIdentifier:(NSArray<NSString *> *)identifiers;
-(NSIndexPath *)indexPathForCell:(UITableViewCell *)cell;
-(void)removeSeparatorViewsFromTableView;

-(NSLayoutXAxisAnchor *)tvCenterXAnchor;
-(NSLayoutDimension *)tvWidthAnchor;
-(NSLayoutYAxisAnchor *)tvTopAnchor;
@end

NS_ASSUME_NONNULL_END
