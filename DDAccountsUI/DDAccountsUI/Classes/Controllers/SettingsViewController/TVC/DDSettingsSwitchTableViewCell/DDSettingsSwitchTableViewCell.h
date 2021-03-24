//
//  DDSettingsSwitchTableViewCell.h
//  DDAccountsUI
//
//  Created by M.Jabbar on 12/02/2020.
//

#import <UIKit/UIKit.h>
#import "DDUIThemeTableViewCell.h"
#import "DDSettingsSectionListM.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDSettingsSwitchTableViewCell : DDUIThemeTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchs;
@property(nonatomic) DDSettingsSectionListM *item;
@property (nonatomic, copy) void (^callBackAfterSwitchStateChange)(DDSettingsSectionListM *item, BOOL switchState);

@end

NS_ASSUME_NONNULL_END
