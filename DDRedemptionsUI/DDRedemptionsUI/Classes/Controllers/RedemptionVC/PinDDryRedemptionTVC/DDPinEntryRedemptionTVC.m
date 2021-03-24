//
//  DDPinEntryRedemptionTVC.m
//  DDRedemptionsUI
//
//  Created by Syed Qamar Abbas on 13/03/2020.
//

#import "DDPinEntryRedemptionTVC.h"
#import "DDRedemptionsThemeManager.h"
#define DOT_TEXT @"●"

@interface DDPinEntryRedemptionTVC()<UITextFieldDelegate>

@end

@implementation DDPinEntryRedemptionTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textField.delegate = self;
    [self.textField setTintColor:UIColor.clearColor];
    [self.textField setKeyboardType:(UIKeyboardTypeNumberPad)];
    // Initialization code
}
-(void)setData:(id)data {
    [self shouldAddNewString:@""];
    DDMerchantOffersLocalDataM *dataModel = (DDMerchantOffersLocalDataM*)data;
    self.titleLabel.text = @"Your Estimated Savings".localized;
    self.subTitleLabel.text = [NSString stringWithFormat:@"%@ %.0f", DDUserManager.shared.currentUser.currency, [dataModel.offerToDisplay.savings_estimate floatValue]];
    if (dataModel.offerToDisplay.show_savings != nil && ![dataModel.offerToDisplay.show_savings boolValue]) {
        [self.titleLabel setHidden:YES];
        [self.subTitleLabel setHidden:YES];
    }
    self.pinEntryLabel.text = [NSString stringWithFormat:@"Please ask %@ to enter their Pin".localized, dataModel.merchant.name];
    [super setData:data];
}
-(void)designUI {
    self.titleLabel.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.subTitleLabel.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.pinEntryLabel.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.textField.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.textField.superview.backgroundColor = [DDRedemptionsThemeManager.shared.selected_theme.bg_grey_199.colorValue colorWithAlphaComponent:0.2];
    self.titleLabel.font = [UIFont DDRegularFont:15];
    self.subTitleLabel.font = [UIFont DDBoldFont:34];
    self.pinEntryLabel.font = [UIFont DDRegularFont:15];
    self.textField.font = [UIFont DDBoldFont:28];
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.code.length < 4 || [string isEqualToString:@""]) {
        return [self shouldAddNewString:string];
    }
    return NO;
}
-(BOOL)shouldAddNewString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        if (self.code.length > 0) {
            NSMutableString *s = [self.code substringToIndex:[self.code length] - 1].mutableCopy;
            self.code = s;
        }else {
            self.code = @"";
        }
    }else {
        self.code = [NSString stringWithFormat:@"%@%@",self.code,string];
    }
    NSMutableArray <NSString *>*arr = [NSMutableArray new];
    for (NSInteger index = 0; index < self.code.length; index++) {
        NSString *s = [self.code substringWithRange:NSMakeRange(index, 1)];
        [arr addObject:s];
    }
    NSInteger totalCodeCount = arr.count;
    for (NSInteger index = 0; index < 4 - totalCodeCount; index++) {
        [arr addObject:DOT_TEXT];
    }
    NSString *str = [arr componentsJoinedByString:@"   "];
    self.textField.text = str;
    if (self.code.length == 4) {
        [self endEditing:YES];
        [self didActionCompleted];
    }
    return NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)didActionCompleted{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didRedemptionActionPerformed::)]) {
        [self.delegate didRedemptionActionPerformed:self.code:DDRedemptionTypePinEntry];
        self.code = @"";
    }
}

@end
