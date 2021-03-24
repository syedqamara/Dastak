//
//  DDAPIConfigTVC.m
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 24/04/2020.
//

#import "DDAPIConfigTVC.h"
#import "DDNetwork.h"
#import "DDUI.h"

@interface DDAPIConfigTVC() {
    DDApisConfiguration *config;
}
@end

@implementation DDAPIConfigTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
-(void)designUI {
    self.titleLabel.textColor = DDUIThemeManager.shared.selected_theme.text_white.colorValue;
    self.backgroundColor = UIColor.clearColor;
    self.titleLabel.font = [UIFont DDBoldFont:19];
    
    [self.encSwitch addTarget:self action:@selector(didChangeSwitch:) forControlEvents:(UIControlEventValueChanged)];
    [self.sslSwitch addTarget:self action:@selector(didChangeSwitch:) forControlEvents:(UIControlEventValueChanged)];
    [self.staticSwitch addTarget:self action:@selector(didChangeSwitch:) forControlEvents:(UIControlEventValueChanged)];
    
    [self.endpointTF addTarget:self action:@selector(didChangeText:) forControlEvents:(UIControlEventEditingChanged)];
    
}
-(void)setData:(id)data {
    config = (DDApisConfiguration *)data;
    self.titleLabel.text = config.identifier;
    [self.encSwitch setOn:config.is_encrypted];
    [self.sslSwitch setOn:config.is_ssl_pinning];
    [self.staticSwitch setOn:config.is_static_api];
    self.authTypeControl.selectedSegmentIndex = config.api_auth_type;
    self.endpointTF.text = config.end_point;
    [super setData:data];
}
-(void)didChangeSwitch:(UISwitch *)switchObj {
    if (switchObj == self.encSwitch) {
        config.is_encrypted = switchObj.isOn;
    }
    if (switchObj == self.sslSwitch) {
        config.is_ssl_pinning = switchObj.isOn;
    }
    if (switchObj == self.staticSwitch) {
        config.is_static_api = switchObj.isOn;
    }
}
-(void)didChangeText:(UITextField *)textField {
    config.end_point = textField.text;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didChangeAuthTypeControl:(id)sender {
    config.api_auth_type = self.authTypeControl.selectedSegmentIndex;
}
@end
