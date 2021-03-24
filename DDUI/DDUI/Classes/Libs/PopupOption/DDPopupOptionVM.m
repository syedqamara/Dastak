//
//  DDPopupOptionVM.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 06/06/2020.
//

#define DEFAULT_CELL_HEIGHT 60.0
#define DEFAULT_LEFT_IMAGE_WIDTH_HEIGHT 20.0
#define DEFAULT_RIGHT_IMAGE_WIDTH_HEIGHT 20.0

#import "DDPopupOptionVM.h"
#import "UIFont+DDFont.h"
#import "DDUIThemeManager.h"
@implementation DDPopupVM
-(instancetype)init {
    self = [super init];
    self.selectionType = DDPopupOptionSelectionTypeDefault;
    self.options = [NSMutableArray new];
    return self;
}
-(CGFloat)panHeight {
    CGFloat height = 60;
    for (DDPopupOptionVM *opt in self.options) {
        height += opt.cellHeight;
    }
    if (height > UIScreen.mainScreen.bounds.size.height / 2) {
        height = UIScreen.mainScreen.bounds.size.height / 2;
    }
    return height;
}
@end

@implementation DDPopupOptionVM
-(instancetype)init {
    self = [super init];
    [self loadDefaultSettings];
    return self;
}
-(void)loadDefaultSettings {
    self.cellHeight = DEFAULT_CELL_HEIGHT;
    self.leftImageWidthHeight = DEFAULT_LEFT_IMAGE_WIDTH_HEIGHT;
    self.rightImageWidthHeight = DEFAULT_RIGHT_IMAGE_WIDTH_HEIGHT;
    
    self.titleFontNormalLeft = [UIFont DDRegularFont:15];
    self.titleFontSelectedLeft = [UIFont DDMediumFont:15];
    self.titleFontNormalRight = [UIFont DDRegularFont:15];
    self.titleFontSelectedRight = [UIFont DDMediumFont:15];
    
    self.titleLabelColorNormalLeft = DDUIThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.titleLabelColorSelectedLeft = DDUIThemeManager.shared.selected_theme.text_black.colorValue;
    self.titleLabelColorNormalRight = DDUIThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.titleLabelColorSelectedRight = DDUIThemeManager.shared.selected_theme.text_black.colorValue;
}
-(BOOL)shouldHideLeftImage {
    return self.leftImageNormal.length == 0;
}
-(BOOL)shouldHideRightImage {
    return self.rightImageNormal.length == 0;
}
-(BOOL)shouldHideLeftTitle {
    return self.titleLabelLeft.length == 0;
}
-(BOOL)shouldHideRightTitle {
    return self.titleLabelRight.length == 0;
}
-(BOOL)shouldHideSeparator {
    return self.separatorColor == nil;
}
-(UIColor *)titleColorLeft; {
    if (self.isSelected) {
        return self.titleLabelColorSelectedLeft;
    }
    return self.titleLabelColorNormalLeft;
}
-(UIFont *)fontLeft; {
    if (self.isSelected) {
        return self.titleFontSelectedLeft;
    }
    return self.titleFontNormalLeft;
}

-(UIColor *)titleColorRight; {
    if (self.isSelected) {
        return self.titleLabelColorSelectedRight;
    }
    return self.titleLabelColorNormalRight;
}
-(UIFont *)fontRight; {
    if (self.isSelected) {
        return self.titleFontSelectedRight;
    }
    return self.titleFontNormalRight;
}
-(NSString *)leftImage {
    if (self.isSelected) {
        return self.leftImageSelected;
    }
    return self.leftImageNormal;
}
-(NSString *)rightImage {
    if (self.isSelected) {
        return self.rightImageSelected;
    }
    return self.rightImageNormal;
}
@end
