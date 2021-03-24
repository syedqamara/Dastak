//
//  DDSentPingsTVC.m
//  DDPingsUI
//
//  Created by Hafiz Aziz on 29/01/2020.
//

#import "DDSentPingsTVC.h"
#import "DDPingsThemeManager.h"
#import "DDPingsManager.h"
#import "UIImageView+DDImageLoading.h"
#import "DDAlertUtils.h"
@implementation DDSentPingsTVC

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
    self.statusLabel.font = [UIFont DDRegularFont:15];
    self.statusLabel.textColor = DDPingsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.buttonContainerView.borderColor = DDPingsThemeManager.shared.selected_theme.border_grey_227.colorValue;
    self.buttonContainerView.layer.cornerRadius = 4.0;
    self.buttonContainerView.borderW = 1.0;
    self.mainContainerView.borderColor = DDPingsThemeManager.shared.selected_theme.border_grey_227.colorValue;
    self.mainContainerView.borderW = 1.0;
    self.mainContainerView.layer.cornerRadius = 4.0;
    [self.callButton setBackgroundColor:DDPingsThemeManager.shared.selected_theme.app_theme.colorValue];
    self.callButton.borderColor = DDPingsThemeManager.shared.selected_theme.app_theme.colorValue;
    self.callButton.layer.cornerRadius = 9.0;
    self.callButton.titleLabel.font = [UIFont DDMediumFont:15.0];
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
    self.statusLabel.text = [NSString stringWithFormat:@"Status:%@",self.cellModelData.ping_status ? self.cellModelData.ping_status : nil];
    [self.callButtonContainerView setHidden:![self.cellModelData isCancellable]];
    [self.callButton setTitle:[NSString stringWithFormat:@"%@",self.cellModelData.recall_title] forState:UIControlStateNormal];
    
    
    [super setData:data];
}

 // MARK: - Recall the Ping

-(IBAction)btnRecallAction:(id)sender{
    NSString *yesBtn = self.cellModelData.recall_button_text;
    if (yesBtn.length == 0) yesBtn = @"Yes";
    NSArray *btns = @[CANCEL, yesBtn];
    __weak typeof(self) weakSelf = self;
    [DDAlertUtils showAlertWithTitle:self.cellModelData.recall_title subtitle:self.cellModelData.recall_message buttonNames:btns highlightedAt:1 onClick:^(int buttonIndex) {
        if (buttonIndex == 1) {
            [weakSelf recallPingAPI];
        }
    }];
}

-(void)recallPingAPI{

    DDPingRequestM *pingRequestM = [[DDPingRequestM alloc] init];
    pingRequestM.ping_id = self.cellModelData.ping_id.stringValue;
    if (!pingRequestM.isValidRequestForRecallPingCall){
        [DDAlertUtils showOkAlertWithTitle:nil subtitle:pingRequestM.validationErrorMessageForRecallPing completion:nil];
    }else{
        [DDPingsManager.shared recallPingRequest:pingRequestM andCompletion:^(DDPingApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                NSLog(@"%@",model);
                [DDAlertUtils showOkAlertWithTitle:@"" subtitle:model.data.message completion:nil];
                self.callBackAfterPing(model);
                
            }else{
                [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
            }
        }];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
