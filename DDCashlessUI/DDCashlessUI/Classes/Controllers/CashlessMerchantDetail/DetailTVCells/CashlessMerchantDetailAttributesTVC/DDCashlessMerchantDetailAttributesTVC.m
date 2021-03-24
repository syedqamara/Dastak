//
//  DDMerchantDetailAttributesTVC.m
//  DDOutletsUI
//
//  Created by Hafiz Aziz on 12/03/2020.
//

#import "DDCashlessMerchantDetailAttributesTVC.h"
#import "DDCashlessThemeManager.h"

@implementation DDCashlessMerchantDetailAttributesTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)designUI{
    self.title_Label.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.title_Label.font = [UIFont DDBoldFont:15];
    self.description_Label.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.description_Label.font = [UIFont DDRegularFont:15];
}
- (void)setData:(id)data{
    DDMerchantDetailAttributesM *attrib = (DDMerchantDetailAttributesM*)data;
    self.title_Label.text = attrib.title;
    self.description_Label.text = attrib.value;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
