//
//  DDMDOnlineOfferHistoryDetailTVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 24/03/2020.
//

#import "DDMDOnlineOfferHistoryDetailTVC.h"
#import "DDOutletsThemeManager.h"

@interface DDMDOnlineOfferHistoryDetailTVC () {
    DDRedemptionsData *redemption;
}
 
@end

@implementation DDMDOnlineOfferHistoryDetailTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI{
    self.lbl_title.textColor =  DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.lbl_Redeemed.textColor =  DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.lbl_Redeemed_Date.textColor =  DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.lbl_PromoCode.textColor =  DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.lbl_PromoCode_Number.textColor =  DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.lbl_title.font  = [UIFont DDBoldFont:17];
    self.lbl_Redeemed.font  = [UIFont DDRegularFont:15];
    self.lbl_Redeemed_Date.font  = [UIFont DDMediumFont:15];
    self.lbl_PromoCode.font  = [UIFont DDRegularFont:15];
    self.lbl_PromoCode_Number.font  = [UIFont DDMediumFont:15];
    
    self.lbl_Redeemed.text = @"Redeemed:".localized;
     self.lbl_PromoCode.text = @"Code:".localized;
    
    [self.btn_Copy setTitle:@"Copy".localized forState:UIControlStateNormal];
    [self.btn_Copy setTitleColor:DDOutletsThemeManager.shared.selected_theme.text_white.colorValue forState:UIControlStateNormal];
    self.btn_Copy.backgroundColor = DDOutletsThemeManager.shared.selected_theme.app_theme.colorValue;
    self.btn_Copy.cornerR = 9;
    
    self.imgV_logo.cornerR = 12;
    self.imgV_logo.borderColor = DDOutletsThemeManager.shared.selected_theme.border_grey_199.colorValue;
    self.imgV_logo.borderW  = 1;
    self.imgV_logo.clipsToBounds = YES;
    
    self.sepratorView.backgroundColor = DDOutletsThemeManager.shared.selected_theme.text_grey_199.colorValue;
}
-(void)setData:(id)data{
    redemption = (DDRedemptionsData *)data;
    
    [self.imgV_logo loadImageWithString:redemption.logo_url forClass:self.class];
    self.lbl_title.text = redemption.offer;
    if (redemption.offer != nil && redemption.offer.length > 0){
        self.lbl_title.text = redemption.offer;
        [self.lbl_title sizeToFit];
    }else if (redemption.outlet != nil && redemption.outlet.length > 0){
        self.lbl_title.text = redemption.outlet;
    }
    self.lbl_Redeemed_Date.text = redemption.date;
    self.lbl_PromoCode_Number.text = redemption.code;
    [super setData:data];
    
}

- (IBAction)didTapCopyButton:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = redemption.code;
    // show alert
}

@end
