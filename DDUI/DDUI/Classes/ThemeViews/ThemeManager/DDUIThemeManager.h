//
//  DDUIThemeManager.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//

#import <Foundation/Foundation.h>
#import "DDUIThemeModel.h"
NS_ASSUME_NONNULL_BEGIN


#define THEME DDUIThemeManager.shared.selected_theme

@interface DDUIThemeManager : NSObject
@property (strong, nonatomic) DDUIThemeModel *selected_theme;
@property (strong, nonatomic) NSString *lightFontName;
@property (strong, nonatomic) NSString *regularFontName;
@property (strong, nonatomic) NSString *mediumFontName;
@property (strong, nonatomic) NSString *semiBoldFontName;
@property (strong, nonatomic) NSString *boldFontName;
@property (strong, nonatomic) NSString *heavyFontName;

+(DDUIThemeManager *)shared;

+(NSInteger)selectedTheme;
+(void)setSelectedTheme:(NSInteger)type;

+(void)themeIsChanged;
+(void)shouldLoadNewTheme;

+(NSString *)theme_changed_notification_name;
+(NSString *)load_new_theme_notification_name;
+(NSString *)current_saved_theme_key_name;
@end

NS_ASSUME_NONNULL_END
