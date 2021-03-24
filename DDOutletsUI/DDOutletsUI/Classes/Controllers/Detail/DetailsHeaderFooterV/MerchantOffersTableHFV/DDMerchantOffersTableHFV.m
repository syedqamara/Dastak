//
//  DDMerchantOffersTableHFV.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDMerchantOffersTableHFV.h"

@interface DDMerchantOffersTableHFV()

@end


@implementation DDMerchantOffersTableHFV

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
    self.lblSectionTitle.font = [UIFont DDMediumFont:15];
    self.lblSectionTitle.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
}

@end

