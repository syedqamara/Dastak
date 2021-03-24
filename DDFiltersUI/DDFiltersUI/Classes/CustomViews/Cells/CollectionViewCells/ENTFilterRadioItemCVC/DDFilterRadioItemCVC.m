//
//  DDFilterRadioItemCVC.m
//  DDFiltersUI
//
//  Created by Umair on 07/02/2020.
//

#import "DDFilterRadioItemCVC.h"

@interface DDFilterRadioItemCVC ()
@property (weak, nonatomic) IBOutlet UIImageView *radioImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@end

@implementation DDFilterRadioItemCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setData:(id)data {
    if (![data isKindOfClass:[DDFiltersOptionM class]]) return;
    
    DDFiltersOptionM *option = data;
    self.titleLbl.text = option.title;
    NSString *img = option.isSelected ? option.image_url_selected : option.image_url;
    [self.radioImg loadImageWithString:img forClass:self.class];
    [super setData:data];
}


- (void)designUI {
    self.titleLbl.font = [UIFont DDRegularFont:17];
    self.titleLbl.textColor = DDFiltersThemeManager.shared.selected_theme.text_black_40.colorValue;

}

@end
