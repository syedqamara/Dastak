//
//  DDMerchantMoreMenuTVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 24/03/2020.
//

#import "DDMerchantMoreMenuTVC.h"
#import "DDOutletsThemeManager.h"
@implementation DDMerchantMoreMenuTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI{
    self.sepratorView.backgroundColor = DDOutletsThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.title_label.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.title_label.font = [UIFont DDRegularFont:17];
}
-(void)setData:(id)data{
    DDTopMenuItem *obj = (DDTopMenuItem*)data;
    self.title_label.text = obj.title;
    [self.img_View sd_setImageWithURL:[NSURL URLWithString:obj.image_url]];
    self.img_View.tintColor = DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue;
    [super setData:data];
    
}


@end
