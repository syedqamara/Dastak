//
//  DDOutletsThemeManager.m
//  DDOutlets
//
//  Created by Zubair Ahmad on 21/01/2020..
//  Copyright © 2020 The Entertainer. All rights reserved.
//

#import "DDOutletsThemeManager.h"

@implementation DDOutletsThemeM

@end


@implementation DDOutletsThemeManager
static DDOutletsThemeManager *_sharedObject;
+(DDOutletsThemeManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDOutletsThemeManager alloc]init];
    });
    return _sharedObject;
}

@end
