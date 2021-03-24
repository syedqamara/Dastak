//
//  DDMerchantInfoTHFV.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 06/09/2020.
//

#import "DDMerchantInfoTHFV.h"
#import "DDMerchantInfoSectionM.h"
#import "DDHomeThemeManager.h"
@implementation DDMerchantInfoTHFV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)designUI {
    self.titleLabel.font = [UIFont DDSemiBoldFont:17];
    self.subTitleLabel.font = [UIFont DDRegularFont:15];
    self.titleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.subTitleLabel.textColor = HOME_THEME.text_black_40.colorValue;
}
-(void)setData:(id)data {
    [super setData:data];
    DDMerchantInfoSectionM *sect = data;
    self.titleLabel.text = sect.title;
    self.subTitleLabel.text = sect.sub_title;
    [self.subTitleLabel.superview setHidden:sect.sub_title.length == 0];
    [self.bottomSpaceView setHidden:sect.sub_title.length == 0];
    [self.sectionImageView loadImageWithString:sect.image_url forClass:self.class];
}
@end
