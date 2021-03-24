//
//  DDPingsThemeManager.h
//  DDPings
//
//  Created by Hafiz Aziz on 29/01/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import "DDUI.h"
NS_ASSUME_NONNULL_BEGIN

#define PINGS_THEME DDPingsThemeManager.shared.selected_theme

@interface DDPingsThemeM: DDUIThemeModel
@property (strong, nonatomic) NSString <Optional> *app_header_messageBG;
@end


@interface DDPingsThemeManager : NSObject
@property (strong, nonatomic) DDPingsThemeM *selected_theme;
+(DDPingsThemeManager *)shared;
@end

NS_ASSUME_NONNULL_END
