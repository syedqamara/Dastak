//
//  DDCategoryCVC.m
//  DDHomeUI
//
//  Created by Syed Qamar Abbas on 01/07/2020.
//

#import "DDCategoryCVC.h"
#import "DDHomeThemeManager.h"
#import "DDHomeSectionM.h"
@implementation DDCategoryCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.titleLabel.font = [UIFont DDMediumFont:14];
    self.titleLabel.textColor = HOME_THEME.text_black.colorValue;
}
-(void)setData:(id)data {
    DDHomeSectionListM *list = data;
    self.titleLabel.text = list.title;
   // self.bgView.backgroundColor = list.background_color.colorValue;
    [self.categoryImageView loadImageWithString:list.image_url forClass:self.class];
    [super setData:data];
}
@end
