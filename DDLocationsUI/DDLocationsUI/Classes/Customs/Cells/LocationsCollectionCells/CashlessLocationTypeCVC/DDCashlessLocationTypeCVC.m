//
//  DDCashlessLocationTypeCVC.m
//  DDLocationsUI
//
//  Created by Awais Shahid on 20/02/2020.
//

#import "DDCashlessLocationTypeCVC.h"

@interface DDCashlessLocationTypeCVC ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (nonatomic, copy) IBOutlet DDLocationTagsM *locationTag;
@end


@implementation DDCashlessLocationTypeCVC

- (void)setData:(id)data {
    DDLocationTagsM *tag = (DDLocationTagsM*)data;
    if(tag==nil) return;
    self.locationTag = tag;
    self.titleLbl.text = self.locationTag.tag_name;
    [super setData:data];
}

- (void)designUI {
    self.containerView.cornerR = 6;
    self.containerView.borderColor = DDLocationsThemeManager.shared.selected_theme.border_grey_175.colorValue;
    self.containerView.clipsToBounds = YES;
    self.titleLbl.font = [UIFont DDMediumFont:15];
    
    if (self.locationTag.isSelected) {
        self.containerView.backgroundColor = DDLocationsThemeManager.shared.selected_theme.app_theme.colorValue;
        self.titleLbl.textColor = DDLocationsThemeManager.shared.selected_theme.text_white.colorValue;
        self.containerView.borderW = 0;
    }
    else {
        self.containerView.backgroundColor = DDLocationsThemeManager.shared.selected_theme.bg_white.colorValue;
        self.titleLbl.textColor = DDLocationsThemeManager.shared.selected_theme.text_black_40.colorValue;
        self.containerView.borderW = 1;
    }
}

@end
