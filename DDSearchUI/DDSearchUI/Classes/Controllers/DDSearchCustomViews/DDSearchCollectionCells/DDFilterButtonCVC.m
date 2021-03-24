//
//  DDFilterButtonCVC.m
//  DDSearchUI
//
//  Created by Syed Qamar Abbas on 20/07/2020.
//

#import "DDFilterButtonCVC.h"
#import "DDFiltersApiM.h"
#import "DDSearchUIThemeManager.h"
@implementation DDFilterButtonCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.titleLabel.font = [UIFont DDSemiBoldFont:17];
    self.containerView.cornerR = 6;
    [self.containerView setClipsToBounds:YES];
    self.containerView.borderW = 1;
}
-(void)setData:(id)data {
    DDFilterSectionListM *rowM = data;
    self.titleLabel.text = rowM.title;
    if (rowM.isSelected) {
        self.containerView.borderColor = SEARCH_THEME.app_theme.colorValue;
        self.titleLabel.textColor = SEARCH_THEME.text_white.colorValue;
        self.containerView.backgroundColor = SEARCH_THEME.app_theme.colorValue;
    }else {
        self.containerView.borderColor = SEARCH_THEME.bg_grey_199.colorValue;
        self.titleLabel.textColor = SEARCH_THEME.text_black_40.colorValue;
        self.containerView.backgroundColor = SEARCH_THEME.bg_white.colorValue;
    }
    [super setData:data];
}
@end
