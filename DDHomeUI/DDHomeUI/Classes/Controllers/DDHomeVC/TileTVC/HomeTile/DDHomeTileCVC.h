//
//  DDHomeTileCVC.h
//  DDHomeUI
//
//  Created by Syed Qamar Abbas on 01/07/2020.
//

#import "DDBaseCVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHomeTileCVC : DDBaseCVC
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *timeContainerView;
@property (weak, nonatomic) IBOutlet UILabel *timeUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *tileAttributeCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *attributeCollectionView;

@end

NS_ASSUME_NONNULL_END
