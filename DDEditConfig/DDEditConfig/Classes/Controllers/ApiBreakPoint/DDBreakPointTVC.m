//
//  DDBreakPointTVC.m
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 24/04/2020.
//

#import "DDBreakPointTVC.h"
#import "DDEdiConfigBreakPointM.h"
#import "DDUI.h"

@interface DDBreakPointTVC() {
    DDBreakPointM *breakPoint;
}
@property (weak, nonatomic) IBOutlet UILabel *requestLabel;
@property (weak, nonatomic) IBOutlet UILabel *responseLabel;

@end

@implementation DDBreakPointTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.responseSwitch addTarget:self action:@selector(didChangeSwitch:) forControlEvents:(UIControlEventValueChanged)];
    [self.requestSwitch addTarget:self action:@selector(didChangeSwitch:) forControlEvents:(UIControlEventValueChanged)];
    // Initialization code
}
-(void)designUI {
    self.titleLabel.textColor = DDUIThemeManager.shared.selected_theme.text_white.colorValue;
    self.subTitle.textColor = DDUIThemeManager.shared.selected_theme.text_white.colorValue;
    self.requestLabel.textColor = DDUIThemeManager.shared.selected_theme.text_white.colorValue;
    self.responseLabel.textColor = DDUIThemeManager.shared.selected_theme.text_white.colorValue;
    
    self.requestSwitch.onTintColor = DDUIThemeManager.shared.selected_theme.text_white.colorValue;
    self.requestSwitch.thumbTintColor = DDUIThemeManager.shared.selected_theme.app_theme_dark.colorValue;
    self.responseSwitch.onTintColor = DDUIThemeManager.shared.selected_theme.text_white.colorValue;
    self.responseSwitch.thumbTintColor = DDUIThemeManager.shared.selected_theme.app_theme_dark.colorValue;
    
    self.backgroundColor = UIColor.clearColor;
    
    self.titleLabel.font = [UIFont DDBoldFont:16];
    self.subTitle.font = [UIFont DDRegularFont:14];
    self.requestLabel.font = [UIFont DDMediumFont:13];
    self.responseLabel.font = [UIFont DDMediumFont:13];
}
-(void)setData:(id)data {
    breakPoint = (DDBreakPointM *)data;
    [self.requestSwitch setOn:breakPoint.isRequestSelected];
    [self.responseSwitch setOn:breakPoint.isResponseSelected];
    self.titleLabel.text = breakPoint.title;
    self.subTitle.text = breakPoint.sub_title;
    [super setData:data];
}
-(void)didChangeSwitch:(UISwitch *)switchView {
    if (switchView == self.requestSwitch) {
        [breakPoint setRequestSelected:switchView.isOn];
    }else {
        [breakPoint setResponseSelected:switchView.isOn];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
