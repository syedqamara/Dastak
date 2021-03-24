//
//  DDSettingsTableViewCell.h
//  DDAccountsUI
//
//  Created by M.Jabbar on 12/02/2020.
//

#import <UIKit/UIKit.h>
#import "DDUIThemeTableViewCell.h"
#import "DDSettingsSectionListM.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDSettingsTableViewCell : DDUIThemeTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
