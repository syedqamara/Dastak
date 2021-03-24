//
//  DDProfileProductCVC.m
//  DDAccountsUI
//
//  Created by M.Jabbar on 03/02/2020.
//

#import "DDProfileProductCVC.h"
#import "DDAccountUIThemeManager.h"
#import <DDCommons/DDCommons.h>

@implementation DDProfileProductCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}
-(void)designUI {
   
    self.titleLabel.font = [UIFont DDBoldFont:24];
    self.discountLabel.font = [UIFont DDBoldFont:17];
    self.amountLabel.font = [UIFont DDLightFont:15];
   
    self.titleLabel.textColor = DDAccountUIThemeManager.shared.selected_theme.text_white.colorValue;
    self.discountLabel.textColor = DDAccountUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.amountLabel.textColor = DDAccountUIThemeManager.shared.selected_theme.text_grey_199.colorValue;
    

}
-(void)setData:(id)data {
    [super setData:data];
    DDProfileSectionListM *item = (DDProfileSectionListM*)data;
    [self.productImageView loadImageWithString:item.image_url ?: @"" forClass:[self class]];
    
    if (item) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.titleLabel.placeHolder = [item isDummy];
            self.amountLabel.placeHolder = [item isDummy];
            self.discountLabel.placeHolder = [item isDummy];
            self.productImageView.superview.placeHolder = [item isDummy];
            self.productImageView.backgroundColor = item.bg_color_l.colorValue ?: DDAccountUIThemeManager.shared.selected_theme.app_theme.colorValue;
            self.titleLabel.text = item.title;
            self.discountLabel.text = item.discount_price;
            NSMutableAttributedString *ammount = [[NSMutableAttributedString alloc] initWithString:item.original_price ?: @""];
            [ammount addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) forString:ammount.string];
            [ammount addAttribute:NSFontAttributeName value: [UIFont DDRegularFont:15]   forString:ammount.string];

            self.amountLabel.attributedText = ammount;
            
        });
    }
}

@end
