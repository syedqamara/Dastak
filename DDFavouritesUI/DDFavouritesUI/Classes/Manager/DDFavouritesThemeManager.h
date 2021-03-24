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

@interface DDFavouritesThemeM: DDUIThemeModel
@property (strong, nonatomic) NSString <Optional> *app_grouped_table_235;
@end

@interface DDFavouritesThemeManager : NSObject
@property (strong, nonatomic) DDFavouritesThemeM *selected_theme;
+(DDFavouritesThemeManager *)shared;
@end

NS_ASSUME_NONNULL_END

