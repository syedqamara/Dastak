//
//  DDMerchantSectionProductsHFV.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDMerchantSectionProductsHFV.h"

@interface DDMerchantSectionProductsHFV()

@end


@implementation DDMerchantSectionProductsHFV

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setData:(id)data {
    DDMerchantDetailSectionM *sectionModel = (DDMerchantDetailSectionM*)data;
    self.lblTitle.text = sectionModel.section_name;
    [super setData:data];
}

- (void)designUI {
    self.lblTitle.font = [UIFont DDBoldFont:20];
    self.lblTitle.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
}

@end

