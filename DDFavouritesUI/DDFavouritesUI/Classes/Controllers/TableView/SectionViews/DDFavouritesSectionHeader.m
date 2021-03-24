//
//  DDFavouritesSectionHeader.m
//  DDFavouritesUI
//
//  Created by M.Jabbar on 06/03/2020.
//

#import "DDFavouritesSectionHeader.h"
#import "DDFavouritesThemeManager.h"

@implementation DDFavouritesSectionHeader

+(DDFavouritesSectionHeader*)initializeInstance {
    id view =   [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    return view;
}
-(void)designUI{
   
    self.titleLabel.font = [UIFont DDBoldFont:20];
    self.titleLabel.textColor = DDFavouritesThemeManager.shared.selected_theme.bg_black.colorValue;

}

-(void)setData:(id)data{
    [self designUI];
   
    self.contentView.backgroundColor = DDFavouritesThemeManager.shared.selected_theme.bg_white.colorValue;

    self.sectionItem = (DDFavouritesSectionM*)data;
    
    self.titleLabel.text = self.sectionItem.section_title;
   
    [self.seeAllButton setHidden:!self.sectionItem.is_expandable.boolValue];
    UIImage *arrow = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icArrowDown"];
    if (!self.sectionItem.expended.boolValue) {
        self.seeAllButton.imageView.transform = CGAffineTransformMakeRotation(0); //rotation in radians
    }else{
        self.seeAllButton.imageView.transform = CGAffineTransformMakeRotation(M_PI); //rotation in radians
    }
    [self.seeAllButton setImage:arrow forState:UIControlStateNormal];

}
- (IBAction)seeAllButtonTapped:(id)sender {
    self.expandColapsedButtonTapped(self.tag);
}

@end
