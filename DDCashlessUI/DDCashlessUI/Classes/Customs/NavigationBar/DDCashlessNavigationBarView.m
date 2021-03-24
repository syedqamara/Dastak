//
//  DDCashlessNavigationBarView.m
//  DDCashlessUI
//
//  Created by Syed Qamar Abbas on 09/03/2020.
//

#import "DDCashlessNavigationBarView.h"

@interface DDCashlessNavigationBarView()

@end

@implementation DDCashlessNavigationBarView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self designUI];
    
}

- (void)setData:(id)data {
    if (data == nil && DDLocationsManager.shared.isLocationServicesEnable == NO) {
        self.selectedTitleLabel.text = @"Select a location";
        return;
    }
    
    if (![data isKindOfClass:[DDDeliveryAddressM class]]) return;
    DDDeliveryAddressM *model = (DDDeliveryAddressM*)data;
    self.selectedTitleLabel.text = model.getTitle;
    
    [super setData:data];
}


- (void)designUI {
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    if (@available(iOS 11.0, *)) {
        CGFloat topPadding = window.safeAreaInsets.top;
        self.topSpace.constant = topPadding + 12;
    }
    else {
        self.topSpace.constant = 8;
    }
    
    self.titleLabel.textColor = CASHLESS_THEME.text_white.colorValue;
    self.titleLabel.font = [UIFont DDMediumFont:15];
    
    self.selectedTitleLabel.textColor = CASHLESS_THEME.text_white.colorValue;
    self.selectedTitleLabel.font = [UIFont DDBoldFont:17];

    [self.backButton loadImageWithString:@"icNavBack.png" forClass:self.class];
    [self.backButton setTintColor:CASHLESS_THEME.text_white.colorValue];

    [self.optionsButton loadImageWithStringWithoutTemplate:@"icMore.png" forClass:self.class];
    [self.optionsButton setTintColor:CASHLESS_THEME.text_white.colorValue];
    
    self.containerView.backgroundColor = CASHLESS_THEME.app_theme.colorValue;
}

-(void)hideOptionButton:(BOOL)hide {
    self.optionsButton.hidden = hide;
}
@end
