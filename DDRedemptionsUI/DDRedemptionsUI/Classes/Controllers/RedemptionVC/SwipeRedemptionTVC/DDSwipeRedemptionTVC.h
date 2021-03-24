//
//  DDSwipeRedemptionTVC.h
//  DDRedemptionsUI
//
//  Created by Syed Qamar Abbas on 13/03/2020.
//

#import "DDRedemptionBaseTVC.h"
#import "DDSliderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDSwipeRedemptionTVC : DDRedemptionBaseTVC<DDSliderViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet DDSliderView *swipeContainerView;

@end

NS_ASSUME_NONNULL_END
