//
//  CustomViewFlowLayoutSuggestion.h
//  DDHomeUI
//
//  Created by M.Jabbar on 15/01/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomViewFlowLayoutCollectionView : UICollectionViewFlowLayout {
    CGPoint previousOffset;
}
@property(nonatomic) CGFloat maximumLineSpacing;
@property(nonatomic) CGFloat offSet;

-(void)resetPreviousOffet;
@end

NS_ASSUME_NONNULL_END
