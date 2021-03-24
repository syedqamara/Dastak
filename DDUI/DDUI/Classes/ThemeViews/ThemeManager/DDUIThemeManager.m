//
//  DDUIThemeManager.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//

#import "DDUIThemeManager.h"
#import <DDStorage/DDStorage.h>

#define DD_THEME_CHANGED_NOTIFICATION @"DD_THEME_CHANGED_NOTIFICATION"
#define DD_THEME_LOAD_NEW_THEME @"DD_THEME_CHANGED_NOTIFICATION"
#define DD_CURRDD_SELECTED_THEME @"DD_THEME_CHANGED_NOTIFICATION"

@implementation DDUIThemeManager
static DDUIThemeManager * _sharedObject;
+(DDUIThemeManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDUIThemeManager alloc]init];
    });
    return _sharedObject;
}
+(NSString *)theme_changed_notification_name {
    return DD_THEME_CHANGED_NOTIFICATION;
}
+(NSString *)current_saved_theme_key_name {
    return DD_CURRDD_SELECTED_THEME;
}
+(NSString *)load_new_theme_notification_name {
    return DD_THEME_LOAD_NEW_THEME;
}
+(void)themeIsChanged {
    [NSNotificationCenter.defaultCenter postNotificationName:self.theme_changed_notification_name object:nil];
}
+(void)shouldLoadNewTheme {
    [NSNotificationCenter.defaultCenter postNotificationName:DD_THEME_LOAD_NEW_THEME object:nil];
}
+(NSInteger)selectedTheme {
    return [DDSharedPreferences.shared integerforKeyDF:DD_CURRDD_SELECTED_THEME];
}
+(void)setSelectedTheme:(NSInteger)type {
    [DDSharedPreferences.shared setIntegerDF:type forKey:DD_CURRDD_SELECTED_THEME];
}
@end
