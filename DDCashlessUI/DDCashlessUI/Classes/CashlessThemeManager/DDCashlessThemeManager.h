//
//  DDCashlessThemeManager.h
//  DDCashlessUI
//
//  Created by Awais Shahid on 12/02/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDUI.h>

#define CASHLESS_THEME DDCashlessThemeManager.shared.selected_theme

NS_ASSUME_NONNULL_BEGIN

@interface DDCashlessThemeM: DDUIThemeModel
@property (strong, nonatomic) NSString <Optional> *outlet_online_dot;
@property (strong, nonatomic) NSString <Optional> *outlet_offline_dot;
@property (strong, nonatomic) NSString <Optional> *settings_header_icon;
@property (strong, nonatomic) NSString <Optional> *text_green_136;
@property (strong, nonatomic) NSString <Optional> *text_orange_245;
@property (strong, nonatomic) NSString <Optional> *text_red_217;
@property (strong, nonatomic) NSString <Optional> *text_yellow_255;


@end



@interface DDCashlessThemeManager : DDUIThemeManager
@property (strong, nonatomic) DDCashlessThemeM *selected_theme;
+(DDCashlessThemeManager *)shared;

@end

NS_ASSUME_NONNULL_END
