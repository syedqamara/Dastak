//
//  DDCashlessOutletListingTitleHFV.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 16/03/2020.
//

#import "DDCashlessOutletListingTitleHFV.h"
#import "DDCashlessOutletListingVM.h"

@interface DDCashlessOutletListingTitleHFV()

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, copy) DDCashlessOutletListingSectionVM *section;

@end

@implementation DDCashlessOutletListingTitleHFV

- (void)setData:(id)data {
    if (![data isKindOfClass:[DDCashlessOutletListingSectionVM class]]) return;
    DDCashlessOutletListingSectionVM *section = (DDCashlessOutletListingSectionVM*)data;
    self.titleLbl.text = section.section_title;
    self.button.hidden = section.section_subtitle.length == 0;
    [self.button setTitle:section.section_subtitle forState:(UIControlStateNormal)];
    [super setData:data];
}

- (void)designUI {
    self.contentView.backgroundColor = DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue;
    self.titleLbl.textColor =  DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    float size = self.section.type == DDCOListingSectionVMTypeFilters ? 20 : 17;
    self.titleLbl.font = [UIFont DDBoldFont:size];
    
    [self.button setTitleColor:DDCashlessThemeManager.shared.selected_theme.text_theme.colorValue forState:UIControlStateNormal];
    self.button.titleLabel.font = [UIFont DDBoldFont:17];
}

- (IBAction)buttonTapped:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapOnCashlessOutletListingTitleHFVButton:)]) {
        [self.delegate didTapOnCashlessOutletListingTitleHFVButton:nil];
    }
}

@end
