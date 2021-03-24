//
//  DDCashlessOrderDeliverToTHFV.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 09/04/2020.
//

#import "DDCashlessOrderDeliverToTHFV.h"

@interface DDCashlessOrderDeliverToTHFV ()

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subtitleLbl;

@end


@implementation DDCashlessOrderDeliverToTHFV

- (void)setData:(id)data {
    DDOrderDetailSectionM *section = data;
    self.titleLbl.text = section.section_title;
    self.subtitleLbl.text = section.customer_details.customer_address;
    [super setData:data];
}

- (void)designUI {
    self.titleLbl.font = [UIFont DDBoldFont:17];
    self.titleLbl.textColor = CASHLESS_THEME.text_black_40.colorValue;
    
    self.subtitleLbl.font = [UIFont DDRegularFont:15];
    self.subtitleLbl.textColor = CASHLESS_THEME.text_black_40.colorValue;
}


@end
