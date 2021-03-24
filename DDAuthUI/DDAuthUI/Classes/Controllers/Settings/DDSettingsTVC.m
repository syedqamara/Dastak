//
//  DDSettingsTVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 23/07/2020.
//

#import "DDSettingsTVC.h"
#import "DDSettingsVM.h"
#import "DDAuthUIThemeManager.h"
#import <DDCommons.h>
@implementation DDSettingsTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.titleLabel.textColor = AUTH_THEME.text_black_40.colorValue;
    self.titleLabel.font = [UIFont DDRegularFont:15];
    self.separatorView.backgroundColor = AUTH_THEME.text_grey_238.colorValue;
    self.arrowImgView.tintColor = AUTH_THEME.text_grey_238.colorValue;
    [self.arrowImgView loadTemplateImageWithString:@"ic-arrow-right.png" forClass:self.class];
}
-(void)setData:(id)data {
    DDSettingsVM *setting = data;
    self.titleLabel.text = setting.title;
    [self.settingsImageView.superview setHidden:!setting.haveImage];
    [self.settingsImageView loadImageWithString:setting.image forClass:self.class];
    [super setData:data];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
