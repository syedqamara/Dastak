//
//  DDCashlessDriverInfoTHFV.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 09/04/2020.
//

#import "DDCashlessDriverInfoTHFV.h"
#import "DDBasket.h"
#import "Autolayout.h"
@interface DDCashlessDriverInfoTHFV() {
    DDOrderStatusData *orderStatus;
}

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *yourDriverLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *driverNameLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *phoneImage;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIView *mapContainerView;
@property (weak, nonatomic) IBOutlet UIStackView *phoneStackView;

@end

@implementation DDCashlessDriverInfoTHFV

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(id)data {
    orderStatus = data;
    [self.imageView loadImageWithString:@"dummy_placeholder.png" forClass:self.class];
    [self.phoneImage loadImageWithString:@"phone_temp.png" forClass:self.class];
    self.driverNameLbl.text = orderStatus.last_mile_info.driver_name;
    self.yourDriverLbl.text = orderStatus.last_mile_info.driver_text;
    if (orderStatus.last_mile_info.driver_number.length > 0) {
        [self.phoneBtn setTitle:orderStatus.last_mile_info.driver_number forState:(UIControlStateNormal)];
    }else {
        [self.phoneStackView setHidden:YES];
    }
    if (orderStatus.last_mile_info.tracking_url.length > 0) {
        if (DDBasket.shared.webView == nil) {
            DDBasket.shared.webView = [WKWebView.alloc initWithFrame:CGRectZero];
        }
        [DDBasket.shared.webView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [Autolayout addConstrainsToParentView:self.mapContainerView andChildView:DDBasket.shared.webView withConstraintTypeArray:@[@(AutolayoutTop),@(AutolayoutBottom),@(AutolayoutRight),@(AutolayoutLeft)] andValues:@[@(0),@(0),@(0),@(0)]];
        [self.mapContainerView setUserInteractionEnabled:NO];
        NSURL *url = [NSURL URLWithString:orderStatus.last_mile_info.tracking_url];
        if (DDBasket.shared.request == nil) {
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            request.HTTPMethod = @"GET";
            [DDBasket.shared.webView loadRequest:request];
            DDBasket.shared.request = request;
        }
        
    }else {
        [self.mapContainerView setHidden:YES];
    }
    
    [super setData:data];
}

- (void)designUI {
    self.yourDriverLbl.text = @"Your Driver";
    self.yourDriverLbl.textColor = DDCashlessThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.yourDriverLbl.font = [UIFont DDMediumFont:13];
    
    self.imageView.circle = YES;
    
    self.driverNameLbl.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.driverNameLbl.font = [UIFont DDBoldFont:15];
    
    [self.phoneBtn setTitleColor:DDCashlessThemeManager.shared.selected_theme.text_theme.colorValue forState:(UIControlStateNormal)];
    self.phoneBtn.titleLabel.font = [UIFont DDBoldFont:15];
    
}


- (IBAction)phoneTapped:(UIButton *)sender {
    [orderStatus.last_mile_info.driver_number makeCall];
}

@end
