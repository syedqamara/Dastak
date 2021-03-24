//
//  DDMerchantInfoTVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 04/09/2020.
//

#import "DDMerchantInfoTVC.h"
#import "DDMerchantInfoSectionListM.h"
#import "DDHomeThemeManager.h"
@implementation DDMerchantInfoTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.titleLabel.font = [UIFont DDMediumFont:15];
    self.subTitleLabel.font = [UIFont DDRegularFont:15];
    self.titleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.subTitleLabel.textColor = HOME_THEME.text_grey_111.colorValue;
    
}
-(void)setData:(id)data {
    [super setData:data];
    DDMerchantInfoSectionListM *obj = data;
    self.titleLabel.text = obj.title;
    self.subTitleLabel.text = obj.sub_title;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
