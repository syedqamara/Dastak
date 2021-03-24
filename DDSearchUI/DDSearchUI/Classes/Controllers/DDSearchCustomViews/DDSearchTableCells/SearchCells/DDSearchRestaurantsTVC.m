//
//  DDSearchRestaurantsTVC.m
//  DDSearchUI
//
//  Created by Syed Qamar Abbas on 05/07/2020.
//

#import "DDSearchRestaurantsTVC.h"
#import "DDSearchSectionM.h"
#import "DDSearchUIThemeManager.h"
@implementation DDSearchRestaurantsTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)designUI {
    self.merchantImageView.cornerR = 10;
    self.merchantImageView.clipsToBounds = YES;
}
-(void)setData:(id)data {
    DDSearchSectionListM *list = data;
    self.merchantNameLabel.attributedText = [list.title searchAttrWithFont:[UIFont DDRegularFont:17] andColor:SEARCH_THEME.text_black_40.colorValue searchText:list.search_text searchFont:[UIFont DDSemiBoldFont:17] andSearchColor:SEARCH_THEME.text_black_40.colorValue];
    [self.merchantImageView loadImageWithString:list.image_url forClass:self.class];
    [super setData:data];
}

@end
