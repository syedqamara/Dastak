//
//  DDSwipeRedemptionTVC.m
//  DDRedemptionsUI
//
//  Created by Syed Qamar Abbas on 13/03/2020.
//

#import "DDSwipeRedemptionTVC.h"
#import "DDRedemptionsThemeManager.h"

@interface DDSwipeRedemptionTVC ()
{
    NSURL *merchantURL;
    DDMerchantOffersLocalDataM *dataModel;
}
@end

@implementation DDSwipeRedemptionTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(id)data {
    dataModel = (DDMerchantOffersLocalDataM*)data;
    self.subTitleLabel.text = @"";
    [self.subTitleLabel setHidden:YES];
    [super setData:data];
}

-(void)designUI {
    self.titleLabel.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.subTitleLabel.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.swipeContainerView.backgroundColor = [DDRedemptionsThemeManager.shared.selected_theme.app_theme.colorValue colorWithAlphaComponent:0.4];
    self.swipeContainerView.sliderColor = DDRedemptionsThemeManager.shared.selected_theme.app_theme.colorValue;
    self.swipeContainerView.text = @"Swipe to redeem".localized;
    self.swipeContainerView.image = [[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icSSideRight"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.swipeContainerView.layer.cornerRadius = 4;
    self.swipeContainerView.shouldAnimateAlpha = NO;
    self.titleLabel.font = [UIFont DDRegularFont:15];
    self.subTitleLabel.font = [UIFont DDBoldFont:34];
    self.swipeContainerView.font = [UIFont DDBoldFont:17];
    [self.swipeContainerView resetAnimation];
    self.swipeContainerView.delegate = self;
    
    [self setPromoCodeMessage:dataModel];
}
-(void)didSwipedCompletely {
    [self didActionCompleted];
    [self.swipeContainerView resetAnimation];
}
-(void)didCancelSwipe {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)didActionCompleted{
    if (![UIApplication isInternetConnected]) {
        [DDAlertUtils showOkAlertWithTitle:@"No Internet connection" subtitle:@"You need to be online to redeem this offer. Please check your Internet connection and try again." completion:nil];
        return;
    }
    if (![[DDLocationsManager shared] isLocationServicesEnable]){
        [[DDLocationsManager shared] showSettingAlert:^(bool isSuccess) {}];
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didRedemptionActionPerformed::)]) {
        [self.delegate didRedemptionActionPerformed:nil:DDRedemptionTypeSwipe];
    }
}

-(void) setPromoCodeMessage: (DDMerchantOffersLocalDataM*)data {
    if (data.offerToDisplay.is_promo_code_offer != nil && [data.offerToDisplay.is_promo_code_offer boolValue]){
        
        NSString *messageString = [NSString stringWithFormat:@"%@ %@", data.merchant.offer_instruction_message,data.offerToDisplay.name].localized;
        NSString *urlSubString = [messageString getURLSubString];
        if (urlSubString == nil) {
            urlSubString = @"";
        }
        merchantURL = [urlSubString getUrl];
        NSString *urlHost = merchantURL.host;
        if (urlHost == nil) {
            urlHost = @"";
        }
        messageString = [messageString stringByReplacingOccurrencesOfString:urlSubString withString:urlHost];
        messageString = [messageString stringByReplacingOccurrencesOfString:@"<a>" withString:@" "];
        messageString = [messageString stringByReplacingOccurrencesOfString:@"</a>" withString:@" "];
        
        NSRange range;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnLink:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [self.titleLabel addGestureRecognizer:tapGestureRecognizer];
        
        range = [messageString rangeOfString:urlHost];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:messageString attributes:nil];
        NSDictionary *linkAttributes = @{ NSForegroundColorAttributeName : DDRedemptionsThemeManager.shared.selected_theme.text_theme.colorValue,NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle) };
        [attributedString setAttributes:linkAttributes range:range];
        self.titleLabel.attributedText = attributedString;
        self.titleLabel.userInteractionEnabled = YES;
    }
}

-(void) tapOnLink:(UITapGestureRecognizer *)tapGR{
    if (tapGR.state == UIGestureRecognizerStateEnded)
    {
        [[DDWebManager shared] openURL:merchantURL.absoluteString title:dataModel.merchant.name onController:[UIApplication topMostController]];
    }
}

@end
