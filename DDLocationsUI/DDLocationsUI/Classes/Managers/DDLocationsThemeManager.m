//
//  DDLocationsThemeManager.m
//  DDLocationsUI
//
//  Created by Zubair Ahmad on 21/01/2020..
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

#import "DDLocationsThemeManager.h"

@implementation DDLocationsThemeM

@end


@implementation DDLocationsThemeManager
static DDLocationsThemeManager *_sharedObject;
+(DDLocationsThemeManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDLocationsThemeManager alloc]init];
    });
    return _sharedObject;
}

@end
