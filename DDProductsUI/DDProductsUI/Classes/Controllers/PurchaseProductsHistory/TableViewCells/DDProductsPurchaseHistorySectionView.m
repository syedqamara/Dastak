//
//  DDProductsPurchaseHistorySectionView.m
//  DDProductsUI
//
//  Created by M.Jabbar on 26/03/2020.
//

#import "DDProductsPurchaseHistorySectionView.h"
#import <DDUI/DDUI.h>
#import <DDCommons/DDCommons.h>

@implementation DDProductsPurchaseHistorySectionView

-(void)setData:(id)data{
    
    self.sectionItem = (DDProductPurchaseSectionM*)data;

    self.contentView.backgroundColor = DDUIThemeManager.shared.selected_theme.bg_white.colorValue;
    
    self.titleLabel.font = [UIFont DDBoldFont:17];
    self.titleLabel.textColor =  [DDUIThemeManager shared].selected_theme.text_black_40.colorValue;
    UIImage *image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:self.sectionItem.collapsed ? @"productarrowDown" : @"productarrowUp"];
    [self.seeAllButton setImage:image forState:UIControlStateNormal];
    self.titleLabel.text = self.sectionItem.section_title;
    self.seperatorLine.backgroundColor = [DDUIThemeManager shared].selected_theme.separator_grey_199.colorValue;
    [self.seperatorLine setHidden: !self.sectionItem.collapsed];
}

@end
