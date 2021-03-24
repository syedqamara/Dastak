//
//  DDPingsThemeManager.m
//  DDPings
//
//  Created by Hafiz Aziz on 29/01/2020.
//

#import "DDPingsThemeManager.h"

@implementation DDPingsThemeM

@end

@implementation DDPingsThemeManager

static DDPingsThemeManager *_sharedObject;
+(DDPingsThemeManager *)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDPingsThemeManager alloc] init];
    });
    return _sharedObject;
}

@end
