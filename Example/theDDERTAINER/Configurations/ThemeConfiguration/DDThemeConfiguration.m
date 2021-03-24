//
//  DDThemeConfiguration.m
//  theDDERTAINER_Example
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import "DDThemeConfiguration.h"
#import <DDUI/DDUI.h>
#import <DDAuthUI.h>
#import "DDAppConfiguration.h"
#import <DDHomeUI.h>
#import "DDFamilyUI.h"
#import "DDCashlessUI.h"
#import <DDAccountsUI.h>
#import <DDPingsUI.h>
#import <DDOutletsUI.h>
#import <DDRedemptionsUI.h>
#import <DDSearchUI.h>
#import <DDLocationsUI.h>
#import <DDMapsUI.h>
#import <DDFiltersUI/DDFiltersUI.h>
#import <DDFavouritesUI/DDFavouritesUI.h>

#define THEME_MODULE_NAME_DDSearchUI @"DDSearchUI"
#define THEME_MODULE_NAME_DDAuthUI @"DDAuthUI"
#define THEME_MODULE_NAME_DDHomeUI @"DDHomeUI"
#define THEME_MODULE_NAME_DDFamilyUI @"DDFamilyUI"
#define THEME_MODULE_NAME_DDFavouritesUI @"DDFavouritesUI"
#define THEME_MODULE_NAME_DDAccountsUI @"DDAccountsUI"
#define THEME_MODULE_NAME_DDPingsUI @"DDPingsUI"
#define THEME_MODULE_NAME_DDOutletsUI @"DDOutletsUI"
#define THEME_MODULE_NAME_DDLocationsUI @"DDLocationsUI"
#define THEME_MODULE_NAME_DDMapsUI @"DDMapsUI"
#define THEME_MODULE_NAME_DDCashlessUI @"DDCashlessUI"
#define THEME_MODULE_NAME_DDRedemptionsUI @"DDRedemptionsUI"
#define THEME_MODULE_NAME_DDFiltersUI @"DDFiltersUI"

@implementation DDThemeConfiguration
+(void)loadConfig {
    DDUIThemeManager.shared.lightFontName = @"MuseoSans-100";
    DDUIThemeManager.shared.regularFontName = @"MuseoSans-300";
    DDUIThemeManager.shared.mediumFontName = @"MuseoSans-500";
    DDUIThemeManager.shared.boldFontName = @"MuseoSans-700";
    DDUIThemeManager.shared.heavyFontName = @"Museo 900";
    DDUILottieAnimationManager.shared.loaderAnimationJSONName = @"loadersmile";
    
    BOOL isFirstTimeThemeLoading = DDUIThemeManager.shared.selected_theme == nil;
    NSArray <NSString *> *themeNames = @[@"light", @"dark"];
    if (DDUIThemeManager.selectedTheme < themeNames.count) {
        NSString *selectedFileName = themeNames[DDUIThemeManager.selectedTheme];
        DDUIThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:@"" andSeparator:@"" andClass:DDUIThemeModel.class];
        DDAuthUIThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDAuthUI andSeparator:@"_" andClass:DDAuthUIThemeM.class];
        DDHomeThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDHomeUI andSeparator:@"_" andClass:DDHomeThemeM.class];
        DDFamilyThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDFamilyUI andSeparator:@"_" andClass:DDFamilyThemeM.class];
        DDAccountUIThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDAccountsUI andSeparator:@"_" andClass:DDAccountUIThemeModel.class];
        DDPingsThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDPingsUI andSeparator:@"_" andClass:DDPingsThemeM.class];
        DDOutletsThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDOutletsUI andSeparator:@"_" andClass:DDOutletsThemeM.class];
        DDSearchUIThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDSearchUI andSeparator:@"_" andClass:DDSearchUIThemeM.class];
        DDLocationsThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDLocationsUI andSeparator:@"_" andClass:DDLocationsThemeM.class];
        DDMapsThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDMapsUI andSeparator:@"_" andClass:DDLocationsThemeM.class];
        DDCashlessThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDCashlessUI andSeparator:@"_" andClass:DDCashlessThemeM.class];
        DDRedemptionsThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDRedemptionsUI andSeparator:@"_" andClass:DDRedemptionsThemeM.class];
        DDMapsThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDMapsUI andSeparator:@"_" andClass:DDMapsThemeM.class];
        DDFavouritesThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDFavouritesUI andSeparator:@"_" andClass:DDFavouritesThemeM.class];
        DDFiltersThemeManager.shared.selected_theme = [self loadThemeWithFileName:selectedFileName withModuleName:THEME_MODULE_NAME_DDFiltersUI andSeparator:@"_" andClass:DDFiltersThemeM.class];
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
