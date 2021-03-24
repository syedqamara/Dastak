//
//  DDCashlessCuisineFilterCVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 24/03/2020.
//

#import "DDCashlessCuisineFilterCVC.h"

@interface DDCashlessCuisineFilterCVC()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@end

@implementation DDCashlessCuisineFilterCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(id)data {
    if (data == nil || ![data isKindOfClass:[DDFiltersOptionM class]]) return;
    DDFiltersOptionM *cuisine = (DDFiltersOptionM*)data;
    self.imgView.image = nil;
    self.titleLbl.text = cuisine.title;
    NSString *image = cuisine.isSelected ? cuisine.image_url_selected : cuisine.image_url;
    [self.imgView loadImageWithString:image forClass:self.class];
    //[self.imgView loadImageWithString:@"icPizzace.png" forClass:self.class];
    [super setData:data];
}

- (void)designUI {
    self.titleLbl.font = [UIFont DDMediumFont:13];
    self.titleLbl.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
}

@end
