//
//  DDMerchantReviewTVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 06/09/2020.
//

#import "DDMerchantReviewTVC.h"
#import "DDHomeThemeManager.h"
#import "DDMerchantRatingM.h"
@implementation DDMerchantReviewTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.titleLabel.font = [UIFont DDSemiBoldFont:17];
    self.dateLabel.font = [UIFont DDMediumFont:13];
    self.reviewLabel.font = [UIFont DDRegularFont:15];
    
    self.titleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.dateLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.reviewLabel.textColor = HOME_THEME.text_grey_111.colorValue;
    
    self.ratingView.maximumValue = 7;
    self.ratingView.minimumValue = 0;
    self.ratingView.tintColor = HOME_THEME.app_theme.colorValue;
}
-(void)setData:(id)data {
    [super setData:data];
    DDMerchantRatingReviewsM *rating = data;
    self.titleLabel.text = rating.title;
    self.dateLabel.text = rating.sub_title;
    self.reviewLabel.text = rating.review_text;
    self.ratingView.value = rating.rate.floatValue;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
