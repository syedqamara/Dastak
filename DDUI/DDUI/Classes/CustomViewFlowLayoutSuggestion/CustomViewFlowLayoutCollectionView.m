//
//  CustomViewFlowLayoutCollectionView.m
//  DDHomeUI
//
//  Created by M.Jabbar on 15/01/2020.
//

#import "CustomViewFlowLayoutCollectionView.h"

@implementation CustomViewFlowLayoutCollectionView

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //NSLog(@"\nVelocity= %f\n",velocity.x);
   /* CGFloat offsetMargin = (self.itemSize.width + self.offSet);
    CGFloat maximumMargin = self.collectionView.contentSize.width - (offsetMargin);
    if (velocity.x > 0) {
        CGPoint newPoint = CGPointMake(previousOffset.x + offsetMargin, 0);
        if (newPoint.x <= maximumMargin ) {
            NSLog(@"\nNew Point= %f\n",newPoint.x);
            previousOffset = newPoint;
        }
        return previousOffset;
    }
    else if (velocity.x < 0) {
        CGPoint newPoint = CGPointMake(previousOffset.x - offsetMargin, 0);
        if (newPoint.x < self.collectionView.contentSize.width) {
            previousOffset = newPoint;
        }
        if (newPoint.x < 0) {
            previousOffset = CGPointZero;
        }
        NSLog(@"\nNew Point= %f\n",previousOffset.x);
        return previousOffset;
    }*/
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalOffset = proposedContentOffset.x + self.offSet;
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in array) {
        CGFloat itemOffset = layoutAttributes.frame.origin.x;
        if (ABS(itemOffset - horizontalOffset) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemOffset - horizontalOffset;
        }
    }
    previousOffset = CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
    return previousOffset;
}
-(void)resetPreviousOffet{
    previousOffset = CGPointMake(0, 0);
}
@end
