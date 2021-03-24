//
//  DDLocationsThemeManager.h
//  DDLocationsUI
//
//  Created by Zubair Ahmad on 21/01/2020..
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDUI/DDUI.h>

NS_ASSUME_NONNULL_BEGIN

#define LOCATION_THEME DDLocationsThemeManager.shared.selected_theme


@interface DDLocationsThemeM: DDUIThemeModel
@property (strong, nonatomic) NSString <Optional> *border_grey_175;
@property (strong, nonatomic) NSString <Optional> *snack_bar_40;
@end


@interface DDLocationsThemeManager : NSObject
@property (strong, nonatomic) DDLocationsThemeM *selected_theme;
+(DDLocationsThemeManager *)shared;

@end

NS_ASSUME_NONNULL_END
