//
//  DDAmenitiesDetailTVC.m
//  DDOutletsUI
//
//  Created by Hafiz Aziz on 10/03/2020.
//

#import "DDAmenitiesDetailTVC.h"
#import "DDOutletsThemeManager.h"
@implementation DDAmenitiesDetailTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI{
    self.sepratorView.backgroundColor = DDOutletsThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.title_label.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.title_label.font = [UIFont DDRegularFont:15];
}
-(void)setData:(id)data{
    DDMerchantAttributesM *obj = (DDMerchantAttributesM*)data;
    self.title_label.text = obj.name;
    [self.img_View loadTemplateImageWithString:obj.image_url forClass:self.class];
    self.img_View.tintColor = DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue;
    [super setData:data];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
