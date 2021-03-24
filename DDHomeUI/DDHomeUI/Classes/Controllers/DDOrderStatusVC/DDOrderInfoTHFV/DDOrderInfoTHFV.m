//
//  DDOrderInfoTHFV.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/07/2020.
//

#import "DDOrderInfoTHFV.h"
#import "DDOrderStatusSectionM.h"
#import "DDHomeThemeManager.h"
@interface DDOrderInfoTHFV () {
    DDOrderStatusSectionM *sect;
}

@end

@implementation DDOrderInfoTHFV
-(void)designUI {
    self.container.backgroundColor = HOME_THEME.text_grey_238.colorValue;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setData:(id)data {
    sect = data;
    self.titleLabel.attributedText = [sect.sub_title tagBasedAttributesWithTagFont:[UIFont DDSemiBoldFont:13] andTagColor:HOME_THEME.text_black_40.colorValue andNormalFont:[UIFont DDRegularFont:13] andNormalColor:HOME_THEME.text_black_40.colorValue];
    [self.iconImageView loadImageWithString:sect.image_url forClass:self.class];
    [super setData:data];
}
@end
