//
//  DDOutletsTVC.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 06/08/2020.
//

#import "DDBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDOutletsTVC : DDBaseTVC
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *outletImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *outletNameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *outletTimingLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UICollectionView *outletAttributeCV;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *separatoor;

@end

NS_ASSUME_NONNULL_END
