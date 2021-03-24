//
//  DDCustomiseOptionCell.m
//  The Entertainer
//
//  Created by apple on 5/31/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import "DDCustomiseOptionCell.h"
#import "DDBasket.h"
@interface DDCustomiseOptionCell()

@end

@implementation DDCustomiseOptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setBorderWidth:1 andBorderColor:UIColor.darkGrayColor];
    // Initialization code
}

- (void)setupData
{
    _nameLabel.text = self.optionItem.title;
    _priceLabel.text = [self.optionItem optionPriceWithPostString:[NSString stringWithFormat:@"%@",DDBasket.shared.currentOrder.merchant.outletCurrency]];
    
    self.isSelected = self.optionItem.is_selected.boolValue;
    [self designUI];
}
-(void)designUI {
    _checkMarkView.clipsToBounds = YES;
    _priceLabel.font = [UIFont DDRegularFont:15.0];
    _nameLabel.font = [UIFont DDRegularFont:15.0];
    [_checkMarkView setHidden:NO];
    _checkMarkView.layer.cornerRadius = _checkMarkView.frame.size.height/2;
    
}
-(void)setBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor *)borderColor{
    
//    [_checkMarkView.layer setBorderWidth:borderWidth];
//    [_checkMarkView.layer setBorderColor:borderColor.CGColor];
}

-(void)setProductName:(NSString *)productName {
    _nameLabel.text = productName;
}
-(void)setProductPrice:(NSString *)productPrice {
    [self setPriceWithText:productPrice];
}
-(void)setPriceWithText:(NSString *)productPrice {
    if (_type == DDCustomiseTypeAdOns) {
        _priceLabel.text = @"Free";
    }else {
        _priceLabel.text = productPrice;
    }
    
}
- (void)setIsSelected:(BOOL)isSelected {
    
    if (isSelected) {
        if (!_allowMultipleSelection) {
            self.checkMarkImageView.image = [NSBundle loadImageFromResourceBundleGIF:self.class imageName:@"cashless_radio"];
        } else {
            self.checkMarkImageView.image = [NSBundle loadImageFromResourceBundleGIF:self.class imageName:@"cashless_check"];
        }
    }else {
        self.checkMarkImageView.image = [NSBundle loadImageFromResourceBundleGIF:self.class imageName:@"cashless_uncheck"];
    }
    if (isSelected) {
        _checkMarkView.backgroundColor = UIColor.whiteColor;
    }else {
        _checkMarkView.backgroundColor = UIColor.clearColor;
    }
}
- (IBAction)didTapCheckButton:(id)sender {
    BOOL isAdded = (_checkMarkView.backgroundColor == UIColor.clearColor);
    DDCustomiseOption actionOption = DDCustomiseOptionAdd;
    if (!isAdded) {
        actionOption = DDCustomiseOptionRemove;
    }
    [self.option addItem:self.optionItem andStatus:isAdded];
    self.option.selectionMissing = @(0);
    self.isSelected = isAdded;
    if (_delegate != nil && [_delegate respondsToSelector:@selector(cellSelectedTheCustomizationOption:withType:atIndexPath:withSubItem:isMultipleSelectionAllowed:)]) {
        [_delegate cellSelectedTheCustomizationOption:actionOption withType:actionOption atIndexPath:_indexPath withSubItem:_optionItem isMultipleSelectionAllowed:self.allowMultipleSelection];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
