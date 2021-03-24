//
//  DDAuthThemeManager.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDAuthUIThemeManager.h"

@implementation DDAuthUIThemeM

@end


@implementation DDAuthUIThemeManager
static DDAuthUIThemeManager *_sharedObject;
+(DDAuthUIThemeManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDAuthUIThemeManager alloc]init];
    });
    return _sharedObject;
}

@end
