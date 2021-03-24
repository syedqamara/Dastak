//
//  DDSettingsSwitchTableViewCell.m
//  DDAccountsUI
//
//  Created by M.Jabbar on 12/02/2020.
//

#import "DDSettingsSwitchTableViewCell.h"
#import "DDAccountUIThemeManager.h"
#import "DDUserManager.h"

@implementation DDSettingsSwitchTableViewCell
@synthesize item;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)designUI{
    self.titleLabel.font = [UIFont DDMediumFont:17];
    self.titleLabel.textColor = DDAccountUIThemeManager.shared.selected_theme.text_black_40.colorValue;
}
-(void)setData:(id)data{
    [super setData:data];
    self.item = (DDSettingsSectionListM*)data;
//    self.titleLabel.placeHolder = item.is_dummy;
    self.titleLabel.text = item.title;
//    self.switchs.placeHolder = item.is_dummy;
    [self.switchs setOn:[DDUserManager shared].currentUser.push_notifications.boolValue animated:YES];
    [self.switchs setHidden:item.itemType != DDSettingsSectionListTypePushNotifications];
}
-(IBAction)switchButtonChanges:(UISwitch*)sender{
    self.callBackAfterSwitchStateChange(self.item, sender.isOn);
}
@end
