//
//  DDPurchaseRedemptionTVC.h
//  DDRedemptionsUI
//
//  Created by Syed Qamar Abbas on 13/03/2020.
//

#import "DDRedemptionBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPurchaseRedemptionTVC : DDRedemptionBaseTVC
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *purchaseInfoLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *purchaseButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *purchaseButtonContainerView;
@end

NS_ASSUME_NONNULL_END
