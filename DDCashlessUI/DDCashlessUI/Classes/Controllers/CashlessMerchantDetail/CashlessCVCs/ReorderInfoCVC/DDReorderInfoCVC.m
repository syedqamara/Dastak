//
//  DDMerchantMenuItemCVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 05/03/2020.
//

#import "DDReorderInfoCVC.h"
#import <DDCommons/DDCommons.h>
#import "UIFont+DDFont.h"
#import "SDWebImage.h"
#import <DDModels/DDModels.h>
#import "DDCashlessThemeManager.h"
@implementation DDReorderInfoCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.nameLabel.font = [UIFont DDMediumFont:15];
    self.countLabel.font = [UIFont DDBoldFont:15];
    self.dateLabel.font = [UIFont DDRegularFont:11];
    self.reorderButton.titleLabel.font = [UIFont DDBoldFont:15];
    
    self.nameLabel.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.countLabel.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.dateLabel.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    [self.reorderButton setTitleColor:DDCashlessThemeManager.shared.selected_theme.app_theme.colorValue forState:(UIControlStateNormal)];
    self.countLabelContainerView.backgroundColor = DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue;
    self.backgroundColor = [DDCashlessThemeManager.shared.selected_theme.bg_grey_199.colorValue colorWithAlphaComponent:0.2];
    [self.layer setCornerRadius:8];
    [self.layer setMasksToBounds:YES];
    [super designUI];
}
-(void)setData:(id)data {
    DDOrderM *order = (DDOrderM *)data;
    self.nameLabel.text = order.item_name;
    self.countLabel.text = order.item_count.stringValue;
    self.dateLabel.text = order.reorderDate;
    [self.reorderButton setTitle:order.reorder_button_title forState:(UIControlStateNormal)];
    [super setData:data];
}

@end

