//
//  DDMapsThemeManager.m
//  DDMaps
//
//  Created by Zubair Ahmad on 10/02/2020..
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

#import "DDMapsThemeManager.h"

@implementation DDMapsThemeM

@end


@implementation DDMapsThemeManager
static DDMapsThemeManager *_sharedObject;
+(DDMapsThemeManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDMapsThemeManager alloc]init];
    });
    return _sharedObject;
}

@end
