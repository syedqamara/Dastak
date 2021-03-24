//
//  DDItemsTVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 27/07/2020.
//

#import "DDItemsTVC.h"
#import "DDHomeThemeManager.h"
#import "DDBasketManager.h"
@interface DDItemsTVC() {
    DDMerchantDeliveryMenuItemM *item;
}

@end

@implementation DDItemsTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
-(void)designUI {
    self.stepper.buttonBackgroundColor = UIColor.whiteColor;
    self.stepper.labelBackgroundColor = [HOME_THEME.bg_grey_248.colorValue colorWithAlphaComponent:0.9];
    self.stepper.buttonTextColor = HOME_THEME.app_theme.colorValue;
    self.stepper.lineColor = HOME_THEME.app_theme.colorValue;
    self.stepper.labelTextColor = HOME_THEME.app_theme.colorValue;
    self.stepper.superview.cornerR = 4;
    [self.stepper.superview setClipsToBounds:YES];
    self.stepper.minimumValue = 0;
    self.stepper.superview.layer.borderWidth = 1;
    self.stepper.superview.layer.borderColor = HOME_THEME.app_theme.colorValue.CGColor;
    self.stepper.delegate = self;
    
    self.itemNameLabel.font = [UIFont DDSemiBoldFont:15];
    self.itemPriceLabel.font = [UIFont DDMediumFont:15];
    self.itemNameLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.itemPriceLabel.textColor = HOME_THEME.text_black_40.colorValue;
}
-(void)reloadInputViews {
    [self setData:item];
}
-(void)setData:(id)data {
    [super setData:data];
    item = data;
    self.itemNameLabel.text = item.name;
    self.itemDescLabel.attributedText = [item.detail_description tagBasedAttributesWithTagFont:[UIFont DDSemiBoldFont:13] andTagColor:HOME_THEME.text_grey_111.colorValue andNormalFont:[UIFont DDRegularFont:13] andNormalColor:HOME_THEME.text_grey_111.colorValue];
    if (item.orignalPriceWithCurrency != nil) {
        NSMutableAttributedString *attr = [NSMutableAttributedString.alloc initWithString:item.priceWithCurrency attributes:@{NSForegroundColorAttributeName: self.itemPriceLabel.textColor, NSFontAttributeName: self.itemPriceLabel.font}];
        NSMutableAttributedString *attrOrignal = item.orignalPriceWithCurrency;
        [attr appendAttributedString:attrOrignal];
        self.itemPriceLabel.text = nil;
        self.itemPriceLabel.attributedText = attr;
    }else {
        self.itemPriceLabel.text = item.priceWithCurrency;
    }
    
    [self.itemImageURL loadImageWithString:item.image_url forClass:self.class];
    self.stepper.minimumValue = 0;
    self.stepper.maximumValue = item.stockCount;
    self.stepper.shouldChangeOnButtonTap = NO;
    self.stepper.value = [DDBasketManager.shared countOfItem:item];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)didTapAddButton {
    if (self.delegate != nil) {
        [self.delegate didSelectItem:item withModificationType:(DDItemModificationAdd) forCell:self];
    }
}
-(void)didTapRemoveButton {
    if (self.delegate != nil) {
        [self.delegate didSelectItem:item withModificationType:(DDItemModificationRemove) forCell:self];
    }
}

@end
