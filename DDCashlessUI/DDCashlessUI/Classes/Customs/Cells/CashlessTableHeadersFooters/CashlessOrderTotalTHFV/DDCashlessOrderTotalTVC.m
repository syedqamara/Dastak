//
//  DDCashlessOrderTotalTHFV.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 09/04/2020.
//

#import "DDCashlessOrderTotalTVC.h"
#import "DDOrderDetailM.h"
#import "Autolayout.h"
#import "DDCashlessThemeManager.h"

@interface DDCashlessOrderTotalTVC()
@property (weak, nonatomic) IBOutlet UIView *subTotalWithDeliveryView;
@property (weak, nonatomic) IBOutlet UIView *savingTotalView;
@property (weak, nonatomic) IBOutlet UIView *subTotalWithoutDeliveryView;
@property (weak, nonatomic) IBOutlet UIView *deliveryChargesView;
@property (weak, nonatomic) IBOutlet UIView *grandTotalView;

@property (weak, nonatomic) IBOutlet UILabel *subTotalWithDeliveryTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTotalWithDeliveryAmountLabel;


@property (weak, nonatomic) IBOutlet UILabel *savingTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *savingAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *smileEarnedTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *smileImageView;


@property (weak, nonatomic) IBOutlet UILabel *subTotalWithoutDeliveryTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTotalWithoutDeliveryAmountLabel;


@property (weak, nonatomic) IBOutlet UILabel *deliveryChargesTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *deliveryChargesAmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *grandTotalTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *grandTotalAmountLabel;

@property (weak, nonatomic) IBOutlet UIView *grandTotalSeparator;


@end

@implementation DDCashlessOrderTotalTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setData:(id)data {
    DDOrderDetailM *order = data;
    //Check and hide any info base on availability.
    [self.subTotalWithDeliveryView setHidden:!order.haveSubtotalWithDiscount];
    [self.savingTotalView setHidden:!order.haveSavingsAndSmiles];
    [self.subTotalWithoutDeliveryView setHidden:!order.haveSubtotalWithoutDiscount];
    [self.deliveryChargesView setHidden:!order.haveDeliveryCharges];
    [self.grandTotalView setHidden:!order.haveGrandTotal];
    
    
    //Hard coded titles
    self.subTotalWithDeliveryTitleLabel.text = @"Subtotal".localized;
    self.subTotalWithoutDeliveryTitleLabel.text = @"Subtotal".localized;
    
    
    self.subTotalWithoutDeliveryAmountLabel.text = order.order_sub_total_value;
    self.subTotalWithDeliveryAmountLabel.text = order.order_sub_total_value_after_discount;
    self.deliveryChargesTitleLabel.text = order.order_delivery_title;
    self.deliveryChargesAmountLabel.text = order.order_delivery_fee;
    self.grandTotalTitleLabel.text = order.order_total;
    self.grandTotalAmountLabel.text = order.order_total_sub_title;
    self.savingTitleLabel.text = order.order_percentage_title;
    self.savingAmountLabel.text = order.order_percentage_value;
    if (order.order_percentage_value_color.length > 0) {
        self.savingAmountLabel.textColor = order.order_percentage_value_color.colorValue;
        self.savingTitleLabel.textColor = order.order_percentage_value_color.colorValue;
    }
    if (order.order_percentage_sub_title_color.length > 0) {
        self.smileEarnedTitleLabel.textColor = order.order_percentage_sub_title_color.colorValue;
    }
    
    self.smileEarnedTitleLabel.text = order.order_percentage_sub_title;
    [self.smileImageView loadImageWithString:order.order_percentage_sub_title_img forClass:self.class];
    [super setData:data];
}
-(void)designUI {
    
    self.subTotalWithDeliveryView.backgroundColor = CASHLESS_THEME.bg_white.colorValue;
    self.savingTotalView.backgroundColor = CASHLESS_THEME.bg_white.colorValue;
    self.subTotalWithoutDeliveryView.backgroundColor = CASHLESS_THEME.bg_white.colorValue;
    self.deliveryChargesView.backgroundColor = CASHLESS_THEME.bg_white.colorValue;
    self.grandTotalView.backgroundColor = CASHLESS_THEME.bg_white.colorValue;
    self.savingTitleLabel.textColor = CASHLESS_THEME.text_red_217.colorValue;
    self.savingAmountLabel.textColor = CASHLESS_THEME.text_red_217.colorValue;
    self.smileEarnedTitleLabel.textColor = CASHLESS_THEME.text_yellow_255.colorValue;
    self.subTotalWithoutDeliveryTitleLabel.textColor = CASHLESS_THEME.text_black_40.colorValue;
    self.subTotalWithoutDeliveryAmountLabel.textColor = CASHLESS_THEME.text_black_40.colorValue;
    self.subTotalWithDeliveryTitleLabel.textColor = CASHLESS_THEME.text_black_40.colorValue;
    self.subTotalWithDeliveryAmountLabel.textColor = CASHLESS_THEME.text_black_40.colorValue;
    self.deliveryChargesTitleLabel.textColor = CASHLESS_THEME.text_black_40.colorValue;
    self.deliveryChargesAmountLabel.textColor = CASHLESS_THEME.text_black_40.colorValue;
    self.grandTotalTitleLabel.textColor = CASHLESS_THEME.text_black_40.colorValue;
    self.grandTotalAmountLabel.textColor = CASHLESS_THEME.text_black_40.colorValue;
    
    self.savingTitleLabel.font = [UIFont DDRegularFont:15];
    self.savingAmountLabel.font = [UIFont DDMediumFont:15];
    self.smileEarnedTitleLabel.font = [UIFont DDMediumFont:13];
    self.subTotalWithoutDeliveryTitleLabel.font = [UIFont DDRegularFont:15];
    self.subTotalWithoutDeliveryAmountLabel.font = [UIFont DDMediumFont:15];
    self.subTotalWithDeliveryTitleLabel.font = [UIFont DDRegularFont:15];
    self.subTotalWithDeliveryAmountLabel.font = [UIFont DDBoldFont:15];
    self.deliveryChargesTitleLabel.font = [UIFont DDRegularFont:15];
    self.deliveryChargesAmountLabel.font = [UIFont DDMediumFont:15];
    self.grandTotalTitleLabel.font = [UIFont DDRegularFont:17];
    self.grandTotalAmountLabel.font = [UIFont DDBoldFont:20];
}
@end
