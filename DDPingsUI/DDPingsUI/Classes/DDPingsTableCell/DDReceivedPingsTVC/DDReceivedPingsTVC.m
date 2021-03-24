//
//  DDReceivedPingsTVC.m
//  DDPingsUI
//
//  Created by Hafiz Aziz on 29/01/2020.
//

#import "DDReceivedPingsTVC.h"
#import "DDPingsThemeManager.h"
#import "DDPingsUIManager.h"
#import "UIImageView+DDImageLoading.h"




@implementation DDReceivedPingsTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.titleLabel.font = [UIFont DDBoldFont:17];
    self.titleLabel.textColor = DDPingsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.categoryLabel.font = [UIFont DDRegularFont:15];
    self.categoryLabel.textColor = DDPingsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.senderNameLabel.font = [UIFont DDRegularFont:15];
    self.senderNameLabel.textColor = DDPingsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.buttonContainerView.borderColor = DDPingsThemeManager.shared.selected_theme.border_grey_227.colorValue;
    self.buttonContainerView.layer.cornerRadius = 4.0;
    self.buttonContainerView.borderW = 1.0;
    self.mainContainerView.borderColor = DDPingsThemeManager.shared.selected_theme.border_grey_227.colorValue;
    self.mainContainerView.borderW = 1.0;
    self.mainContainerView.layer.cornerRadius = 4.0;
    [self.rejectButton setBackgroundColor:DDPingsThemeManager.shared.selected_theme.bg_white.colorValue];
    self.rejectButton.borderColor = DDPingsThemeManager.shared.selected_theme.border_grey_227.colorValue;
    [self.acceptButton setBackgroundColor:DDPingsThemeManager.shared.selected_theme.app_theme.colorValue];
    self.acceptButton.borderColor = DDPingsThemeManager.shared.selected_theme.border_theme.colorValue;
    self.rejectButton.borderW = 1.0;
    self.rejectButton.layer.cornerRadius = 9.0;
    self.acceptButton.layer.cornerRadius = 9.0;
    self.acceptButton.titleLabel.font = [UIFont DDMediumFont:15.0];
    self.rejectButton.titleLabel.font = [UIFont DDMediumFont:15.0];
    self.hotelImageView.layer.cornerRadius = 12.0;
    self.hotelImageView.borderW = 1.0;
    self.hotelImageView.borderColor = DDPingsThemeManager.shared.selected_theme.border_grey_227.colorValue;
    self.hotelImageView.clipsToBounds = YES;
    
}
-(void)setData:(id)data {
    self.cellModelData = (DDPingModel*)data;
    [self.hotelImageView sd_setImageWithURL:[NSURL URLWithString:self.cellModelData.logoUrl]];
    self.titleLabel.text = self.cellModelData.merchantName ? self.cellModelData.merchantName : @"" ;
    self.categoryLabel.text = self.cellModelData.offerName ? self.cellModelData.offerName : @"" ;
    self.senderNameLabel.text = [NSString stringWithFormat:@"%@",self.cellModelData.ping_info ? self.cellModelData.ping_info : nil];
    [self.acceptButton setTitle:[NSString stringWithFormat:@"%@",self.cellModelData.accept_button_text] forState:UIControlStateNormal];
    [self.rejectButton setTitle:[NSString stringWithFormat:@"%@",self.cellModelData.reject_title] forState:UIControlStateNormal];
    
    self.cellModelData.isAccepted ? (self.buttonContainerHeightConstraint.constant = 0 ) : (self.buttonContainerHeightConstraint.constant = 48);
    
    [super setData:data];
}
// MARK: - IBActions

-(IBAction)btnAccpetAction:(id)sender{
    [self callPingAcceptAPI];
    
}

-(IBAction)btnRejectAction:(id)sender {
    NSString *yesBtn = self.cellModelData.reject_button_text;
    if (yesBtn.length == 0) yesBtn = @"Yes";
    NSArray *btns = @[CANCEL, yesBtn];
    __weak typeof(self) weakSelf = self;
    [DDAlertUtils showAlertWithTitle:self.cellModelData.reject_title subtitle:self.cellModelData.reject_message buttonNames:btns highlightedAt:1 onClick:^(int buttonIndex) {
        if (buttonIndex == 1) {
            [weakSelf callPingRejectAPI];
        }
    }];
    
}
 // MARK: - Accept the Ping
-(void)callPingAcceptAPI{
    DDPingRequestM *pingRequestM = [[DDPingRequestM alloc] init];
    pingRequestM.customer_id = DDUserManager.shared.currentUser.user_id;
    [pingRequestM.ping_ids addObject:[self.cellModelData.ping_id stringValue]];
    pingRequestM.status = @(1);
    if (!pingRequestM.isValidRequestForAcceptPingCall) {
        [DDAlertUtils showOkAlertWithTitle:nil subtitle:pingRequestM.validationErrorMessageForAcceptPing completion:nil];
    }else {
        [[DDPingsUIManager shared] callPingAcceptRejectAPI:pingRequestM andCompletion:^(DDPingApiModel * _Nonnull model, BOOL success) {
            if (success){
                self.callBackAfterPing(model);
            }
        }];
    }
}
// MARK: - Reject the Ping
-(void)callPingRejectAPI{
    DDPingRequestM *pingRequestM = [[DDPingRequestM alloc] init];
    pingRequestM.customer_id = DDUserManager.shared.currentUser.user_id;
    [pingRequestM.ping_ids addObject:[self.cellModelData.ping_id stringValue]];
    pingRequestM.status = @(2);
    if (!pingRequestM.isValidRequestForRejectPingCall) {
        [DDAlertUtils showOkAlertWithTitle:nil subtitle:pingRequestM.validationErrorMessageForRejectPing completion:nil];
    }else{
        [[DDPingsUIManager shared] callPingAcceptRejectAPI:pingRequestM andCompletion:^(DDPingApiModel * _Nonnull model, BOOL success) {
            if (success){
                self.callBackAfterPing(model);
            }
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
