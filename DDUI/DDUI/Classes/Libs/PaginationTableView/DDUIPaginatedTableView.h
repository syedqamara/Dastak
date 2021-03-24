//
//  DDUIPaginatedTableView.h
//  DDSearchUI_Example
//
//  Created by Syed Qamar Abbas on 14/01/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDSUIPaginationAnimationTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@class DDUIPaginatedTableView;

@protocol DDUIPaginatedTableViewDelegate <NSObject>
-(NSInteger)numberOfSectionInPaginatedTV:(DDUIPaginatedTableView *)tableView;
-(NSInteger)paginatedTV:(DDUIPaginatedTableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell *)paginatedTV:(DDUIPaginatedTableView *)tableView cellForRowAt:(NSIndexPath *)indexPath;
-(DDSUIPaginationAnimationTableViewCell *)cellForPaginationPaginatedTV:(DDUIPaginatedTableView *)tableView;
-(void)paginatedTV:(DDUIPaginatedTableView *)tableView willDisplayCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(void)paginatedTV:(DDUIPaginatedTableView *)tableView didEndDisplayCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(void)shouldStartPagination:(DDUIPaginatedTableView *)tableView withCell:(DDSUIPaginationAnimationTableViewCell *)cell;

- (CGFloat)paginatedTV:(DDUIPaginatedTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)paginatedTV:(DDUIPaginatedTableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)paginatedTV:(DDUIPaginatedTableView *)tableView heightForFooterInSection:(NSInteger)section;
- (CGFloat)paginatedTV:(DDUIPaginatedTableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(7.0));
- (CGFloat)paginatedTV:(DDUIPaginatedTableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section API_AVAILABLE(ios(7.0));
- (CGFloat)paginatedTV:(DDUIPaginatedTableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section API_AVAILABLE(ios(7.0));

- (void)paginatedTV:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)paginatedTV:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(3.0));

-(void)scrollViewDidScroll:(UIScrollView *)scrollView;
-(void)scrollViewDidZoom:(UIScrollView *)scrollView API_AVAILABLE(ios(3.2));
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset API_AVAILABLE(ios(5.0));
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
-(nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;
-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view API_AVAILABLE(ios(3.2));
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale;
-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView;
-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;
-(void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView API_AVAILABLE(ios(11.0), tvos(11.0));

@end

@interface DDUIPaginatedTableView : UITableView
@property (weak, nonatomic) id<DDUIPaginatedTableViewDelegate> paginationDataSource;
@property (assign, nonatomic) BOOL shouldShowPaginationCell;
@property (assign, nonatomic) BOOL isPaginating;

-(void)insertNewAtSection:(NSInteger)section withPreviousRowCount:(NSInteger)beforeCount andNewRowCount:(NSInteger)newCount;

//-(void)reloadPaginationsAtIndexPath:(NSArray <NSIndexPath *>*)indexPaths;
@end



NS_ASSUME_NONNULL_END
