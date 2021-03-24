//
//  DDDriverInfoTHFV.m
//  AppAuth
//
//  Created by Syed Qamar Abbas on 18/10/2020.
//

#import "DDDriverInfoTHFV.h"
#import "DDHomeThemeManager.h"
@interface DDDriverInfoTHFV() {
    DDOrderStatusSectionM *sectionInfo;
}


@end

@implementation DDDriverInfoTHFV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)designUI {
    self.titleLabel.font = [UIFont DDRegularFont:15];
    self.titleLabel.textColor = HOME_THEME.bg_grey_199.colorValue;
    self.driverNameLabel.font = [UIFont DDSemiBoldFont:17];
    self.driverNameLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.separatorView.backgroundColor = HOME_THEME.text_grey_238.colorValue;
}

-(void)setData:(id)data {
    sectionInfo = data;
    self.titleLabel.text = sectionInfo.title;
    self.driverNameLabel.text = sectionInfo.title;
    [self.driverImageView loadImageWithString:sectionInfo.image_url forClass:self.class];
}
- (IBAction)didTapCallDriver:(id)sender {
    [sectionInfo.phone_number makeCall];
    
}
@end
