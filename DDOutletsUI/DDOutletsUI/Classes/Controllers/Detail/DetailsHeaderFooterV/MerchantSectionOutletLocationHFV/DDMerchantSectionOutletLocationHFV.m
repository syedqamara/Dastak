//
//  DDMerchantSectionOutletLocationHFV.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDMerchantSectionOutletLocationHFV.h"


@interface DDMerchantSectionOutletLocationHFV()

@end


@implementation DDMerchantSectionOutletLocationHFV

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setData:(id)data {
    DDOutletM *outlet = (DDOutletM*)data;
    self.lblOutletLocation.text = outlet.name;
    [super setData:data];
}

- (void)designUI {
    self.lblOutletLocation.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    [self.btnAreYouHere setTitleColor:DDOutletsThemeManager.shared.selected_theme.text_theme.colorValue forState:UIControlStateNormal];
    
    self.lblOutletLocation.font = [UIFont DDRegularFont:15];
    [self.btnAreYouHere.titleLabel setFont:[UIFont DDBoldFont:17]];
    [self.btnAreYouHere setTitle:@"Are you here?".localized forState:UIControlStateNormal];
    [self.btnAreYouHere setTitleColor:DDOutletsThemeManager.shared.selected_theme.text_theme.colorValue forState:(UIControlStateNormal)];
     self.separator.backgroundColor = DDOutletsThemeManager.shared.selected_theme.border_grey_199.colorValue;
    
    [super designUI];
}

- (IBAction)areYouHereAction:(UIButton*)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapAreYouHereButton)]) {
        [self.delegate didTapAreYouHereButton];
    }
}

@end

