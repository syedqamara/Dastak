//
//  DDAddCustomisationTVC.m
//  ANStepperView
//
//  Created by Syed Qamar Abbas on 30/07/2020.
//

#import "DDAddCustomisationTVC.h"
#import "DDHomeThemeManager.h"
#import "DDMerchantMenuItemCustomizationOptionM.h"

@interface DDAddCustomisationTVC ()

@end

@implementation DDAddCustomisationTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.titleLabel.font = [UIFont DDMediumFont:15];
    self.subtitleLabel.font = [UIFont DDRegularFont:15];
    self.titleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.subtitleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.separatorView.backgroundColor = HOME_THEME.text_grey_238.colorValue;
}
-(void)setData:(id)data {
    DDMerchantMenuItemCustomizationOptionM *option = data;
    if (option.isSelected) {
        [self.checkBoxImageView loadImageWithString:@"checkbox.png" forClass:self.class];
    }else {
        self.checkBoxImageView.tintColor = HOME_THEME.bg_grey_199.colorValue;
        [self.checkBoxImageView loadTemplateImageWithString:@"uncheckbox.png" forClass:self.class];
    }
    self.titleLabel.text = option.title;
    self.subtitleLabel.text = option.priceWithCurrency;
    [super setData:data];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
