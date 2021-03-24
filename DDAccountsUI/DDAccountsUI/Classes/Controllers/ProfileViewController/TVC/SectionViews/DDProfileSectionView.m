//
//  DDProfileSectionView.m
//  DDAccountsUI
//
//  Created by M.Jabbar on 06/02/2020.
//

#import "DDProfileSectionView.h"
#import "DDAccountUIThemeManager.h"
#import "DDAccountUIManager.h"

@implementation DDProfileSectionView

+(DDProfileSectionView*)initializeInstance {
    id view =   [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    return view;
}


-(void)setData:(id)data{
    self.contentView.backgroundColor = DDAccountUIThemeManager.shared.selected_theme.bg_white.colorValue;
    
    self.titleLabel.font = [UIFont DDBoldFont:20];
    self.titleLabel.textColor =  [DDAccountUIThemeManager shared].selected_theme.text_black_40.colorValue;

    self.seeAllButton.titleLabel.font = [UIFont DDBoldFont:17];
    [self.seeAllButton setTitleColor:DDAccountUIThemeManager.shared.selected_theme.text_theme.colorValue forState:UIControlStateNormal];

    self.sectionItem = (DDProfileSectionM*)data;
    
    self.titleLabel.text = self.sectionItem.section_title;
   
    [self.seeAllButton setTitle:self.sectionItem.see_all_button_title forState:UIControlStateNormal];
    [self.seeAllButton setTitleColor:self.sectionItem.see_all_button_title_color_l.colorValue forState:UIControlStateNormal];

}
- (IBAction)seeAllButtonTapped:(id)sender {
    if ([self.sectionItem.section_identifier isEqualToString:@"our_products"]) {
        [DDAccountUIManager showBuyProducts:nil onController:nil];
    }

}

@end
