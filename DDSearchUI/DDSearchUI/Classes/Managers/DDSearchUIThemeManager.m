//
//  DDSearchUIThemeManager.m
//  DDSearchUI
//
//  Created by Syed Qamar Abbas on 10/02/2020.
//

#import "DDSearchUIThemeManager.h"


@implementation DDSearchUIThemeM

@end


@implementation DDSearchUIThemeManager
static DDSearchUIThemeManager *_sharedObject;
+(DDSearchUIThemeManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDSearchUIThemeManager alloc]init];
    });
    return _sharedObject;
}

@end
