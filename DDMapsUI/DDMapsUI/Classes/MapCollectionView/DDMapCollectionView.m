//
//  DDMapCollectionView.m
//  DDMapsUI
//
//  Created by Zubair Ahmad on 11/02/2020.
//

#import "DDMapCollectionView.h"
#import "DDMapsUIConstants.h"

@interface DDMapCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    CGPoint lastContentOffset;
}

@end

@implementation DDMapCollectionView

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (!(self = [super initWithCoder:aDecoder])) return nil;
    
    self.dataSource = self;
    self.delegate = self;
    [self registerCellWithNibNames:@[DDMapCVCell] forClass:self.class withIdentifiers:@[DDMapCVCell]];
    self.backgroundColor = [UIColor clearColor];
    if(IS_IPHONE_5) {
        [self setContentOffset:CGPointMake(30, 10) animated:YES];
    }
    
    CustomViewFlowLayoutCollectionView* layout = [[CustomViewFlowLayoutCollectionView alloc] init];
    layout.itemSize = CGSizeMake(self.frame.size.width-75, 76);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.offSet = 16;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionViewLayout = layout;
    
    self.pagingEnabled = NO;
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    self.showsHorizontalScrollIndicator = NO;
    
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.outlets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DDMapCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DDMapCVCell forIndexPath:indexPath];
    [cell setData:self.outlets[indexPath.item]];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id outlet = [self.outlets objectAtIndex:indexPath.row];
    [self.mapDelegate didSelectCollectionViewCellWithOutlet:outlet];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    lastContentOffset = scrollView.contentOffset;
}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"end Decelerating");
//}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateMapCellPosition];
    });
}


-(void)updateMapCellPosition{
    UICollectionViewCell *closestCell  = self.visibleCells[0];
    NSIndexPath *newIndexPath = [self indexPathForCell:closestCell];
    
    if (lastContentOffset.x < self.contentOffset.x) {
        for (UICollectionViewCell *cell in self.visibleCells) {
            NSIndexPath * indexPath = [self indexPathForCell:cell];
            if (indexPath.row >= newIndexPath.row){
                newIndexPath = indexPath;
            }
        }
    }
    else if (lastContentOffset.x > self.contentOffset.x) {
        for (UICollectionViewCell *cell in self.visibleCells) {
            NSIndexPath *indexPath = [self indexPathForCell:cell];
            if (indexPath.row < newIndexPath.row){
                newIndexPath = indexPath;
            }
        }
    }
    [self scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
    self.userInteractionEnabled = true;
    
    id outletTemp = [self.outlets objectAtIndex:newIndexPath.row];
    [self.mapDelegate didHiglightMapPinWithOutlet:outletTemp];
}

-(void)selectOutlet:(id)outlet{
    int index = [self findOutlet:outlet];
    if(index >= 0){
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
    }
}

-(int)findOutlet:(id)outlet{
    for (int i =0 ; i< _outlets.count ; i++){
        id outletTemp = [self.outlets objectAtIndex:i];
//        if([outletTemp.outlet_id isEqualToNumber:[outlet outlet_id]]) {
//            return i;
//        }
    }
    return -1;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 16, 0, 16);
}

@end
