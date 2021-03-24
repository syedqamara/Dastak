//
//  DDCategoriesPopupView.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 06/02/2020.
//

#import <UIKit/UIKit.h>
#import "DDAnimatedHorizontalView.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDCategoriesPopupView : UIView
+(void)showCategoriesFromView:(UIView *)view withDataSource:(NSArray<DDCategoriesPopupVM *> *)categories andCompletion:(void (^)(NSInteger selectedIndex))completion;

@end

NS_ASSUME_NONNULL_END
