//
//  RedemptionMerchantAttributeCVC.m
//  DDRedemptionsUI
//
//  Created by Syed Qamar Abbas on 12/03/2020.
//

#import "DDRedemptionMerchantAttributeCVC.h"


@implementation DDRedemptionMerchantAttributeCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.titleLabel.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.titleLabel.font = [UIFont DDRegularFont:13];
}
-(void)setData:(id)data {
    DDOfferAdditionalDetail *detail = (DDOfferAdditionalDetail*)data;
    self.titleLabel.text = detail.title;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:detail.image]];
    [super setData:data];
}
@end
