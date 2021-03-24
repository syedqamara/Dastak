//
//  DDHomeThemeManager.m
//  DDHome
//
//  Created by Zubair Ahmad on 21/01/2020..
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

#import "DDHomeThemeManager.h"

@implementation DDHomeThemeM

@end


@implementation DDHomeThemeManager
static DDHomeThemeManager *_sharedObject;
+(DDHomeThemeManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDHomeThemeManager alloc]init];
    });
    return _sharedObject;
}

@end
