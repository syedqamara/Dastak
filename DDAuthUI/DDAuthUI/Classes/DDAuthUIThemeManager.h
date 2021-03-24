//
//  DDAuthThemeManager.h
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDUI.h>
NS_ASSUME_NONNULL_BEGIN

#define AUTH_THEME DDAuthUIThemeManager.shared.selected_theme

@interface DDAuthUIThemeM: DDUIThemeModel

@end


@interface DDAuthUIThemeManager : NSObject
@property (strong, nonatomic) DDAuthUIThemeM *selected_theme;
+(DDAuthUIThemeManager *)shared;

@end

NS_ASSUME_NONNULL_END
