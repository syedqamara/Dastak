//
//  DDThemeTabBarController.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//

#import <UIKit/UIKit.h>
#import "DDNavigationProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDUIThemeTabBarController : UITabBarController <DDNavigationProtocol>
@property (strong, nonatomic) DDUIRouterInfoM *navigation;
-(void)didAddedToWindow;
@end

NS_ASSUME_NONNULL_END
