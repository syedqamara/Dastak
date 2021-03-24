//
//  DDCashlessMerchantInfoTHFV.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 10/04/2020.
//

#import "DDCashlessMerchantInfoTHFV.h"

@interface DDCashlessMerchantInfoTHFV()
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLable;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *cuisinesLbl;

@property (strong, nonatomic) DDOutletM *outlet;

@end

@implementation DDCashlessMerchantInfoTHFV



- (void)setData:(id)data {
    if (![data isKindOfClass:[DDOutletM class]]) return;
    
    self.outlet = data;
    self.titleLable.text = self.outlet.merchant_name;
    [self.imageView loadImageWithString:self.outlet.merchant.logo_url forClass:self.class];
    if (self.outlet.merchant.cuisines_sub_categories && self.outlet.merchant.cuisines_sub_categories.count){
         self.cuisinesLbl.text = [[self.outlet.merchant.cuisines_sub_categories valueForKey:@"title"] componentsJoinedByString:@", "];
    }else {
        self.cuisinesLbl.text = @"";
    }
    [super setData:data];
}

- (void)designUI {
    self.imageView.cornerR = 12;
    self.imageView.borderW = 1;
    self.imageView.borderColor = CASHLESS_THEME.border_grey_199.colorValue;
    
    self.titleLable.textColor = CASHLESS_THEME.text_black_40.colorValue;
    self.titleLable.font = [UIFont DDBoldFont:15];
    self.cuisinesLbl.font = [UIFont DDRegularFont:13];
    self.contentView.backgroundColor = [CASHLESS_THEME.app_theme.colorValue colorWithAlphaComponent:0.1];
}

@end
