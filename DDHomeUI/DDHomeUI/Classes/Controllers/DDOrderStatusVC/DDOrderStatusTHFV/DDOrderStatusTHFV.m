//
//  DDOrderStatusTHFV.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/07/2020.
//

#import "DDOrderStatusTHFV.h"
#import "DDHomeThemeManager.h"
#import "DDOrderStatusSectionM.h"
@implementation DDOrderStatusTHFV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)designUI {
    self.titleLabel.font = [UIFont DDRegularFont:13];
    self.subtitleLabel.font = [UIFont DDSemiBoldFont:17];
    self.statusLabel.font = [UIFont DDMediumFont:15];
    self.titleLabel.textColor = HOME_THEME.text_grey_111.colorValue;
    self.subtitleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    [self.chartView setHoleRadiusPrecent:0.9];
    [self.chartView setUserInteractionEnabled:NO];
    self.containerView.backgroundColor = HOME_THEME.text_grey_238.colorValue;
    CGAffineTransform transform =  CGAffineTransformMakeRotation(-M_PI/2);
    self.chartView.transform = transform;
}
-(void)setData:(id)data {
    DDOrderStatusSectionM *sectionObj = data;
    
    self.titleLabel.text = sectionObj.title;
    self.subtitleLabel.text = sectionObj.sub_title;
    self.statusLabel.text = sectionObj.status_title;
    self.statusLabel.textColor = sectionObj.status_title_color.colorValue;
    [self.centerImageView loadImageWithString:sectionObj.image_url forClass:self.class];
    [super setData:data];
    [self.chartView setChartValues:sectionObj.charts animation:YES options:(VBPieChartAnimationFanAll)];
}
@end
