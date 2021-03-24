//
//  DDFilterOptionCVC.m
//  DDFiltersUI
//
//  Created by Awais Shahid on 02/04/2020.
//

#import "DDFilterOptionCVC.h"

@interface DDFilterOptionCVC()

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *crossImgView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, strong) DDFiltersOptionM *option;

@end

@implementation DDFilterOptionCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(id)data {
    if (![data isKindOfClass:[DDFiltersOptionM class]]) return;
    self.option = data;
    
    self.titleLbl.text = self.option.title;
    [self.crossImgView loadTemplateImageWithString:@"filter_cross.png" forClass:self.class];
    [super setData:data];
}

- (void)designUI {
    self.titleLbl.font = [UIFont DDMediumFont:13];
    if (self.option.isSelected) {
        self.titleLbl.textColor = DDFiltersThemeManager.shared.selected_theme.text_white.colorValue;
        self.crossImgView.tintColor = DDFiltersThemeManager.shared.selected_theme.bg_white.colorValue;
        self.bgView.backgroundColor = DDFiltersThemeManager.shared.selected_theme.app_theme.colorValue;
        self.bgView.borderW = 0;
    }
    else {
        self.titleLbl.textColor = DDFiltersThemeManager.shared.selected_theme.text_black_40.colorValue;
        self.crossImgView.tintColor = DDFiltersThemeManager.shared.selected_theme.bg_black.colorValue;
        self.bgView.backgroundColor = DDFiltersThemeManager.shared.selected_theme.bg_white.colorValue;
        self.bgView.borderW = 1;
    }
    
    self.bgView.borderColor = DDFiltersThemeManager.shared.selected_theme.border_grey_199.colorValue;
    self.bgView.cornerR = 6;
    self.bgView.clipsToBounds = YES;
}

- (IBAction)crossBtnTapped:(UIButton*)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(crossedAtIndex:)]) {
        [self.delegate crossedAtIndex:self.indexPath];
    }
}

@end
