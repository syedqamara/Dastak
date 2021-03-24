//
//  DDMapsThemeManager.h
//  DDMapsUI
//
//  Created by Zubair Ahmad on 10/02/2020..
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDUI/DDUI.h>
NS_ASSUME_NONNULL_BEGIN


@interface DDMapsThemeM: DDUIThemeModel

@end


@interface DDMapsThemeManager : NSObject
@property (strong, nonatomic) DDMapsThemeM *selected_theme;
+(DDMapsThemeManager *)shared;

@end

NS_ASSUME_NONNULL_END
