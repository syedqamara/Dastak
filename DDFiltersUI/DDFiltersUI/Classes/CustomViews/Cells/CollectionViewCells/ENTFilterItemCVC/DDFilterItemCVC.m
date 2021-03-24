//
//  DDTRFilterAmenitiesCollectionViewCell.m
//
//  Created by Umair on 30/01/2020.
//

#import "DDFilterItemCVC.h"

@interface DDFilterItemCVC()
@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, strong) DDFiltersOptionM *option;
@property (weak, nonatomic) IBOutlet UIView *iconConatiner;
@end

@implementation DDFilterItemCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(id)data {
    if (![data isKindOfClass:[DDFiltersOptionM class]]) return;
    self.option = data;
    self.titleLbl.text = self.option.title;
    [self.imgView loadTemplateImageWithString:self.option.image_url forClass:self.class];
    self.iconConatiner.hidden = self.option.isSelected == NO;
    self.titleLbl.hidden = self.option.title.length == 0;
    if (self.option.isShowMoreCell) {
        self.iconConatiner.hidden = self.option.image_url.length <= 0;
    }
    [super setData:data];
}


- (void)designUI{
    
    self.titleLbl.font = [UIFont DDMediumFont:15];
    if (self.option.isSelected) {
        self.titleLbl.textColor = DDFiltersThemeManager.shared.selected_theme.text_white.colorValue;
        self.imgView.tintColor = DDFiltersThemeManager.shared.selected_theme.bg_white.colorValue;
        self.bgView.backgroundColor = DDFiltersThemeManager.shared.selected_theme.app_theme.colorValue;
        self.bgView.borderW = 0;
    }
    else {
        self.titleLbl.textColor = DDFiltersThemeManager.shared.selected_theme.text_black_40.colorValue;
        self.imgView.tintColor = DDFiltersThemeManager.shared.selected_theme.bg_black.colorValue;
        self.bgView.backgroundColor = DDFiltersThemeManager.shared.selected_theme.bg_white.colorValue;
        self.bgView.borderW = 1;
    }
    
    self.bgView.borderColor = DDFiltersThemeManager.shared.selected_theme.border_grey_227.colorValue;
    self.bgView.cornerR = 6;
    self.bgView.clipsToBounds = YES;
}

- (IBAction)imageTapped:(id)sender {
    if (self.delegate == nil) return;
    if (self.option.isShowMoreCell && [self.delegate respondsToSelector:@selector(showMoreTapped)]) {
        [self.delegate showMoreTapped];
    }
    else {
        [self.option toggleSelection];
        if ([self.delegate respondsToSelector:@selector(crossTapped)]) {
            [self.delegate crossTapped];
        }
    }
}

@end
