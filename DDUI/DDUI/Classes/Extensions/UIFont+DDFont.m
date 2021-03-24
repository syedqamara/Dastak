//
//  UIFont+DDSEFont.m
//  DDSE_Example
//
//  Created by Raheel on 06/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//

#import "UIFont+DDFont.h"
#import <DDUIThemeManager.h>
//#import "DDSESDKSharedPreferences.h"

@implementation UIFont (DDFont)


+ (UIFont *)DDLightFont:(float)size {
    //MuseoSans-100
    NSString *fontName = DDUIThemeManager.shared.lightFontName;
    if (fontName.length > 0) {
        return [UIFont fontWithName:fontName size:size];
    }
    return nil;
}

+ (UIFont *)DDRegularFont:(float)size {
    //MuseoSans-300
    NSString *fontName = DDUIThemeManager.shared.regularFontName;
    if (fontName.length > 0) {
        return [UIFont fontWithName:fontName size:size];
    }
    return nil;
}

+ (UIFont *)DDBoldFont:(float)size {
    //MuseoSans-700
    NSString *fontName = DDUIThemeManager.shared.boldFontName;
    if (fontName.length > 0) {
        return [UIFont fontWithName:fontName size:size];
    }
    return nil;
}

+ (UIFont *)DDHeavyFont:(float)size {
    //MuseoSans-700
    NSString *fontName = DDUIThemeManager.shared.heavyFontName;
    if (fontName.length > 0) {
        return [UIFont fontWithName:fontName size:size];
    }
    return [UIFont systemFontOfSize:size weight:(UIFontWeightHeavy)];
}

+ (UIFont *)DDMediumFont:(float)size {
    //MuseoSans-500
    NSString *fontName = DDUIThemeManager.shared.mediumFontName;
    if (fontName.length > 0) {
        return [UIFont fontWithName:fontName size:size];
    }
    return nil;
}

+ (UIFont *)DDSemiBoldFont:(float)size {
    //MuseoSans-500
    NSString *fontName = DDUIThemeManager.shared.boldFontName;
    if (fontName.length > 0) {
        return [UIFont fontWithName:fontName size:size];
    }
    return nil;
}

@end
