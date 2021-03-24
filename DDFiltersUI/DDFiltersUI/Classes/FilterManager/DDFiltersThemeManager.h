//
//  DDFavouritesThemeManager.h
//  DDFavourites
//
//  Created by M.Jabbar on 03/03/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDFiltersThemeM: DDUIThemeModel
@end

@interface DDFiltersThemeManager : NSObject
@property (strong, nonatomic) DDFiltersThemeM *selected_theme;
+(DDFiltersThemeManager *)shared;
@end

NS_ASSUME_NONNULL_END

