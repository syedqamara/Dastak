//
//  DDSearchUIThemeManager.h
//  DDSearchUI
//
//  Created by Syed Qamar Abbas on 10/02/2020.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "DDUI.h"
NS_ASSUME_NONNULL_BEGIN

#define SEARCH_THEME DDSearchUIThemeManager.shared.selected_theme

@interface DDSearchUIThemeM: DDUIThemeModel
@end


@interface DDSearchUIThemeManager : NSObject
@property (strong, nonatomic) DDSearchUIThemeM *selected_theme;
+(DDSearchUIThemeManager *)shared;

@end
NS_ASSUME_NONNULL_END
