//
//  DDOutletsThemeManager.h
//  DDOutlets
//
//  Created by Zubair Ahmad on 21/01/2020..
//  Copyright © 2020 The Entertainer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDUI/DDUI.h>
NS_ASSUME_NONNULL_BEGIN

#define OUTLETS_THEME DDOutletsThemeManager.shared.selected_theme

@interface DDOutletsThemeM: DDUIThemeModel
@property (strong, nonatomic) NSString <Optional> *app_grey_248;
@property (strong, nonatomic) NSString <Optional> *text_cuisineType;
@end


@interface DDOutletsThemeManager : NSObject
@property (strong, nonatomic) DDOutletsThemeM *selected_theme;
+(DDOutletsThemeManager *)shared;

@end

NS_ASSUME_NONNULL_END
