//
//  DDOfferDetailDaysValidityCVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 05/03/2020.
//

#import "DDCashlessOfferDetailDaysValidityCVC.h"
#import <DDCommons/DDCommons.h>
#import "UIFont+DDFont.h"
#import "SDWebImage.h"
#import <DDModels/DDModels.h>
#import "DDCashlessThemeManager.h"

@implementation DDCashlessOfferDetailDaysValidityCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cornerR = 3;
}
-(void)designUI {
    self.label.textColor = DDCashlessThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.label.font = [UIFont DDRegularFont:13];
    [super designUI];
}
-(void)setData:(id)data {
    DDMerchantOfferDayValidity *object = (DDMerchantOfferDayValidity*)data;
    self.label.backgroundColor = object.day_background_color.colorValue;
    self.label.textColor = object.day_text_color.colorValue;
    self.label.text = object.title;
    [super setData:data];
}
@end

