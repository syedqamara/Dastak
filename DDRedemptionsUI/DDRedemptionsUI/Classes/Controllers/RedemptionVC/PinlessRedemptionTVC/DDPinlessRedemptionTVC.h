//
//  DDPinlessRedemptionTVC.h
//  DDRedemptionsUI
//
//  Created by Syed Qamar Abbas on 13/03/2020.
//

#import "DDRedemptionBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPinlessRedemptionTVC : DDRedemptionBaseTVC
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *redeemButton;
@end

NS_ASSUME_NONNULL_END
