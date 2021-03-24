//
//  DDRedemptionsThemeManager.m
//  DDRedemptionsUI
//
//  Created by Hafiz Aziz on 12/02/2020.
//

#import "DDRedemptionsThemeManager.h"

@implementation DDRedemptionsThemeM @end

@implementation DDRedemptionsThemeManager

static DDRedemptionsThemeManager *_sharedObject;
+(DDRedemptionsThemeManager *)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDRedemptionsThemeManager alloc] init];
    });
    return _sharedObject;
}

@end
