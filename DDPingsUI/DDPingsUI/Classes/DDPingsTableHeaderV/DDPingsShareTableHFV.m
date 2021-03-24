//
//  DDPingsShareTableHFV.m
//  DDPingsUI
//
//  Created by Zubair Ahmad on 26/03/2020.
//

#import "DDPingsShareTableHFV.h"

@interface DDPingsShareTableHFV()

@end


@implementation DDPingsShareTableHFV

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lblSectionTitle.text = @"";
}

- (void)setData:(id)data {
    NSString *name = (NSString*)data;
    self.lblSectionTitle.text = name;
    [super setData:data];
}

- (void)designUI {
    self.lblSectionTitle.font = [UIFont DDBoldFont:15];
    self.lblSectionTitle.textColor = DDPingsThemeManager.shared.selected_theme.text_black_40.colorValue;
}

@end

