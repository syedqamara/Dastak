//
//  DDOrderHistoryTVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 06/08/2020.
//

#import "DDOrderHistoryTVC.h"
#import "DDHomeThemeManager.h"
#import "DDOrderHistoryM.h"
@implementation DDOrderHistoryTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.outletName.font = [UIFont DDSemiBoldFont:17];
    self.orderTime.font = [UIFont DDMediumFont:14];
    self.orderAddress.font = [UIFont DDRegularFont:13];
    self.orderStatusTitle.font = [UIFont DDMediumFont:15];
    self.outletName.textColor = HOME_THEME.text_black_40.colorValue;
    self.orderTime.textColor = HOME_THEME.text_grey_111.colorValue;
    self.orderAddress.textColor = HOME_THEME.text_grey_199.colorValue;
}
-(void)setData:(id)data {
    [super setData:data];
    DDOrderHistoryM *order = data;
    self.outletName.text = order.name;
    self.orderTime.text = order.date_time;
    self.orderAddress.text = order.delivery_address;
    [self.orderStatusImage loadImageWithString:order.order_status_icon forClass:self.class];
    self.orderStatusTitle.text = order.order_status;
    self.orderStatusTitle.textColor = order.order_status_color.colorValue;
    [self.outletImageView loadImageWithString:order.logo forClass:self.class];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
