//
//  DDMerchantDetailAmenitiesCVC.m
//  DDOutletsUI
//
//  Created by Hafiz Aziz on 10/03/2020.
//

#import "DDMerchantDetailAmenitiesCVC.h"
#import "DDOutletsThemeManager.h"

@implementation DDMerchantDetailAmenitiesCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI{
    self.title_Label.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.title_Label.font = [UIFont DDRegularFont:13.0];
    self.backgroundColor = [UIColor greenColor];
}
- (void)setData:(id)data{
    DDMerchantAttributesM *obj = (DDMerchantAttributesM*)data;
    self.title_Label.text = obj.name;
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:obj.image_url]];
    [self.imgView loadTemplateImageWithString:obj.image_url forClass:self.class];
    self.imgView.tintColor = DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue;
}

@end
