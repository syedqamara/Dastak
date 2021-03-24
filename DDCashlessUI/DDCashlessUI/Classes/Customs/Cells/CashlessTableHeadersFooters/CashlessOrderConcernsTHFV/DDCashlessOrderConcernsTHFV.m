//
//  DDCashlessOrderConcernsTHFV.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 09/04/2020.
//

#import "DDCashlessOrderConcernsTHFV.h"

@interface DDCashlessOrderConcernsTHFV () {
    DDOrderDetailSectionM *sect;
}

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DDCashlessOrderConcernsTHFV

- (void)setData:(id)data {
    sect = data;
    [self.imageView loadImageWithString:sect.merchant_phone forClass:self.class];
    self.titleLbl.text = sect.section_subtitle;
    [self.imageView loadImageWithString:sect.section_image_url forClass:self.class];
    [super setData:data];
}

- (void)designUI {
    self.titleLbl.font = [UIFont DDRegularFont:15];
    self.titleLbl.textColor = CASHLESS_THEME.text_black_40.colorValue;
}

- (IBAction)concersTapped:(id)sender {
    [sect.merchant_phone makeCall];
}
@end
