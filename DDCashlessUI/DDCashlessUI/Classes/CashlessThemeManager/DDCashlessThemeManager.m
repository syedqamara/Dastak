//
//  DDCashlessThemeManager.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 12/02/2020.
//


#import "DDCashlessThemeManager.h"

@implementation DDCashlessThemeM

@end

@implementation DDCashlessThemeManager
static DDCashlessThemeManager *_sharedObject;

+(DDCashlessThemeManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDCashlessThemeManager alloc]init];
    });
    
    return _sharedObject;
}
@end
