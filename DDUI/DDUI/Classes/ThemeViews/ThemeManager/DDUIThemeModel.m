//
//  DDUIThemeModel.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//

#import "DDUIThemeModel.h"
#import <ChameleonFramework/Chameleon.h>
@implementation DDUIThemeModel
-(UIColor *)leftToRightAppThemeGradientForBound:(CGRect)rect {
    NSArray <UIColor *> *colors = @[self.app_theme.colorValue, self.app_theme_dark.colorValue];
    return [UIColor colorWithGradientStyle:(UIGradientStyleLeftToRight) withFrame:rect andColors:colors];
}
-(UIColor *)topToBottomAppThemeGradientForBound:(CGRect)rect {
    NSArray <UIColor *> *colors = @[self.app_theme.colorValue, self.app_theme_dark.colorValue];
    return [UIColor colorWithGradientStyle:(UIGradientStyleTopToBottom) withFrame:rect andColors:colors];
}
-(UIColor *)circularAppThemeGradientForBound:(CGRect)rect {
    NSArray <UIColor *> *colors = @[self.app_theme.colorValue, self.app_theme_dark.colorValue];
    return [UIColor colorWithGradientStyle:(UIGradientStyleRadial) withFrame:rect andColors:colors];
}
@end
