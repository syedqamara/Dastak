//
//  CashlessOrderCollectTHFV.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 09/04/2020.
//

#import "DDCashlessOrderCollectTHFV.h"

@interface DDCashlessOrderCollectTHFV () {
    DDOrderDetailSectionM *sect;
}

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subTitle;

@end

@implementation DDCashlessOrderCollectTHFV

- (void)setData:(id)data {
    sect = data;
    [self.imageView loadImageWithString:sect.merchant_phone forClass:self.class];
    self.titleLbl.text = sect.section_title;
    self.subTitle.text = sect.section_subtitle;
    [self.imageView loadImageWithString:sect.section_image_url forClass:self.class];
    [super setData:data];
}

- (void)designUI {
    self.titleLbl.font = [UIFont DDBoldFont:17];
    self.titleLbl.textColor = CASHLESS_THEME.text_black_40.colorValue;
    
    self.subTitle.font = [UIFont DDRegularFont:15];
    self.subTitle.textColor = CASHLESS_THEME.text_black_40.colorValue;
}

- (IBAction)concersTapped:(id)sender {
    [sect.merchant_phone makeCall];
}
@end
