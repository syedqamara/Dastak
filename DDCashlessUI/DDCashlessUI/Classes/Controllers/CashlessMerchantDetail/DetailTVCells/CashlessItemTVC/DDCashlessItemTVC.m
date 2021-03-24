//
//  DDCashlessItemTVC.m
//  DDCashlessUI
//
//  Created by Syed Qamar Abbas on 16/03/2020.
//

#import "DDCashlessItemTVC.h"
#import "DDCashlessThemeManager.h"
#import "DDBasket.h"

@interface DDCashlessItemTVC() {
    DDCashlessItemM *item;
}

@end

@implementation DDCashlessItemTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)designUI {
    self.backgroundColor = DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue;
    self.titleLabel.font = [UIFont DDMediumFont:15];
    self.titleLabel.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.descriptionLabel.font = [UIFont DDRegularFont:13];
    self.descriptionLabel.textColor = DDCashlessThemeManager.shared.selected_theme.text_grey_199.colorValue;
    
    self.priceLabel.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.itemCountLabel.textColor = DDCashlessThemeManager.shared.selected_theme.app_theme.colorValue;
    //self.minusLabel.textColor = DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue;
    //self.plusLabel.textColor = DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue;
    self.minusLabel.font = [UIFont DDBoldFont:30];
    self.plusLabel.font = [UIFont DDBoldFont:30];
    self.itemCountLabel.font = [UIFont DDBoldFont:20];
    self.priceLabel.font = [UIFont DDBoldFont:15];
    self.actionsContainerView.layer.cornerRadius = 5;
    self.actionsContainerView.clipsToBounds = YES;
    self.actionsContainerView.layer.borderWidth = 1;
    self.actionsContainerView.layer.borderColor = DDCashlessThemeManager.shared.selected_theme.app_theme.colorValue.CGColor;
    self.actionsContainerView.backgroundColor = UIColor.clearColor;
    //self.minusContainerView.backgroundColor = DDCashlessThemeManager.shared.selected_theme.app_theme.colorValue;
    //self.plusContainerView.backgroundColor = DDCashlessThemeManager.shared.selected_theme.app_theme.colorValue;
    
}

-(void)setData:(id)data {
    item = (DDCashlessItemM *)data;
    [self.itemImageView loadImageWithString:item.itemImageURL forClass:self.class];
    self.titleLabel.text = item.itemName;
    self.descriptionLabel.text = item.itemDescription;
    self.priceLabel.text = item.priceWithCurrency;
    NSInteger count = [DDBasket.shared.currentOrder countOfItemInBasket:item];
    self.itemCountLabel.text = [NSString stringWithFormat:@"%ld",count];
    
    [super setData:data];
    
    self.minusContainerView.borderColor = DDCashlessThemeManager.shared.selected_theme.app_theme.colorValue;
    self.plusContainerView.borderColor = DDCashlessThemeManager.shared.selected_theme.app_theme.colorValue;

    if (count==0) {
        self.minusContainerView.backgroundColor = DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue;
        self.plusContainerView.backgroundColor = DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue;
        self.minusLabel.textColor = DDCashlessThemeManager.shared.selected_theme.text_theme.colorValue;
        self.plusLabel.textColor = DDCashlessThemeManager.shared.selected_theme.text_theme.colorValue;
        self.minusContainerView.borderW = 1;
        self.plusContainerView.borderW = 1;
    }
    else {
        self.minusContainerView.backgroundColor = DDCashlessThemeManager.shared.selected_theme.app_theme.colorValue;
        self.plusContainerView.backgroundColor = DDCashlessThemeManager.shared.selected_theme.app_theme.colorValue;
        self.minusLabel.textColor = DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue;
        self.plusLabel.textColor = DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue;
        self.minusContainerView.borderW = 0;
        self.plusContainerView.borderW = 0;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapMinusButton:(id)sender {
    if (self.delegate != nil) {
        [self.delegate didTapRemoveItemButton:item fromCell:self];
    }
}
-(void)didTapPlusButton:(id)sender {
    if (self.delegate != nil) {
        [self.delegate didTapAddItemButton:item fromCell:self];
    }
}
@end
