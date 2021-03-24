//
//  DDRedemptionTVC.m
//  DDRedemptionsUI
//
//  Created by Hafiz Aziz on 25/02/2020.
//

#import "DDRedemptionTVC.h"
#import "DDRedemptionsThemeManager.h"
#import <DDAuth/DDAuth.h>
#import <DDSocial/DDSocial.h>

@interface DDRedemptionTVC(){
    DDRedemptionsData *redemptionData;
}
@end
@implementation DDRedemptionTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)designUI{
    
    self.logo_imgView.layer.cornerRadius = 12.0;
    self.logo_imgView.borderW = 1.0;
    self.logo_imgView.borderColor = DDRedemptionsThemeManager.shared.selected_theme.border_grey_227.colorValue;
    self.logo_imgView.clipsToBounds = YES;
    self.iconImageContainerView.layer.cornerRadius = 8.0;
    self.iconImageContainerView.clipsToBounds = YES;
    self.icon_imgView.layer.cornerRadius = 8.0;
    self.icon_imgView.clipsToBounds = YES;
    self.btnShare.layer.cornerRadius = 9.0;
    self.btnShare.titleLabel.font = [UIFont DDMediumFont:15.0];
    [self.btnShare setBackgroundColor:DDRedemptionsThemeManager.shared.selected_theme.app_theme.colorValue];
    self.btnShare.titleLabel.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_white.colorValue;
    self.title_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black.colorValue;
    self.title_label.font = [UIFont DDBoldFont:17];
    self.category_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black.colorValue;
    self.category_label.font = [UIFont DDRegularFont:15];
    self.category_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black.colorValue;
    self.dateTime_label.font = [UIFont DDRegularFont:11];
    self.dateTime_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.saving_label.font = [UIFont DDRegularFont:13];
    self.saving_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black.colorValue;
    self.reference_label.font = [UIFont DDRegularFont:13];
    self.reference_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black.colorValue;
    self.name_label.font = [UIFont DDRegularFont:13];
    self.name_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black.colorValue;
}
-(void)setData:(id)data{
    redemptionData = (DDRedemptionsData *)data;
    self.title_label.text = redemptionData.merchant;
    self.category_label.text = redemptionData.category;
    NSDateComponents *dc = [DDExtraUtil getCalendarCopmonetFromLocale:redemptionData.date :@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDateFormatter *df = [DDExtraUtil getLocaleDateFormater:@"dd/MM/yyyy '-' HH:mm"];
    
    self.dateTime_label.text = [NSString stringWithFormat:@"%@",[df stringFromDate:dc.date]] ;
    self.reference_label.text = [NSString stringWithFormat:@"Reference:%@".localized, redemptionData.code ];
    self.name_label.text = [NSString stringWithFormat:@"By:%@".localized, redemptionData.redeemed_by];
    [self.logo_imgView loadImageWithString:redemptionData.logo_url forClass:self.class];
    [self.icon_imgView loadImageWithString:[redemptionData getCategoryIcon_url] forClass:self.class];
    [super setData:data];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[DDExtraUtil convertString:[NSString stringWithFormat:@"Savings %@ %.0f".localized,[DDUserManager shared].currentUser.currency,redemptionData.savings.floatValue] toFont:[UIFont DDRegularFont:13] toColor:DDRedemptionsThemeManager.shared.selected_theme.text_black.colorValue]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont DDBoldFont:13] range:NSMakeRange(8, attributedString.length - 8)];
    self.saving_label.attributedText = attributedString;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)shareBtnAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    NSArray *dataSource = @[Facebook, WhatsApp];
    [DDAlertUtils showCancelActionSheetWithTitle:nil message:nil buttonTexts:dataSource completion:^(int index) {
        NSString *title = [dataSource objectAtIndex:index];
        DDSocialPlatform *platform = [DDSocialPlatforms platformFromTitle:title];
        [weakSelf shareOnPlatform:platform];
    }];
}

-(void)shareOnPlatform:(DDSocialPlatform*)platform {
    DDSocialShareContent *content = [DDSocialShareContent new];
    
    NSString *shareTxt = [DDSocialManager.shared getShareText:DDShareRedemptionSaving text:[NSString stringWithFormat:@"%@ %@",DDUserManager.shared.currentUser.currency,redemptionData.savings] merchantNameInCasePostRedemption:[NSString stringWithFormat:@"%@", redemptionData.outlet]];
    if(NSString.isCantoneseLanguage){
        shareTxt = [NSString stringWithFormat:@"I've saved approx. %@ at %@".localized,redemptionData.outlet,[NSString stringWithFormat:@"%@ %@",DDUserManager.shared.currentUser.currency, redemptionData.savings]];
    }
    
    NSString *shareURL =
      [NSString stringWithFormat:DDCAppConfigManager.shared.api_config.MERCHANT_SHARE_DETAIL_URL,redemptionData.merchant_id,redemptionData.outlet_id,NSString.deviceLanguage];

    content.text = shareTxt;
    content.url = shareURL;
    
    [DDSocialManager.shared shareContent:content from:UIApplication.topMostController onPlatfrom:platform withCompletionCallback:^(BOOL status, NSString * _Nullable text) {
        if (!status) {
            [DDAlertUtils showOkAlertWithTitle:text subtitle:nil completion:nil];
        }
    }];
}

@end



