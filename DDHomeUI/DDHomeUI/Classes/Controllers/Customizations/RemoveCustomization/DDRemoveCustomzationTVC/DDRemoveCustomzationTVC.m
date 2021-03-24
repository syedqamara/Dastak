//
//  DDRemoveCustomzationTVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 28/08/2020.
//

#import "DDRemoveCustomzationTVC.h"
#import "DDMerchantDeliveryMenuItemM.h"
#import "DDHomeThemeManager.h"
@implementation DDRemoveCustomzationTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.titleLabel.font = [UIFont DDSemiBoldFont:15];
    self.subTitleLabel.font = [UIFont DDRegularFont:13];
    self.deleteButton.titleLabel.font = [UIFont DDMediumFont:15];
    
    self.titleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.subTitleLabel.textColor = HOME_THEME.text_grey_111.colorValue;
    self.deleteButton.backgroundColor = @"fd4f57".colorValue;
    [self.deleteButton setTitleColor:HOME_THEME.text_white.colorValue forState:(UIControlStateNormal)];
}
-(void)setData:(id)data {
    [super setData:data];
    DDMerchantDeliveryMenuItemM *item = data;
    self.titleLabel.text = item.name;
    self.subTitleLabel.text = item.allSelectedOptions;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
