//
//  UIColor+DDSEColor.h
//  DDSE_Example
//
//  Created by Raheel on 06/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (DDColor)

+(UIColor *)DDcolorFromHexString:(NSString *)hexString;
+(UIColor*)colorWithHex:(int)hex;

+ (UIColor *)DDThemeColor;
+ (UIColor *)DDLineBorderShadowColor;

+ (UIColor *)DDlightGrayTextColor184;
+ (UIColor *)DDlightGrayTextColor155;
+ (UIColor *)DDDarkTextColor;
+ (UIColor *)DDRedumptionsRemianingColor;
+ (UIColor *)DDRedumptionsHistoryBackgroundColor;
+ (UIColor *)DDLightGrayColor;
+ (UIImage *)imageFromColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
