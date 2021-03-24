//
//  DDTravelDestinationsTHFV.m
//  theDDERTAINER_Example
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDTravelDestinationsTHFV.h"

@interface DDTravelDestinationsTHFV()

@end


@implementation DDTravelDestinationsTHFV

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lblSectionTitle.text = @"";
    self.contentView.backgroundColor =  DDUIThemeManager.shared.selected_theme.bg_white.colorValue;
}

- (void)setData:(id)data {
    NSString *name = (NSString*)data;
    self.lblSectionTitle.text = name;
    [super setData:data];
}

- (void)designUI {
    self.lblSectionTitle.font = [UIFont DDMediumFont:15];
    self.lblSectionTitle.textColor = DDUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.bgView.backgroundColor = [DDUIThemeManager.shared.selected_theme.app_theme.colorValue colorWithAlphaComponent:0.1];
    self.contentView.backgroundColor =  DDUIThemeManager.shared.selected_theme.bg_white.colorValue;
}

@end

