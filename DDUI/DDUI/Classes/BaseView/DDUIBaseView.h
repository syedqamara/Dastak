//
//  DDUIBaseView.h
//  DDUI
//
//  Created by Zubair Ahmad on 28/01/2020.
//

#import <UIKit/UIKit.h>
#import "DDUIThemeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDUIBaseView : DDUIThemeView
+ (id)nibInstanceOfClass:(Class) className;

+ (id)nibInstanceOfClass:(Class) className atIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
