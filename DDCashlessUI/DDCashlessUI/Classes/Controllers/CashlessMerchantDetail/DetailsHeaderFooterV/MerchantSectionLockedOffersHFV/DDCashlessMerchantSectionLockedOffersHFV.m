//
//  DDCashlessMerchantSectionLockedOffersHFV.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDCashlessMerchantSectionLockedOffersHFV.h"

@interface DDCashlessMerchantSectionLockedOffersHFV()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property (weak, nonatomic) IBOutlet UIImageView *accessoryImg;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@end


@implementation DDCashlessMerchantSectionLockedOffersHFV

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setData:(id)data {
    DDMerchantDetailSectionM *sectionModel = (DDMerchantDetailSectionM*)data;
    self.titleLbl.text = sectionModel.section_name;
    self.detailLbl.text = sectionModel.section_subtitle;
    [self.logoImage loadImageWithString:sectionModel.section_icon forClass:self.class];
    [self.accessoryImg setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icArrowRight"]];
    [super setData:data];
}

-(void)designUI {
    self.containerView.layer.cornerRadius = 12;
    self.titleLbl.font = [UIFont DDBoldFont:15];
    self.detailTextLabel.font = [UIFont DDMediumFont:13];
    self.detailLbl.textColor = DDOutletsThemeManager.shared.selected_theme.text_theme.colorValue;
    self.containerView.backgroundColor = [DDOutletsThemeManager.shared.selected_theme.app_theme.colorValue colorWithAlphaComponent:0.1];
    self.containerView.cornerR = 12;
    self.lineView.backgroundColor = DDOutletsThemeManager.shared.selected_theme.border_grey_199.colorValue;
}

-(IBAction)btnShowAllAction:(id)sender{
    self.callBackShowAllLlockeOffers();
}

@end

