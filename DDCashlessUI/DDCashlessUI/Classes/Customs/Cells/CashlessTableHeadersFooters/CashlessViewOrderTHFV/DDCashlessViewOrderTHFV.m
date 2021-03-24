//
//  DDCashlessViewOrderTVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 09/04/2020.
//

#import "DDCashlessViewOrderTHFV.h"
#import "DDOrderDetailSectionM.h"
@interface DDCashlessViewOrderTHFV () {
    DDOrderDetailSectionM *section;
}

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;

@end


@implementation DDCashlessViewOrderTHFV

- (void)setData:(id)data {
    section = data;
    NSString *imageName;
    if (section.isExpanded) {
        [self.button setTitle:section.section_subtitle forState:(UIControlStateNormal)];
        imageName = @"icArrowDown.png";
    }else {
        [self.button setTitle:section.section_title forState:(UIControlStateNormal)];
        imageName = @"icArrowUp.png";
    }
    [self.imageView loadImageWithString:imageName forClass:self.class];
    [super setData:data];
}

- (void)designUI {
    [self.button setTitleColor:CASHLESS_THEME.text_theme.colorValue forState:(UIControlStateNormal)];
    self.button.titleLabel.font = [UIFont DDBoldFont:17];
    
}


- (IBAction)orderDetailsTapped:(id)sender {
    [section toggle];
    if (self.delegate != nil) {
        [self.delegate didTapExpandButton];
    }
}
@end
