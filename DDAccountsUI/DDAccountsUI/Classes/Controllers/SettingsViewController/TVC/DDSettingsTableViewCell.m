//
//  DDSettingsTableViewCell.m
//  DDAccountsUI
//
//  Created by M.Jabbar on 12/02/2020.
//

#import "DDSettingsTableViewCell.h"
#import "DDAccountUIThemeManager.h"
#import "DDLocations.h"

@implementation DDSettingsTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)designUI{
    self.titleLabel.font = [UIFont DDMediumFont:17];
    
}
-(void)setData:(id)data{
    [super setData:data];
    DDSettingsSectionListM *item = (DDSettingsSectionListM*)data;
    self.titleLabel.placeHolder = item.is_dummy;
    self.titleLabel.text = item.title;
    self.accessoryType = (item.itemType != DDSettingsSectionListTypeSignOut && item.itemType != DDSettingsSectionListTypeLocation) ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    if (item.itemType == DDSettingsSectionListTypeLocation) {
        NSString *selectedLocation = [NSString stringWithFormat:@"(%@)",[DDLocationsManager shared].appLocation.name];
        NSMutableAttributedString *location = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",item.title ?: @"",selectedLocation]];
        [location addAttribute:NSFontAttributeName value:[UIFont DDMediumFont:17] forString:location.string];
        [location addAttribute:NSFontAttributeName value:[UIFont DDBoldFont:17] forString:selectedLocation];
        self.titleLabel.attributedText = location;
    }
    self.titleLabel.textColor = DDAccountUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.titleLabel.font = [UIFont DDMediumFont:17];
    if (item.itemType == DDSettingsSectionListTypeSignOut) {
        self.titleLabel.text = item.title;
        self.titleLabel.textColor = DDAccountUIThemeManager.shared.selected_theme.text_red_39.colorValue;
        self.titleLabel.font = [UIFont DDBoldFont:17];
    }
    [super setData:data];
}

@end
