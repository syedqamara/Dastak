//
//  DDUIThemeModel.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//

#import <JSONModel/JSONModel.h>
#import "NSString+DDString.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDUIThemeModel : JSONModel

//Theme Color
@property (strong, nonatomic) NSString <Optional> *app_theme;
@property (strong, nonatomic) NSString <Optional> *app_theme_dark;

//BackGrounds
@property (strong, nonatomic) NSString <Optional> *bg_black;
@property (strong, nonatomic) NSString <Optional> *bg_white;
@property (strong, nonatomic) NSString <Optional> *bg_red;
@property (strong, nonatomic) NSString <Optional> *bg_red_39;
@property (strong, nonatomic) NSString <Optional> *bg_grey_199;
@property (strong, nonatomic) NSString <Optional> *bg_grey_220;
@property (strong, nonatomic) NSString <Optional> *bg_grey_227;
@property (strong, nonatomic) NSString <Optional> *bg_grey_240;
@property (strong, nonatomic) NSString <Optional> *bg_grey_244;
@property (strong, nonatomic) NSString <Optional> *bg_grey_248; //f8f8f8

//Separators
@property (strong, nonatomic) NSString <Optional> *separator_white;
@property (strong, nonatomic) NSString <Optional> *separator_black;
@property (strong, nonatomic) NSString <Optional> *separator_theme;
@property (strong, nonatomic) NSString <Optional> *separator_grey_199;
@property (strong, nonatomic) NSString <Optional> *separator_grey_227;

//Borders
@property (strong, nonatomic) NSString <Optional> *border_white;
@property (strong, nonatomic) NSString <Optional> *border_black;
@property (strong, nonatomic) NSString <Optional> *border_theme;
@property (strong, nonatomic) NSString <Optional> *border_grey_199;
@property (strong, nonatomic) NSString <Optional> *border_grey_227;

// Texts

@property (strong, nonatomic) NSString <Optional> *text_theme;
@property (strong, nonatomic) NSString <Optional> *text_theme_dark;
@property (strong, nonatomic) NSString <Optional> *text_white;
@property (strong, nonatomic) NSString <Optional> *text_black;
@property (strong, nonatomic) NSString <Optional> *text_red_39;
@property (strong, nonatomic) NSString <Optional> *text_black_40;
@property (strong, nonatomic) NSString <Optional> *text_grey_111;
@property (strong, nonatomic) NSString <Optional> *text_grey_199;
@property (strong, nonatomic) NSString <Optional> *text_grey_238;

-(UIColor *)leftToRightAppThemeGradientForBound:(CGRect)rect;
-(UIColor *)topToBottomAppThemeGradientForBound:(CGRect)rect;
-(UIColor *)circularAppThemeGradientForBound:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
