//
//  DDReservationTVC.m
//  DDRedemptionsUI
//
//  Created by Hafiz Aziz on 19/02/2020.
//

#import "DDReservationTVC.h"
#import "DDRedemptionsThemeManager.h"
@interface DDReservationTVC(){
    DDReservationData *reservationData;
    __weak IBOutlet NSLayoutConstraint *msgContainerViewHeightConstraint;
}
@end
@implementation DDReservationTVC


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI{
    
    self.logo_imgView.layer.cornerRadius = 12.0;
    self.logo_imgView.borderW = 1.0;
    self.logo_imgView.borderColor = DDRedemptionsThemeManager.shared.selected_theme.border_grey_227.colorValue;
    self.logo_imgView.clipsToBounds = YES;
    
    if (reservationData.call_button_phone_number == nil || [reservationData.call_button_phone_number isEqualToString:@""]){
        
        msgContainerViewHeightConstraint.constant = 0;
    } else {
        msgContainerViewHeightConstraint.constant = 30;
        [self.btnCall setBackgroundColor: DDRedemptionsThemeManager.shared.selected_theme.bg_black.colorValue];
    }
    
    self.btnCall.layer.cornerRadius = 9.0;
    self.btnCall.titleLabel.font = [UIFont DDMediumFont:15.0];
    [self.btnCall setBackgroundColor:DDRedemptionsThemeManager.shared.selected_theme.app_theme.colorValue];
    self.title_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black.colorValue;
    self.title_label.font = [UIFont DDBoldFont:17];
    self.status_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black.colorValue;
    self.status_label.font = [UIFont DDMediumFont:15];
    self.status_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black.colorValue;
    if ((reservationData.reservation_status_color ==nil)&&([reservationData.reservation_status_color isEqualToString:@""])){
        
        if ([reservationData statusType] == DDReserved) {
            self.status_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_green_136.colorValue;
        }else if ([reservationData statusType] == DDReservationCompleted){
            self.status_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_theme.colorValue;
        }else if ([reservationData statusType] == DDCancelled){
            self.status_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_red_39.colorValue;
        }
    }else{
        self.status_label.textColor = reservationData.reservation_status_color.colorValue;
    }
    
    self.dateTime_label.font = [UIFont DDRegularFont:15];
    self.dateTime_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black.colorValue;
    self.info_label.font = [UIFont DDRegularFont:15];
    self.info_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black.colorValue;
    self.message_label.font = [UIFont DDBoldFont:13];
    self.message_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black.colorValue;
    
    
}
- (void)setData:(id)data{
    reservationData = (DDReservationData*)data;
    NSLog(@"%@",reservationData);
    [self.logo_imgView loadImageWithString:reservationData.logo_url forClass:self.class];
    self.title_label.text = reservationData.title;
    self.status_label.text = reservationData.reservation_status;
    self.info_label.text = reservationData.reservation_info;
    self.dateTime_label.text = [reservationData.date_time stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (reservationData.call_button_phone_number == nil || [reservationData.call_button_phone_number isEqualToString:@""]){
        [self.btnCall setTitle:nil forState:UIControlStateNormal];
        self.message_label.text = nil;
    }else{
        [self.btnCall setTitle:reservationData.call_button_text forState:UIControlStateNormal];
        self.message_label.text = reservationData.bottom_msg;
    }
    [self.icon_imgView loadImageWithString:reservationData.bottom_msg_logo_url forClass:self.class];
    [super setData:data];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)btnCall:(id)sender {
    if (reservationData.call_button_phone_number){
        [self callAction:reservationData.call_button_phone_number];
    }
}

- (void) callAction : (NSString*) phoneNumber {
    NSString *phoneURLString = [[NSString stringWithFormat:@"telprompt:%@", phoneNumber] stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
    [[UIApplication sharedApplication] openURL:phoneURL options:@{} completionHandler:^(BOOL success) {
        
    }];
    
}

@end
