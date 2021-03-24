//
//  DDWelcomePageCVC.m
//  DDAuthUI
//
//  Created by Syed Qamar Abbas on 14/06/2020.
//

#import "DDWelcomePageCVC.h"
#import "DDUI.h"

@implementation DDWelcomePageCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.titleLabel.textColor = THEME.text_white.colorValue;
    self.titleLabel.font = [UIFont DDSemiBoldFont:28];
    self.subtitleLabel.textColor = THEME.text_white.colorValue;
    self.subtitleLabel.font = [UIFont DDRegularFont:17];
}
-(void)setData:(id)data {
    [super setData:data];
    DDGeneralVM *model = data;
    self.titleLabel.text = model.title;
    self.subtitleLabel.text = model.sub_title;
}
@end
