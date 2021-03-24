//
//  DDPinlessRedemptionTVC.m
//  DDRedemptionsUI
//
//  Created by Syed Qamar Abbas on 13/03/2020.
//

#import "DDPinlessRedemptionTVC.h"
#import "DDRedemptionsThemeManager.h"
@implementation DDPinlessRedemptionTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(id)data {
     DDMerchantOffersLocalDataM *dataModel = (DDMerchantOffersLocalDataM*)data;
    
    self.titleLabel.text = @"Your Estimated Savings".localized;
    self.subTitleLabel.text = [NSString stringWithFormat:@"%@ %.0f", DDUserManager.shared.currentUser.currency, [dataModel.offerToDisplay.savings_estimate floatValue]];
    if (dataModel.offerToDisplay.show_savings != nil && ![dataModel.offerToDisplay.show_savings boolValue]) {
        [self.titleLabel setHidden:YES];
        [self.subTitleLabel setHidden:YES];
    }
}

-(void)designUI {
    self.titleLabel.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.subTitleLabel.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
    [self.redeemButton setTitleColor:DDRedemptionsThemeManager.shared.selected_theme.text_white.colorValue forState:(UIControlStateNormal)];
    self.redeemButton.backgroundColor = DDRedemptionsThemeManager.shared.selected_theme.app_theme.colorValue;
    
    self.titleLabel.font = [UIFont DDRegularFont:15];
    self.subTitleLabel.font = [UIFont DDBoldFont:34];
    self.redeemButton.titleLabel.font = [UIFont DDBoldFont:17];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didButtonTap:(id)sender {
    [self didActionCompleted];
}

- (void)didActionCompleted{
    if (![UIApplication isInternetConnected]){
        [DDAlertUtils showOkAlertWithTitle:nil subtitle:@"No Internet connection" completion:nil];
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didRedemptionActionPerformed::)]) {
        [self.delegate didRedemptionActionPerformed:nil:DDRedemptionTypePinless];
    }
}

@end
