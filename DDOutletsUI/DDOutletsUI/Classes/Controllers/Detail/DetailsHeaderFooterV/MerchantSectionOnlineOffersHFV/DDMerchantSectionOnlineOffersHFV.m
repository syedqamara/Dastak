//
//  DDMerchantSectionOnlineOffersHFV.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 24/03/2020.
//

#import "DDMerchantSectionOnlineOffersHFV.h"


@implementation DDMerchantSectionOnlineOffersHFV

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setData:(id)data {
    DDMerchantDetailSectionM *sectionModel = (DDMerchantDetailSectionM*)data;
    self.lblSectionTitle.text = sectionModel.section_name;
    [self.btnSeeAll setTitle:sectionModel.expandable_button_text forState:UIControlStateNormal];
    
    [super setData:data];
}

- (void)designUI {
    self.lblSectionTitle.font = [UIFont DDBoldFont:15];
    self.lblSectionTitle.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    [self.btnSeeAll setTitle:@"See All".localized forState:UIControlStateNormal];
    self.btnSeeAll.titleLabel.font = [UIFont DDBoldFont:17];
    [self.btnSeeAll setTitleColor:DDOutletsThemeManager.shared.selected_theme.app_theme.colorValue forState:UIControlStateNormal];
    self.liveView.backgroundColor = DDOutletsThemeManager.shared.selected_theme.border_grey_199.colorValue;
}

- (IBAction)seeAllAction:(id)sender {
    self.callBackSeeAll();
}

@end

