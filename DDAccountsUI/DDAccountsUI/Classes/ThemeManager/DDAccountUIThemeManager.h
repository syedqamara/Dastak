//
//  DDAccountUIThemeManager.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//

#import <Foundation/Foundation.h>
#import "DDAccountUIThemeModel.h"
#import "UIFont+DDFont.h"
#import "NSString+DDString.h"
#import <DDUI/DDUI.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDAccountUIThemeManager : DDUIThemeManager
@property (strong, nonatomic) DDAccountUIThemeModel *selected_theme;
+(DDAccountUIThemeManager *)shared;
@end

NS_ASSUME_NONNULL_END
