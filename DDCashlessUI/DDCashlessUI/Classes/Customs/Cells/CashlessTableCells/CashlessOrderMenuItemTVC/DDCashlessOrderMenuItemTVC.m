//
//  DDCashlessOrderMenuItemTVC.m
//  DDCashlessUI
//
//  Created by Syed Qamar Abbas on 15/04/2020.
//

#import "DDCashlessOrderMenuItemTVC.h"
#import "DDCashlessThemeManager.h"
@implementation DDCashlessOrderMenuItemTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setData:(id)data {
    DDOrderItems *item = data;
    self.itemTitleLabel.text = item.name;
    self.itemPriceLabel.text = item.sub_total;
    self.optionTitleLabel.text = [item selectedOptionNames];
    self.optionPriceLabel.text = [item selectedOptionPrice];
    [self.itemImageView loadImageWithString:item.imageURL forClass:self.class];
    [super setData:data];
}
-(void)designUI {
    self.optionPriceLabel.numberOfLines = 0;
    self.optionTitleLabel.numberOfLines = 0;
    self.itemTitleLabel.textColor = CASHLESS_THEME.text_black_40.colorValue;
    self.itemPriceLabel.textColor = CASHLESS_THEME.text_black_40.colorValue;
    self.optionPriceLabel.textColor = CASHLESS_THEME.text_black_40.colorValue;
    self.optionTitleLabel.textColor = CASHLESS_THEME.text_black_40.colorValue;
    
    self.itemTitleLabel.font = [UIFont DDBoldFont:15];
    self.itemPriceLabel.font = [UIFont DDRegularFont:15];
    self.optionPriceLabel.font = [UIFont DDRegularFont:15];
    self.optionTitleLabel.font = [UIFont DDRegularFont:15];
    
    self.separatorView.backgroundColor = CASHLESS_THEME.bg_grey_199.colorValue;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
