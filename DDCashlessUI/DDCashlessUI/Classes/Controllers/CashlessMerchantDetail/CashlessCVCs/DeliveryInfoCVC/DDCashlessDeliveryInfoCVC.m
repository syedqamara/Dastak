//
//  DDMerchantMenuItemCVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 05/03/2020.
//

#import "DDCashlessDeliveryInfoCVC.h"
#import <DDCommons/DDCommons.h>
#import "UIFont+DDFont.h"
#import "SDWebImage.h"
#import <DDModels/DDModels.h>
#import "DDCashlessThemeManager.h"
@implementation DDCashlessDeliveryInfoCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)designUI {
    self.subtitlelabel.font = [UIFont DDRegularFont:13];
    self.label.font = [UIFont DDMediumFont:13];
    self.subtitlelabel.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.label.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    [super designUI];
}

-(void)setData:(id)data {
    DDMerchantMenuButtonM* menu = (DDMerchantMenuButtonM*)data;
    self.subtitlelabel.text = menu.name;
    self.label.text = menu.value;
    [super setData:data];
}

@end

