//
//  DDCashlessOrderPickupTHFV.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 09/04/2020.
//

#import "DDCashlessOrderPickupTHFV.h"

@interface DDCashlessOrderPickupTHFV ()

@property (weak, nonatomic) IBOutlet UIButton *pickupButton;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subtitleLbl;

@end


@implementation DDCashlessOrderPickupTHFV

- (void)setData:(id)data {
    DDOrderDetailSectionM *section = data;
    self.titleLbl.text = section.order_status.section_takeaway_picked_up.title;
    self.subtitleLbl.text = section.order_status.section_takeaway_picked_up.details;
    [self.pickupButton setHidden:!section.order_status.section_takeaway_picked_up.showPickedUpButton];
    [self.pickupButton setTitle:section.order_status.section_takeaway_picked_up.picked_up_btn_txt forState:(UIControlStateNormal)];
    [super setData:data];
}

- (void)designUI {
    self.titleLbl.font = [UIFont DDBoldFont:17];
    self.titleLbl.textColor = CASHLESS_THEME.text_black_40.colorValue;
    
    self.subtitleLbl.font = [UIFont DDRegularFont:15];
    self.subtitleLbl.textColor = CASHLESS_THEME.text_black_40.colorValue;
    
    [self.pickupButton setTitleColor:CASHLESS_THEME.text_white.colorValue forState:(UIControlStateNormal)];
    self.pickupButton.titleLabel.font = [UIFont DDMediumFont:15];
    self.pickupButton.backgroundColor = CASHLESS_THEME.app_theme.colorValue;
    self.pickupButton.layer.cornerRadius = 5;
    [self.pickupButton setClipsToBounds:YES];
    
}
- (IBAction)didTapPickupButton:(id)sender {
    if (self.delegate != nil) {
        [self.delegate didTapPickupOrderButton];
    }
}


@end
