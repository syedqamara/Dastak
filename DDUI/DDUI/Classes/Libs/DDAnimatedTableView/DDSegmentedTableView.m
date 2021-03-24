//
//  DDSegmentedTableView.m
//  SomeSDK_Example
//
//  Created by mac on 03/02/2020.
//  Copyright © 2020 syedhasnain0035. All rights reserved.
//

#import "DDSegmentedTableView.h"
#import "UITableView+DDRegistration.h"
#import "Autolayout.h"

#define TOP_BANNER_HEIGHT 65.0
#define TOP_BANNER_TOP_MARGIN 0.0
#define TOP_BANNER_BOTTOM_MARGIN 5.0
#define TOP_VIEW_HIDDEN_CONSTRAINT_VALUE ((TOP_BANNER_HEIGHT + TOP_BANNER_BOTTOM_MARGIN) * (-1.0))
@interface DDSegmentedTableView ()<UITableViewDataSource,UITableViewDelegate, DDHorizontalTagMenuDelegate> {
    NSMutableArray <DDTagM *> *titles;
    NSIndexPath *previousCellIndexPath;
    Autolayout *topBannerHeightConstraint;
    Autolayout *topBannerTopConstraint;
    Autolayout *topBannerBottomConstraint;
}
@property (strong, nonatomic) UITableView *tblView;
@property (strong, nonatomic) DDHorizontalTagMenu *upperView;
@property (strong, nonatomic) UIView *separatorView;
@property (strong, nonatomic) NSArray <UIView *> *header_views;
@end

@implementation DDSegmentedTableView

