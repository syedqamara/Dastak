//
//  DDHomeTileAttributeCVC.h
//  DDHomeUI
//
//  Created by Syed Qamar Abbas on 01/07/2020.
//

#import "DDBaseCVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHomeTileAttributeCVC : DDBaseCVC
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *tileImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *tileTitleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *titleContainerView;
+(UIFont *)titleFont;
@end

NS_ASSUME_NONNULL_END
