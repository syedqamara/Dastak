//
//  UIColor+DDSEColor.m
//  DDSE_Example
//
//  Created by Raheel on 06/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//

#import "UIColor+DDColor.h"
//#import <ChameleonFramework/Chameleon.h>
//#import "DDSEAPICommonModel.h"

@implementation UIColor (DDColor)

+(UIColor*)colorWithHex:(int)hex
{
    return UIColorFromRGB(hex);
}

//+ (UIColor *)DDcolorFromHexString:(NSString *)hexString {
//    unsigned rgbValue = 0;
//    NSScanner *scanner = [NSScanner scannerWithString:hexString];
//    [scanner scanHexInt:&rgbValue];
//    UIColor *color = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
//    return color;
//}

+ (UIColor *) DDcolorFromHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            alpha = 1.0f;
            red   = 1.0f;
            green = 1.0f;
            blue  = 1.0f;
//            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}


+ (UIColor *)DDThemeColor {
    UIColor *colorFromConfigs = nil;//DDSEUIConfig.shared.configModelData.ui_config.theme_color.colorValue;
    return colorFromConfigs ? colorFromConfigs : [UIColor DDcolorFromHexString:@"fc471e"];
    //return [UIColor colorWithRed:252.0/255.0 green:71.0/255.0 blue:30.0/255.0 alpha:1];
}

+ (UIColor *)DDlightGrayTextColor184 {
    UIColor *colorFromConfigs = nil;//DDSEUIConfig.shared.configModelData.ui_config.light_gray_text_color_184.colorValue;
    return colorFromConfigs ? colorFromConfigs : [UIColor DDcolorFromHexString:@"b8b8b8"];
    //return [UIColor colorWithRed:184.0/255.0 green:184.0/255.0 blue:184.0/255.0 alpha:1];
}

+ (UIColor *)DDlightGrayTextColor155 {
    UIColor *colorFromConfigs = nil;//DDSEUIConfig.shared.configModelData.ui_config.light_gray_text_color_155.colorValue;
    return colorFromConfigs ? colorFromConfigs : [UIColor DDcolorFromHexString:@"9b9b9b"];
    //return [UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1];
}

+ (UIColor *)DDDarkTextColor {
    UIColor *colorFromConfigs = nil;//DDSEUIConfig.shared.configModelData.ui_config.dark_text_color.colorValue;
    return colorFromConfigs ? colorFromConfigs : [UIColor DDcolorFromHexString:@"383838"];
    //return [UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1];
}

+ (UIColor *)DDLineBorderShadowColor {
    UIColor *colorFromConfigs = nil;//DDSEUIConfig.shared.configModelData.ui_config.line_border_shadow_color.colorValue;
    return colorFromConfigs ? colorFromConfigs : [UIColor DDcolorFromHexString:@"c7c7c7"];
    //return [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:199.0/255.0 alpha:1.0];
}
+ (UIColor *)DDRedumptionsRemianingColor {
    return [UIColor DDcolorFromHexString:@"FEA38E"];
    //return [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:199.0/255.0 alpha:1.0];
}
+ (UIColor *)DDRedumptionsHistoryBackgroundColor {
    return [UIColor DDcolorFromHexString:@"ECECEC"];
}
+ (UIColor *)DDLightGrayColor {
    return [UIColor colorWithWhite:0.6 alpha:1.0f];
}
+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 100);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
