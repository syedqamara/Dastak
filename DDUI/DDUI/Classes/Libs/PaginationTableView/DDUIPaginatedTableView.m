//
//  DDUIPaginatedTableView.m
//  DDSearchUI_Example
//
//  Created by Syed Qamar Abbas on 14/01/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import "DDUIPaginatedTableView.h"

@interface DDUIPaginatedTableView() <UITableViewDataSource, UITableViewDelegate>

@end

@implementation DDUIPaginatedTableView
-(instancetype)init {
    self = [super init];
    [self setTVDataSource];
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self setTVDataSource];
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setTVDataSource];
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    [self setTVDataSource];
    return self;
}
-(void)setTVDataSource {
    super.dataSource = self;
    super.delegate = self;
}
-(void)setDataSource:(id<UITableViewDataSource>)dataSource {
    if (dataSource != nil) {
        NSAssert(false, @"Please use `paginationDataSource` instead of `dataSource`");
    }
}
-(void)setDelegate:(id<UITableViewDelegate>)delegate {
    if (delegate != nil) {
        NSAssert(false, @"Please use `paginationDataSource` instead of `delegate`");
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sections = 1;
    if ([self.paginationDataSource respondsToSelector:@selector(numberOfSectionInPaginatedTV:)]) {
        sections = [self.paginationDataSource numberOfSectionInPaginatedTV:self];
    }
    return sections;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    if ([self.paginationDataSource respondsToSelector:@selector(paginatedTV:numberOfRowsInSection:)]) {
        rows = [self.paginationDataSource paginatedTV:self numberOfRowsInSection:section];
    }
    NSInteger totalSections = [self numberOfSectionsInTableView:self];
    if (section == (totalSections - 1) && self.shouldShowPaginationCell) {
        if (rows > 0) {
            rows++;
        }
    }
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger totalSections = [self numberOfSectionsInTableView:self];
    NSInteger totalRowsInCurrentSections = [self tableView:self numberOfRowsInSection:indexPath.section];
    if (totalSections - 1 == indexPath.section && totalRowsInCurrentSections - 1 == indexPath.row) {
        if ([self.paginationDataSource respondsToSelector:@selector(cellForPaginationPaginatedTV:)]) {
            UITableViewCell *cell = [self.paginationDataSource cellForPaginationPaginatedTV:self];
            if (cell == nil) {
                return [self defaultPaginationCell];
            }
            return cell;
        }else {
            return [self defaultPaginationCell];
        }
    }
    if ([self.paginationDataSource respondsToSelector:@selector(paginatedTV:cellForRowAt:)]) {
        return [self.paginationDataSource paginatedTV:self cellForRowAt:indexPath];
    }
    return [UITableViewCell new];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger totalSections = [self numberOfSectionsInTableView:self];
    NSInteger totalRowsInCurrentSections = [self tableView:self numberOfRowsInSection:indexPath.section];
    if (totalSections - 1 == indexPath.section && totalRowsInCurrentSections - 1 == indexPath.row && self.shouldShowPaginationCell) {
        if ([self.paginationDataSource respondsToSelector:@selector(shouldStartPagination:withCell:)]) {
            DDSUIPaginationAnimationTableViewCell *pageCell = (DDSUIPaginationAnimationTableViewCell *)cell;
            if (!self.isPaginating) {
                self.isPaginating = YES;
                [self.paginationDataSource shouldStartPagination:self withCell:pageCell];
            }
            if (self.isPaginating) {
                [pageCell startAnimation];
            }else {
                [pageCell stopAnimation];
            }
        }
    }
    if ([self.paginationDataSource respondsToSelector:@selector(paginatedTV:willDisplayCell:atIndexPath:)]) {
        [self.paginationDataSource paginatedTV:self willDisplayCell:cell atIndexPath:indexPath];
    }
}
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.paginationDataSource respondsToSelector:@selector(paginatedTV:didEndDisplayCell:atIndexPath:)]) {
        [self.paginationDataSource paginatedTV:self didEndDisplayCell:cell atIndexPath:indexPath];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.paginationDataSource respondsToSelector:@selector(paginatedTV:heightForRowAtIndexPath:)]) {
        return [self.paginationDataSource paginatedTV:self heightForRowAtIndexPath:indexPath];
    }
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.paginationDataSource respondsToSelector:@selector(paginatedTV:heightForHeaderInSection:)]) {
        return [self.paginationDataSource paginatedTV:self heightForHeaderInSection:section];
    }
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self.paginationDataSource respondsToSelector:@selector(paginatedTV:heightForFooterInSection:)]) {
        return [self.paginationDataSource paginatedTV:self heightForFooterInSection:section];
    }
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(7.0)) {
    if ([self.paginationDataSource respondsToSelector:@selector(paginatedTV:estimatedHeightForRowAtIndexPath:)]) {
        return [self.paginationDataSource paginatedTV:self estimatedHeightForRowAtIndexPath:indexPath];
    }
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section API_AVAILABLE(ios(7.0)) {
    if ([self.paginationDataSource respondsToSelector:@selector(paginatedTV:estimatedHeightForHeaderInSection:)]) {
        return [self.paginationDataSource paginatedTV:self estimatedHeightForHeaderInSection:section];
    }
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section API_AVAILABLE(ios(7.0)) {
    if ([self.paginationDataSource respondsToSelector:@selector(paginatedTV:estimatedHeightForFooterInSection:)]) {
        return [self.paginationDataSource paginatedTV:self estimatedHeightForFooterInSection:section];
    }
    return UITableViewAutomaticDimension;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if([self.paginationDataSource respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.paginationDataSource scrollViewDidScroll:self];
    }
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView API_AVAILABLE(ios(3.2)) {
    if([self.paginationDataSource respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.paginationDataSource scrollViewDidZoom:self];
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if([self.paginationDataSource respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.paginationDataSource scrollViewWillBeginDragging:self];
    }
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset API_AVAILABLE(ios(5.0)) {
    if([self.paginationDataSource respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.paginationDataSource scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if([self.paginationDataSource respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.paginationDataSource scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if([self.paginationDataSource respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.paginationDataSource scrollViewWillBeginDecelerating:self];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if([self.paginationDataSource respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.paginationDataSource scrollViewDidEndDecelerating:self];
    }
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if([self.paginationDataSource respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.paginationDataSource scrollViewDidEndScrollingAnimation:self];
    }
}
-(nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if([self.paginationDataSource respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.paginationDataSource viewForZoomingInScrollView:self];
    }
    return nil;
}
-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view API_AVAILABLE(ios(3.2)) {
    if([self.paginationDataSource respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.paginationDataSource scrollViewWillBeginZooming:self withView:view];
    }
}
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    if([self.paginationDataSource respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.paginationDataSource scrollViewDidEndZooming:self withView:view atScale:scale];
    }
}
-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if([self.paginationDataSource respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.paginationDataSource scrollViewShouldScrollToTop:self];
    }
    return YES;
}
-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if([self.paginationDataSource respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.paginationDataSource scrollViewDidScrollToTop:self];
    }
}
-(void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView API_AVAILABLE(ios(11.0), tvos(11.0)) {
    if([self.paginationDataSource respondsToSelector:@selector(scrollViewDidChangeAdjustedContentInset:)]) {
        [self.paginationDataSource scrollViewDidChangeAdjustedContentInset:self];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.paginationDataSource respondsToSelector:@selector(paginatedTV:didSelectRowAtIndexPath:)]){
        [self.paginationDataSource paginatedTV:self didSelectRowAtIndexPath:indexPath];
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(3.0)) {
    if([self.paginationDataSource respondsToSelector:@selector(paginatedTV:didDeselectRowAtIndexPath:)]){
        [self.paginationDataSource paginatedTV:self didDeselectRowAtIndexPath:indexPath];
    }
}
-(void)reloadPaginationsAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths {
    self.isPaginating = NO;
    [self beginUpdates];
    [self insertRowsAtIndexPaths:indexPaths withRowAnimation:(UITableViewRowAnimationLeft)];
    [self endUpdates];
}
-(void)reloadData {
    self.isPaginating = NO;
    [super reloadData];
}
-(DDSUIPaginationAnimationTableViewCell *)defaultPaginationCell {
    DDSUIPaginationAnimationTableViewCell *cell = [DDSUIPaginationAnimationTableViewCell.alloc initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"123"];
    cell.backgroundColor = UIColor.blackColor;
    cell.textLabel.textColor = UIColor.whiteColor;
    cell.textLabel.font = [UIFont systemFontOfSize:17 weight:(UIFontWeightBold)];
    cell.textLabel.text = @"Fetching...";
    cell.textLabel.backgroundColor = UIColor.clearColor;
    return cell;
}
-(void)insertNewAtSection:(NSInteger)section withPreviousRowCount:(NSInteger)beforeCount andNewRowCount:(NSInteger)newCount {
    NSMutableArray <NSIndexPath *> *arr = [NSMutableArray new];
    for (NSInteger index = beforeCount; index < (beforeCount + newCount); index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
        [arr addObject:indexPath];
    }
    [self reloadPaginationsAtIndexPath:arr];
}
@end
