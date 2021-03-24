//
//  DDFavouritesThemeManager.m
//  DDFavourites
//
//  Created by M.Jabbar on 03/03/2020.
//

#import "DDFiltersThemeManager.h"

@implementation DDFiltersThemeM

@end
@implementation DDFiltersThemeManager
static DDFiltersThemeManager *_sharedObject;

+(DDFiltersThemeManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDFiltersThemeManager alloc]init];
    });
    return _sharedObject;
}
@end
