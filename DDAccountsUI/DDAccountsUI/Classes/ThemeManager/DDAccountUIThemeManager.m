//
//  DDAccountUIThemeManager.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//

#import "DDAccountUIThemeManager.h"

#define DD_THEME_CHANGED_NOTIFICATION @"DD_THEME_CHANGED_NOTIFICATION"
#define DD_THEME_LOAD_NEW_THEME @"DD_THEME_CHANGED_NOTIFICATION"
#define DD_CURRDD_SELECTED_THEME @"DD_THEME_CHANGED_NOTIFICATION"

@implementation DDAccountUIThemeManager
static DDAccountUIThemeManager * _sharedObject;
+(DDAccountUIThemeManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDAccountUIThemeManager alloc]init];
    });
    return _sharedObject;
}
@end
