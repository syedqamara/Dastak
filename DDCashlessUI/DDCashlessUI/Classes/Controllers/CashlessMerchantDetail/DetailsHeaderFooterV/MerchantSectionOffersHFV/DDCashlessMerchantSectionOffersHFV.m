//
//  DDMerchantSectionOffersHFV.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDCashlessMerchantSectionOffersHFV.h"

@interface DDCashlessMerchantSectionOffersHFV() {
    
}
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UILabel *lblSectionTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgVArrow;

@end


@implementation DDCashlessMerchantSectionOffersHFV

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setData:(id)data {
    DDMerchantDetailSectionM *sectionModel = (DDMerchantDetailSectionM*)data;
    self.lblSectionTitle.text = sectionModel.section_name;
    if (sectionModel.is_expandable != nil && sectionModel.is_expandable.boolValue){
        self.imgVArrow.hidden = NO;
        self.separatorView.hidden = NO;
    }
    else {
        self.imgVArrow.hidden = YES;
        self.separatorView.hidden = YES;
    }
    
    [self.imgVArrow setHidden:!sectionModel.isCashlessOffers];
    self.imgVArrow.contentMode = UIViewContentModeCenter;
    [super setData:data];
    if (sectionModel.getType == DDMerchantSectionCashlessMenuItems) {
        self.lblSectionTitle.font = [UIFont DDBoldFont:17];
    }
    
    NSString *img = sectionModel.isExpanded ? @"arrowUp.png" : @"arrowDown.png";
    [self.imgVArrow loadImageWithString:img forClass:self.class];
}

- (void)designUI {
    self.lblSectionTitle.font = [UIFont DDBoldFont:20];
    self.lblSectionTitle.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
}

- (IBAction)arrowAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didTapExpandCollapsButtonFromOfferAtSection:)]){
           [self.delegate didTapExpandCollapsButtonFromOfferAtSection:self.tag];
    }
}

@end

