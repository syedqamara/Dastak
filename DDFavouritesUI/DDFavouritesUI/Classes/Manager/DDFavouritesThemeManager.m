//
//  DDFavouritesThemeManager.m
//  DDFavourites
//
//  Created by M.Jabbar on 03/03/2020.
//

#import "DDFavouritesThemeManager.h"

@implementation DDFavouritesThemeM

@end
@implementation DDFavouritesThemeManager
static DDFavouritesThemeManager *_sharedObject;

+(DDFavouritesThemeManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDFavouritesThemeManager alloc]init];
    });
    return _sharedObject;
}
@end
