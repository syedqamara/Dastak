//
//  DDHomeTileAttributeCVC.m
//  DDHomeUI
//
//  Created by Syed Qamar Abbas on 01/07/2020.
//

#import "DDHomeTileAttributeCVC.h"
#import "DDHomeSectionM.h"
#import "DDHomeThemeManager.h"

#define ATTR_TITLE_FONT [UIFont DDMediumFont:13]
 
@implementation DDHomeTileAttributeCVC
+(UIFont *)titleFont {
    return ATTR_TITLE_FONT;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.tileTitleLabel.font = [UIFont DDMediumFont:13];
    self.titleContainerView.borderColor = HOME_THEME.text_grey_238.colorValue;
}
-(void)setData:(id)data {
    DDHomeSectionAttributeM *attribute = data;
    self.titleContainerView.borderW = attribute.borderWidth;
    [self.tileImageView setHidden:!attribute.haveImage];
    [self.titleContainerView setHidden:attribute.haveImage];
    [self.tileImageView loadImageWithString:attribute.value withPlaceHolderImage:[@"placeholder.png" pngImage:self.class] forClass:self.class];
    self.tileTitleLabel.text = attribute.titleStr;
    self.tileTitleLabel.textColor = attribute.title_color.colorValue;
    [super setData:data];
}

@end
