//
//  DDRedemptionsThemeManager.h
//  DDRedemptionsUI
//
//  Created by Hafiz Aziz on 12/02/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDUI.h>
NS_ASSUME_NONNULL_BEGIN


@interface DDRedemptionsThemeM: DDUIThemeModel
@property (strong, nonatomic) NSString <Optional> *app_header_messageBG;
@property (strong, nonatomic) NSString <Optional> *text_green_136;
@end


@interface DDRedemptionsThemeManager : NSObject
@property (strong, nonatomic) DDRedemptionsThemeM *selected_theme;
+(DDRedemptionsThemeManager *)shared;
@end

NS_ASSUME_NONNULL_END
