//
//  DDOrderItemTVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 01/08/2020.
//

#import "DDOrderItemTVC.h"
#import "DDHomeThemeManager.h"
@implementation DDOrderItemTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.itemNameLabel.font = [UIFont DDSemiBoldFont:15];
    self.itemPriceLabel.font = [UIFont DDRegularFont:15];
    self.adonsLabel.font = [UIFont DDSemiBoldFont:15];
    self.adonsNameLabel.font = [UIFont DDRegularFont:15];
    self.adonsPriceLabel.font = [UIFont DDRegularFont:15];
    
    self.itemNameLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.itemPriceLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.adonsLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.adonsNameLabel.textColor = HOME_THEME.text_grey_111.colorValue;
    self.adonsPriceLabel.textColor = HOME_THEME.text_black_40.colorValue;
    
    self.separatorView.backgroundColor = HOME_THEME.text_grey_238.colorValue;
}
-(void)setData:(id)data {
    [super setData:data];
    DDOrderStatusItemM *item = data;
    self.itemNameLabel.text = item.name;
    self.itemPriceLabel.text = item.price;
    self.adonsLabel.text = @"Add on:";
    [self.adonsLabel.superview.superview setHidden:item.options.count == 0];
    self.adonsNameLabel.text = [item combineNameWithSeparator:@"\n"];
    self.adonsPriceLabel.text = [item combinePriceWithSeparator:@"\n"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
