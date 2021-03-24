//
//  DDOrderTotalTHFV.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 01/08/2020.
//

#import "DDOrderTotalTHFV.h"
#import "DDModels.h"
#import "DDHomeThemeManager.h"
@implementation DDOrderTotalTHFV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)designUI {
    self.deliveryTitleLabel.font = [UIFont DDRegularFont:15];
    self.deliveryTitleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.discountTitleLabel.font = [UIFont DDRegularFont:15];
    self.discountTitleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.subtotalTitleLabel.font = [UIFont DDRegularFont:15];
    self.subtotalTitleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    
    self.subtotalValueLabel.font = [UIFont DDMediumFont:15];
    self.subtotalValueLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.subtotalValueLabel.font = [UIFont DDMediumFont:15];
    self.subtotalValueLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.subtotalValueLabel.font = [UIFont DDMediumFont:15];
    self.subtotalValueLabel.textColor = HOME_THEME.text_black_40.colorValue;
    
    self.totalTitleLabel.font = [UIFont DDRegularFont:15];
    self.totalTitleLabel.textColor = HOME_THEME.bg_grey_199.colorValue;
    self.totalValueLabel.font = [UIFont DDSemiBoldFont:20];
    self.totalValueLabel.textColor = HOME_THEME.text_black_40.colorValue;
    
    self.deliveryTitleLabel.text = @"Delivery".localized;
    self.discountTitleLabel.text = @"Discount".localized;
    self.subtotalTitleLabel.text = @"Subtotal".localized;
    self.totalTitleLabel.text = @"Total".localized;
    
    
    for (UIView *view in self.separatorViews) {
        view.backgroundColor = HOME_THEME.text_grey_238.colorValue;
    }
}
-(void)setData:(id)data {
    DDOrderDetailM *detail = data;
    self.deliveryValueLabel.text = detail.delivery;
    [self.deliveryValueLabel setHidden:detail.delivery.length == 0];
    self.discountValueLabel.text = detail.discount;
    [self.discountValueLabel setHidden:detail.discount.length == 0];
    self.subtotalValueLabel.text = detail.sub_total;
    [self.subtotalValueLabel setHidden:detail.sub_total.length == 0];
    self.totalValueLabel.text = detail.total;
    [self.totalValueLabel setHidden:detail.total.length == 0];
    [super setData:data];
}
@end
