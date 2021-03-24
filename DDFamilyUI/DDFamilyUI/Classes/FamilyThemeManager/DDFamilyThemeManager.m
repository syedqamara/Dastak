//
//  DDFamilyThemeManager.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 27/01/2020.
//

#import "DDFamilyThemeManager.h"

@implementation DDFamilyThemeM

@end



@implementation DDFamilyThemeManager
static DDFamilyThemeManager *_sharedObject;

+(DDFamilyThemeManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDFamilyThemeManager alloc]init];
    });
    return _sharedObject;
}

@end
