//
//  DDFilterSectionTHFV.m
//  DDSearchUI
//
//  Created by Syed Qamar Abbas on 20/07/2020.
//

#import "DDFilterSectionTHFV.h"
#import "DDSearchUIThemeManager.h"
@implementation DDFilterSectionTHFV
-(void)designUI {
    self.titleLabel.font = [UIFont DDSemiBoldFont:17];
    self.titleLabel.textColor = SEARCH_THEME.text_black_40.colorValue;
}
-(void)setData:(id)data {
    DDFilterSectionM *sectionM = data;
    self.titleLabel.text = sectionM.section_title;
    [super setData:data];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
