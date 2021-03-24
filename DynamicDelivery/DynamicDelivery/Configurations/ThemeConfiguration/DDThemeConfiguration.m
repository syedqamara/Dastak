//
//  DDThemeConfiguration.m
//  dynamicdelivery_Example
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//
#import "DDAppConfiguration.h"
#import "DDThemeConfiguration.h"
#import <DDUI/DDUI.h>
#import <DDAuthUI.h>
#import <DDLocationsUI.h>
#import <DDHomeUI.h>
#import <DDSearchUI.h>

#define THEME_MODULE_NAME_DDAuthUI @"DDAuthUI"
#define THEME_MODULE_NAME_DDLocationsUI @"DDLocationsUI"
#define THEME_MODULE_NAME_DDSearchUI @"DDSearchUI"
#define THEME_MODULE_NAME_DDHomeUI @"DDHomeUI"

@implementation DDThemeConfiguration
+(void)loadConfig {
    DDUIThemeManager.shared.lightFontName = @"MuseoSans-100";
    DDUIThemeManager.shared.regularFontName = @"MuseoSans-300";
    DDUIThemeManager.shared.mediumFontName = @"MuseoSans-500";
    DDUIThemeManager.shared.boldFontName = @"MuseoSans-700";
    DDUIThemeManager.shared.heavyFontName = @"Museo 900";
    DDUILottieAnimationManager.shared.loaderAnimationJSONName = @"loader_api";
    
    BOOL isFirstTimeThemeLoading = DDUIThemeManager.shared.selected_theme == nil;
    NSArray <NSString *> *themeNames = @[@"light", @"dark"];
    if (DDUIThemeManager.selectedTheme < themeNames.count) {
        NSString *selectedFileName = themeNames[DDUIThemeManager.selectedTheme];
        DDUIThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:@"" andSeparator:@"" andClass:DDUIThemeModel.class];
        DDAuthUIThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDAuthUI andSeparator:@"_" andClass:DDAuthUIThemeM.class];
        DDLocationsThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDLocationsUI andSeparator:@"_" andClass:DDLocationsThemeM.class];
        DDSearchUIThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDSearchUI andSeparator:@"_" andClass:DDSearchUIThemeM.class];
        
        DDHomeThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDHomeUI andSeparator:@"_" andClass:DDHomeThemeM.class];
        
    }
    if (!isFirstTimeThemeLoading) {
        [DDUIThemeManager themeIsChanged];
    }
}
+(id)loadThemeWithFileName:(NSString *)file withModuleName:(NSString *)module andSeparator:(NSString *)separator andClass:(Class)cls {
    NSString *completeFileName = [NSString stringWithFormat:@"%@%@%@",module, separator, file];
    NSURL *url = [NSBundle.mainBundle URLForResource:completeFileName withExtension:@"json"];
    if (url != nil) {
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (data != nil) {
            NSError *error;
            return [[cls alloc]initWithData:data error:&error];
        }
    }
    return nil;
}
@end
