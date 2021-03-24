//
//  DDCashlessOrderNumberTHFV.m
//  DDCashlessUI
//
//  Created by Syed Qamar Abbas on 09/04/2020.
//

#import "DDCashlessOrderNumberTHFV.h"
#import "DDBasket.h"
#import "Autolayout.h"
#import "DDCashlessThemeManager.h"
@interface DDCashlessOrderNumberTHFV()

@property (weak, nonatomic) IBOutlet UILabel *orderNumberTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorView;

@end

@implementation DDCashlessOrderNumberTHFV

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setData:(id)data {
    DDOrderDetailM *order = data;
    self.orderNumberTitleLabel.text = @"Order Number".localized;
    self.orderNumberNumberLabel.text = order.order.order_number;
    [super setData:data];
}
-(void)designUI {
    self.orderNumberTitleLabel.font = [UIFont DDRegularFont:15];
    self.orderNumberNumberLabel.font = [UIFont DDBoldFont:17];
    self.orderNumberTitleLabel.textColor = CASHLESS_THEME.text_black_40.colorValue;
    self.orderNumberNumberLabel.textColor = CASHLESS_THEME.text_black_40.colorValue;
    self.separatorView.backgroundColor = CASHLESS_THEME.bg_grey_199.colorValue;
}

@end
