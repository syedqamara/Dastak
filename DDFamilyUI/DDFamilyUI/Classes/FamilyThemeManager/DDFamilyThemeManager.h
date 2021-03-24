//
//  DDFamilyThemeManager.h
//  DDFamilyUI
//
//  Created by Awais Shahid on 27/01/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDUI.h>
NS_ASSUME_NONNULL_BEGIN

#define FAMILY_THEME DDFamilyThemeManager.shared.selected_theme

@interface DDFamilyThemeM: DDUIThemeModel
@property (strong, nonatomic) NSString <Optional> *app_grouped_table_235;
@property (strong, nonatomic) NSString <Optional> *subtitle_blue_219;

@property (strong, nonatomic) NSString <Optional> *bg_tile_blue;
@property (strong, nonatomic) NSString <Optional> *bg_tile_orange;
@end


@interface DDFamilyThemeManager : NSObject
@property (strong, nonatomic) DDFamilyThemeM *selected_theme;
+(DDFamilyThemeManager *)shared;
@end

NS_ASSUME_NONNULL_END
