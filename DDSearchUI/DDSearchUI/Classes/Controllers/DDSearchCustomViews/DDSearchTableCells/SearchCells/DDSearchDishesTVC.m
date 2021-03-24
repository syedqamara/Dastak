//
//  DDSearchDishesTVC.m
//  DDSearchUI
//
//  Created by Syed Qamar Abbas on 05/07/2020.
//

#import "DDSearchDishesTVC.h"
#import "DDSearchSectionM.h"
#import "DDSearchUIThemeManager.h"
@implementation DDSearchDishesTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.dishImageView.cornerR = 10;
    self.dishImageView.clipsToBounds = YES;
    self.outletNameLabel.textColor = SEARCH_THEME.text_grey_199.colorValue;
    self.priceLabel.textColor = SEARCH_THEME.text_black_40.colorValue;
    self.outletNameLabel.font = [UIFont DDRegularFont:15];
    self.priceLabel.font = [UIFont DDSemiBoldFont:15];
}
-(void)setData:(id)data {
    DDSearchSectionListM *list = data;
    self.nameLabel.attributedText = [list.title searchAttrWithFont:[UIFont DDRegularFont:17] andColor:SEARCH_THEME.text_black_40.colorValue searchText:list.search_text searchFont:[UIFont DDSemiBoldFont:17] andSearchColor:SEARCH_THEME.text_black_40.colorValue];
    self.outletNameLabel.text = list.sub_title;
    self.priceLabel.text = list.item_description;
    [self.dishImageView loadImageWithString:list.image_url forClass:self.class];
    [super setData:data];
}
@end
