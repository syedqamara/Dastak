//
//  DDProfileListCVC.m
//  DDAccountsUI
//
//  Created by Syed Qamar Abbas on 27/01/2020.
//

#import "DDProfileListCVC.h"
#import "DDAccountUIThemeManager.h"
#import "NSBundle+DDNSBundle.h"
#import <DDCommons/DDCommons.h>

@implementation DDProfileListCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.placeHolder = NO;

}

-(void)designUI {
    self.titleLabel.font = [UIFont DDBoldFont:15];
    self.titleLabel.textColor = DDAccountUIThemeManager.shared.selected_theme.text_white.colorValue;
    self.amountLabel.textColor = DDAccountUIThemeManager.shared.selected_theme.text_white.colorValue;
    self.accessoryImageView.tintColor = DDAccountUIThemeManager.shared.selected_theme.text_white.colorValue;

}
-(void)setData:(id)data {
    DDProfileSectionListM *item = (DDProfileSectionListM*)data;
    if (item && [item isKindOfClass:[DDProfileSectionListM class]]) {
        self.titleLabel.text = item.title;

        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",item.subtitle ?: @"", item.detail ?: @""]];
        [attributedText addAttribute:NSFontAttributeName value: [UIFont DDBoldFont:28]   forString:item.subtitle];
        [attributedText addAttribute:NSFontAttributeName value: [UIFont DDBoldFont:15]   forString:item.detail];
        self.amountLabel.attributedText = attributedText;
        
        self.containerView.backgroundColor = item.bg_color_l.colorValue;
        [self.accessoryImageView loadTemplateImageWithString:@"arrowDetail.png" forClass:self.class];
    }
    [super setData:data];
}
@end
