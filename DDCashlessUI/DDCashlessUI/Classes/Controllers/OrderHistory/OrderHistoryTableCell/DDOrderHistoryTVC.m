//
//  DDOrderHistoryTVC.m
//  DDCashlessUI
//
//  Created by Hafiz Aziz on 09/04/2020.
//

#import "DDOrderHistoryTVC.h"
#import "DDCashlessThemeManager.h"
@interface DDOrderHistoryTVC(){
    DDOrderM *orderData;

}
@end
@implementation DDOrderHistoryTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)designUI{
    
    self.logo_imgView.layer.cornerRadius = 12.0;
    self.logo_imgView.borderW = 1.0;
    self.logo_imgView.borderColor = DDCashlessThemeManager.shared.selected_theme.border_grey_227.colorValue;
    self.logo_imgView.clipsToBounds = YES;
    self.iconImageContainerView.layer.cornerRadius = 9.0;
    self.iconImageContainerView.clipsToBounds = TRUE;
    [self.btnViewOrder setBackgroundColor: DDCashlessThemeManager.shared.selected_theme.app_theme.colorValue];
    self.btnViewOrder.layer.cornerRadius = 9.0;
    self.btnViewOrder.titleLabel.font = [UIFont DDMediumFont:15.0];
    [self.btnReorder setBackgroundColor: DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue];
    self.btnReorder.layer.cornerRadius = 9.0;
    self.btnReorder.layer.borderWidth = 1.0;
    self.btnReorder.layer.borderColor = DDCashlessThemeManager.shared.selected_theme.border_grey_199.colorValue.CGColor;
    self.btnReorder.titleLabel.font = [UIFont DDMediumFont:15.0];
    [self.btnReorder setTitleColor:DDCashlessThemeManager.shared.selected_theme.text_theme.colorValue forState:UIControlStateNormal];
    self.title_label.textColor = DDCashlessThemeManager.shared.selected_theme.text_black.colorValue;
    self.title_label.font = [UIFont DDBoldFont:17];
    self.status_label.textColor = DDCashlessThemeManager.shared.selected_theme.text_black.colorValue;
    self.status_label.font = [UIFont DDMediumFont:15];
    self.status_label.textColor = DDCashlessThemeManager.shared.selected_theme.text_black.colorValue;
    if ((orderData.order_status_color ==nil)&&([orderData.order_status_color isEqualToString:@""])){
        
        if ([orderData statusType] == DDOrderDelivered) {
            self.status_label.textColor = DDCashlessThemeManager.shared.selected_theme.text_green_136.colorValue;
        }else if ([orderData statusType] == DDOrderPending){
            self.status_label.textColor = DDCashlessThemeManager.shared.selected_theme.text_orange_245.colorValue;
        }else if ([orderData statusType] == DDOrderRejected){
            self.status_label.textColor = DDCashlessThemeManager.shared.selected_theme.text_red_39.colorValue;
        }
    }else{
        self.status_label.textColor = orderData.order_status_color.colorValue;
    }
    
    self.dateTime_label.font = [UIFont DDRegularFont:11];
    self.dateTime_label.textColor = DDCashlessThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.total_label.font = [UIFont DDMediumFont:15];
    self.total_label.textColor = DDCashlessThemeManager.shared.selected_theme.text_black.colorValue;
    self.saving_label.font = [UIFont DDMediumFont:15];
    self.saving_label.textColor = DDCashlessThemeManager.shared.selected_theme.text_black.colorValue;
    
    
}
- (void)setData:(id)data{
    orderData = (DDOrderM*)data;
    NSLog(@"%@",orderData);
    [self.logo_imgView loadImageWithString:orderData.logo forClass:self.class];
    self.title_label.text = orderData.merchant;
    self.status_label.text = orderData.order_status;
    self.saving_label.text = orderData.savings;
    self.total_label.text = orderData.total;
    self.dateTime_label.text = [orderData.date stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [self.btnReorder setTitle:orderData.reorder_button_title forState:UIControlStateNormal];
    self.btnReorder.hidden = !orderData.show_reorder_button.boolValue;
    [self.btnViewOrder setTitle:orderData.vieworder_button_title forState:UIControlStateNormal];
#warning remove this hard code title if coming from api
    [self.btnViewOrder setTitle:@"View Order".localized forState:UIControlStateNormal];
    
    [self.logo_imgView loadImageWithString:orderData.logo forClass:self.class];
    NSString *statusIcon = orderData.order_status_icon;
    if (statusIcon.length == 0) {
        if (orderData.is_take_away_order.boolValue)
            statusIcon = @"takeaway.png";
        else
            statusIcon = @"delivery.png";
    }
    [self.icon_imgView loadImageWithString:statusIcon forClass:self.class];
    [super setData:data];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)btnViewOrderAction:(id)sender {
    self.buttonCallback(orderData, NO);
}
- (IBAction)btnReOrderAction:(id)sender {
    self.buttonCallback(orderData, YES);
}

@end
