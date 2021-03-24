//
//  DDMerchantSectionOffersHFV.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDMerchantSectionOffersHFV.h"

@interface DDMerchantSectionOffersHFV()
{
    NSString *sectionId;
}
@end


@implementation DDMerchantSectionOffersHFV

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lblSectionTitle.text = @"";
    self.btnExpandCollaps.hidden = YES;
    self.imgVArrow.hidden = YES;
    self.imgVArrow.selected = YES;
}

- (void)setData:(id)data {
    DDMerchantDetailSectionM *sectionModel = (DDMerchantDetailSectionM*)data;
    self.lblSectionTitle.text = sectionModel.section_name;
    sectionId = sectionModel.identifier;
    if (sectionModel.is_expandable != nil && sectionModel.is_expandable.boolValue){
        self.btnExpandCollaps.hidden = NO;
        self.imgVArrow.hidden = NO;
    }else{
        self.btnExpandCollaps.hidden = YES;
        self.imgVArrow.hidden = YES;
    }
    [self.imgVArrow setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"arrowDown"] forState:UIControlStateNormal];
    [self.imgVArrow setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"arrowUp"] forState:UIControlStateSelected];
    
    [super setData:data];
}

- (void)designUI {
    self.lblSectionTitle.font = [UIFont DDBoldFont:20];
    self.lblSectionTitle.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
}

- (IBAction)arrowAction:(id)sender {
    self.imgVArrow.selected = !self.imgVArrow.selected;
    if ([self.delegate respondsToSelector:@selector(didTapExpandCollapsButtonFromOfferSection:)]){
        [self.delegate didTapExpandCollapsButtonFromOfferSection:sectionId];
    }
}

@end

