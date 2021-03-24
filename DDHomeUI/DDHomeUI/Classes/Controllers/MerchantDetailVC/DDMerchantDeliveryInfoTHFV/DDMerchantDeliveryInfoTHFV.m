//
//  DDMerchantDeliveryInfoTHFV.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 25/07/2020.
//

#import "DDMerchantDeliveryInfoTHFV.h"
#import "DDHomeThemeManager.h"
#import "DDMerchantVM.h"
@implementation DDMerchantDeliveryInfoTHFV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)designUI {
    self.deliveryTimeLblTitle.font = [UIFont DDRegularFont:12];
    self.deliveryTimeLblValue.font = [UIFont DDSemiBoldFont:12];
    self.deliveryMinOrderLblTitle.font = [UIFont DDRegularFont:12];
    self.deliveryMinOrderLblValue.font = [UIFont DDSemiBoldFont:12];
    self.deliveryFeeLblTitle.font = [UIFont DDRegularFont:12];
    self.deliveryFeeLblValue.font = [UIFont DDSemiBoldFont:12];
    
    self.mainView.backgroundColor = HOME_THEME.text_grey_238.colorValue;
    self.deliveryTimeLblTitle.textColor = @"747881".colorValue;
    self.deliveryTimeLblValue.textColor = HOME_THEME.text_black_40.colorValue;
    self.deliveryMinOrderLblTitle.textColor = @"747881".colorValue;
    self.deliveryMinOrderLblValue.textColor = HOME_THEME.text_black_40.colorValue;
    self.deliveryFeeLblTitle.textColor = @"747881".colorValue;
    self.deliveryFeeLblValue.textColor = HOME_THEME.text_black_40.colorValue;
    
    self.deliveryTimeLblTitle.text = @"Delivery time".localized;
    self.deliveryMinOrderLblTitle.text = @"Minimum Order".localized;
    self.deliveryFeeLblTitle.text = @"Delivery fee".localized;
}
-(void)setData:(id)data {
    DDMerchantVM *vm = data;
    self.deliveryTimeLblValue.text = vm.merchant.delivery_time;
    self.deliveryMinOrderLblValue.text = vm.merchant.minOrder;
    self.deliveryFeeLblValue.text = vm.merchant.deliveryFee;
    [super setData:data];
}
@end
