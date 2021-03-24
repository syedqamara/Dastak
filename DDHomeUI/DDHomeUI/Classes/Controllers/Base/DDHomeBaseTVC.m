//
//  DDHomeBaseTVC.m
//  DDHomeUI
//
//  Created by Awais Shahid on 09/03/2020.
//

#import "DDHomeBaseTVC.h"
#import "DDHomeThemeManager.h"
#import "DDHomeSectionM.h"

@implementation DDHomeBaseTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    self.sectionTitleLbl.textColor = DDHomeThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.sectionTitleLbl.font = [UIFont DDBoldFont:20];
    if (self.separatorView != nil) {
        self.separatorView.backgroundColor = HOME_THEME.bg_grey_199.colorValue;
    }
}
-(void)setData:(id)data {
    DDHomeSectionM *section = data;
    if (section != nil && self.separatorView != nil) {
//        [self.separatorView setHidden:section.hideSeparator];
    }
}

@end
