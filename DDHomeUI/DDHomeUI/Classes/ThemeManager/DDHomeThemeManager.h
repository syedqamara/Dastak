//
//  DDHomeThemeManager.h
//  DDHome
//
//  Created by Zubair Ahmad on 21/01/2020..
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import "DDUI.h"
NS_ASSUME_NONNULL_BEGIN

#define HOME_THEME DDHomeThemeManager.shared.selected_theme

@interface DDHomeThemeM: DDUIThemeModel
@property (strong, nonatomic) NSString <Optional> *top_saving_container_bg;
@property (strong, nonatomic) NSString <Optional> *trip_advisor_bg;
@end


@interface DDHomeThemeManager : NSObject
@property (strong, nonatomic) DDHomeThemeM *selected_theme;
+(DDHomeThemeManager *)shared;
@end

NS_ASSUME_NONNULL_END
