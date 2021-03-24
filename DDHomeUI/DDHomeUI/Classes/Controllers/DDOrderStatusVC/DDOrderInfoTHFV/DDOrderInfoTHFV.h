//
//  DDOrderInfoTHFV.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/07/2020.
//

#import "DDBaseHFV.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDOrderInfoTHFV : DDBaseHFV
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

NS_ASSUME_NONNULL_END
