//
//  DDFilterCheckboxCell.m
//  DDSearchUI
//
//  Created by Syed Qamar Abbas on 20/07/2020.
//

#import "DDFilterCheckboxCell.h"
#import "DDSearchUIThemeManager.h"
#import "DDFiltersApiM.h"
@implementation DDFilterCheckboxCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    self.titleLabel.textColor = SEARCH_THEME.text_black.colorValue;
    self.separatorView.backgroundColor = [@"333333".colorValue colorWithAlphaComponent:0.2];
}
-(void)setData:(id)data {
    DDFilterSectionListM *list = data;
    self.titleLabel.text = list.title;
    if (list.isSelected) {
        self.titleLabel.font = [UIFont DDSemiBoldFont:15];
        [self.checkboxImageView loadImageWithString:@"checkbox.png" forClass:self.class];
    }else {
        self.titleLabel.font = [UIFont DDRegularFont:15];
        [self.checkboxImageView loadImageWithString:@"uncheckbox.png" forClass:self.class];
    }
    [super setData:data];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