-(instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self initializeView];
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initializeView];
    return self;
}
-(instancetype)init {
    self = [super init];
    [self initializeView];
    return self;
}
-(void)setSelectedIndex:(NSInteger)selectedIndex {
    self.upperView.selectedIndex = selectedIndex;
}
-(NSInteger)selectedIndex {
    return self.upperView.selectedIndex;
}
-(void)setSelectionBackgroundColor:(UIColor *)selectionBackgroundColor {
    self.upperView.selectionBackgroundColor = selectionBackgroundColor;
}
-(UIColor *)selectionBackgroundColor {
    return self.upperView.selectionBackgroundColor;
}
-(void)initializeView {
    self.clipsToBounds = YES; 
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    self.upperView = [DDHorizontalTagMenu.alloc initWithFrame:CGRectZero];
    self.upperView.translatesAutoresizingMaskIntoConstraints = NO;
    self.upperView.delegate = self;
    
    
    
    NSArray <Autolayout *> * constraints= [Autolayout addConstrainsToParentView:self andChildView:self.upperView withConstraintTypeArray:@[@(AutolayoutTop),@(AutolayoutRight),@(AutolayoutLeft), @(AutolayoutHeight)] andValues:@[@(TOP_BANNER_TOP_MARGIN),@(5),@(5),@(TOP_BANNER_HEIGHT)]];
    topBannerHeightConstraint = constraints.lastObject;
    topBannerTopConstraint = constraints.firstObject;
    
    self.upperView.backgroundColor = UIColor.whiteColor;
    
    
    self.tblView = [UITableView.alloc initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    if (@available(iOS 11.0, *)) {
        [self.tblView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    [Autolayout addConstrainsToParentView:self andChildView:self.tblView withConstraintTypeArray:@[@(AutolayoutBottom),@(AutolayoutRight),@(AutolayoutLeft)] andValues:@[@(0),@(0),@(0)]];
    topBannerBottomConstraint = [Autolayout addConstrainsToRefView:self.upperView andChildView:self.tblView withConstraintTypeArray:@[@(AutolayoutTop)] andValues:@[@(TOP_BANNER_BOTTOM_MARGIN)]].firstObject;
    
    
    self.separatorView = [[UIView alloc]initWithFrame:(CGRectZero)];
    [Autolayout addConstrainsToParentView:self andChildView:self.separatorView withConstraintTypeArray:@[@(AutolayoutHeight),@(AutolayoutRight),@(AutolayoutLeft)] andValues:@[@(0.5),@(0),@(0)]];
    [Autolayout addConstrainsToRefView:self.upperView andChildView:self.separatorView withConstraintTypeArray:@[@(AutolayoutTop)] andValues:@[@(0)]];
    
    
    [self checkAndShowHideTopBanner];
    self.tblView.dataSource = self;
    self.tblView.delegate = self;
    self.tblView.separatorColor = UIColor.clearColor;
    [self.tblView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self checkAndShowHideTopBanner];
    
}
-(void)setDelegate:(id<UITableViewDelegate>)delegate {
    self.tblView.delegate = delegate;
}
-(id<UITableViewDelegate>)delegate {
    return self.tblView.delegate;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataSource != nil) {
        NSInteger count = [self.dataSource numberOfSectionsInTableView:tableView];
        [self initializeSegmentsWithCount:count];
        return count;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource != nil) {
        return [self.dataSource tableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource != nil) {
        UITableViewCell *cell = [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
//        [self animateAllCells:cell atIndexPath:indexPath];
        return cell;
    }
    return [UITableViewCell new];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.dataSource != nil) {
//        return self.header_views[section];
        return [self.dataSource tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.dataSource != nil) {
        return [self.dataSource tableView:tableView heightForHeaderInSection:section];
    }
    return 0.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource != nil) {
        return [self.dataSource tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}
- (UIView*)tableView:(UITableView*)tableView
           viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}
-(DDTagM *)tableView:(UITableView *)tableView tagForHeaderInSection:(NSInteger)section {
    if (self.dataSource != nil && [self.delegate respondsToSelector:@selector(tableView:tagForHeaderInSection:)]) {
        return [self.dataSource tableView:tableView tagForHeaderInSection:section];
    }
    return nil;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return self.upperView.dataSource[section].title;
//}
-(void)segmentedControlChangedValue:(NSInteger)section {
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:section];
    [self.tblView scrollToRowAtIndexPath:path atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
}

-(void)reloadData {
    [self initializeSegmentsWithCount:[self numberOfSectionsInTableView:self.tblView]];
    [self.tblView reloadData];
}
-(void)initializeSegmentsWithCount:(NSInteger)sectionCount {
    titles = [NSMutableArray new];
    for (NSInteger i = 0; i < sectionCount; i++) {
        DDTagM *tag = [self tableView:self.tblView tagForHeaderInSection:i];
        if (tag != nil) {
            [titles addObject:tag];
        }
    }
    if (titles.count > 0) {
        self.upperView.dataSource = titles;
        self.upperView.selectedIndex = self.selectedIndex;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.dataSource != nil && [self.dataSource respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.dataSource scrollViewDidScroll:scrollView];
    }
    [self checkAndShowHideTopBanner];
}
-(BOOL)upperViewIsAlreadyHidden {
    return topBannerTopConstraint.value == TOP_VIEW_HIDDEN_CONSTRAINT_VALUE;
}
-(void)checkAndShowHideTopBanner {
    
    NSNumber *index = (NSNumber *)self.tblView.indexesOfVisibleSections.firstObject;
    if (index.integerValue < self.upperView.dataSource.count) {
        DDTagM *tag = self.upperView.dataSource[index.integerValue];
        if (tag.is_enabled && self.tblView.isDragging) {
            if (self.upperView.selectedIndex != index.integerValue) {
                self.upperView.selectedIndex = index.integerValue;
            }
            [UIView animateWithDuration:0.3 animations:^{
                [self->topBannerTopConstraint changeConstraintValue:TOP_BANNER_TOP_MARGIN];
                [self layoutIfNeeded];
            }];
            [self topViewIsHiding:NO];
        }else {
            if (!tag.is_enabled && ![self upperViewIsAlreadyHidden]) {
                [UIView animateWithDuration:0.3 animations:^{
                    [self->topBannerTopConstraint changeConstraintValue:TOP_VIEW_HIDDEN_CONSTRAINT_VALUE];
                    [self layoutIfNeeded];
                }];
                [self topViewIsHiding:YES];
            }
        }
    }else if (![self upperViewIsAlreadyHidden]){
        [UIView animateWithDuration:0.3 animations:^{
            [self->topBannerTopConstraint changeConstraintValue:TOP_VIEW_HIDDEN_CONSTRAINT_VALUE];
            [self layoutIfNeeded];
        }];
        [self topViewIsHiding:YES];
    }
}
-(void)topViewIsHiding:(BOOL)isHidding {
    if(self.dataSource != nil) {
        [self.dataSource horizontalMenuToggleHidden:isHidding];
    }
}
-(void)animateAllCells:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == previousCellIndexPath.section || indexPath.section > previousCellIndexPath.section) {
        BOOL shouldAnimate = indexPath.section > previousCellIndexPath.section;
        if (indexPath.row > previousCellIndexPath.row || shouldAnimate) {
            cell.transform = CGAffineTransformMakeTranslation(0, 300);
//            cell.transform = CGAffineTransformMakeTranslation(-1000, 0);
            NSInteger actualIndexNumber = 0;
            for (NSInteger index = 0; index < indexPath.section; index++) {
                NSInteger totalRows = [self tableView:self.tblView numberOfRowsInSection:index];
                if (index == indexPath.section) {
                    totalRows = totalRows - (totalRows - (indexPath.row + 1));
                }
                actualIndexNumber += totalRows;
            }
            [UIView animateWithDuration:1.2 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.15 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
            } completion:nil];
            
        }
    }
    previousCellIndexPath = indexPath;
}
-(void)didTapHorizontalTagAtIndex:(NSInteger)index {
    [self segmentedControlChangedValue:index];
}
-(void)reload {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tblView reloadData];
    });
    [self checkAndShowHideTopBanner];
}
- (float) widthForText: (NSString *) string font: (UIFont *) font height: (float) height {
    NSDictionary *fontAttributes = [NSDictionary dictionaryWithObject: font
                                                               forKey: NSFontAttributeName];
    CGRect rect = [string boundingRectWithSize: CGSizeMake(INT_MAX, height)
                                       options: NSStringDrawingUsesLineFragmentOrigin
                                    attributes: fontAttributes
                                       context: nil];
    return rect.size.width + 25;
}
-(void)registerCells:(NSArray<NSString *> *)nibNames andIdentifier:(NSArray<NSString *> *)identifiers {
    [self.tblView registerCellWithNibNames:nibNames forClass:self.class withIdentifiers:identifiers];
}
-(void)registerHeaderFooter:(NSArray<NSString *> *)nibNames andIdentifier:(NSArray<NSString *> *)identifiers {
    [self.tblView registerHeaderFooterWithNibNames:nibNames forClass:self.class withIdentifiers:identifiers];
}
-(NSIndexPath *)indexPathForCell:(UITableViewCell *)cell {
    return [self.tblView indexPathForCell:cell];
}
-(void)reloadSections:(NSIndexSet *)indexSet withRowAnimation:(UITableViewRowAnimation)animation {
    [self.tblView beginUpdates];
    [self.tblView reloadSections:indexSet withRowAnimation:animation];
    [self.tblView endUpdates];
    [self checkAndShowHideTopBanner];
}
-(void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self.tblView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self checkAndShowHideTopBanner];
}
-(void)setTableHeaderView:(UIView *)tableHeaderView {
    self.tblView.tableHeaderView = tableHeaderView;
}
-(UIView *)tableHeaderView {
    return self.tblView.tableHeaderView;
}
-(void)setContentInsets:(UIEdgeInsets)contentInsets {
    self.tblView.contentInset = contentInsets;
}
-(UIEdgeInsets)contentInsets {
    return self.tblView.contentInset;
}
-(NSLayoutXAxisAnchor *)tvCenterXAnchor {
    return self.tblView.centerXAnchor;
}
-(NSLayoutDimension *)tvWidthAnchor {
    return self.tblView.widthAnchor;
}
-(NSLayoutYAxisAnchor *)tvTopAnchor {
    return self.tblView.topAnchor;
}
-(void)setEstimatedHeaderHeight:(CGFloat)estimatedHeaderHeight {
    self.tblView.estimatedSectionHeaderHeight = estimatedHeaderHeight;
    self.tblView.sectionHeaderHeight = UITableViewAutomaticDimension;
}

-(CGFloat)estimatedHeaderHeight {
    return self.tblView.estimatedSectionHeaderHeight;
}
-(void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.tblView.backgroundColor = backgroundColor;
}
-(void)setUpperViewBackgroundColor:(UIColor *)upperViewBackgroundColor {
    self.upperView.backgroundColor = upperViewBackgroundColor;
}
-(void)setUpperViewTableViewSeparatorColor:(UIColor *)upperViewTableViewSeparatorColor {
    self.separatorView.backgroundColor = upperViewTableViewSeparatorColor;
}
-(void)removeSeparatorViewsFromTableView {
    for (UIView *subView in self.tblView.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITableViewCellSeparator")]) {
            [subView removeFromSuperview];
        }
    }
}
@end
