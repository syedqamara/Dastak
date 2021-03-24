//
//  DDMDProductTVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 20/03/2020.
//

#import "DDMDProductTVC.h"
#import "DDOutletsThemeManager.h"


@interface DDMDProductTVC ()  {
    
}

@end

@implementation DDMDProductTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lineView.hidden =  YES;
}

-(void)designUI{
    self.lblOfferTitle.textColor = DDOutletsThemeManager.shared.selected_theme.text_white.colorValue;
    self.lblOfferTitle.font = [UIFont DDBoldFont:20];
    self.imgView.cornerR = 6;
    self.lineView.backgroundColor = DDOutletsThemeManager.shared.selected_theme.border_grey_199.colorValue;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

-(void)setData:(id)data{
    DDProfileSectionListM *product = (DDProfileSectionListM *)data;
    self.lblOfferTitle.text = product.title;
    [self.imgView loadImageWithString:product.image_url forClass:self.class];
    [super setData:data];
}

@end
