//
//  DDMerchantReviewTVC.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 06/09/2020.
//

#import "DDBaseTVC.h"
#import "HCSStarRatingView.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantReviewTVC : DDBaseTVC
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *dateLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *reviewLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *separatorLabel;
@property (unsafe_unretained, nonatomic) IBOutlet HCSStarRatingView *ratingView;

@end

NS_ASSUME_NONNULL_END
