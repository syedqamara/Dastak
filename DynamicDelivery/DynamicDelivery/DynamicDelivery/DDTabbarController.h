//
//  DDTabbarController.h
//  dynamicdelivery_Example
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import <DDUI/DDUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDTabbarController : DDUIThemeTabBarController
+(void)createNewTabbar;
+(NSArray <DDUIRouterM *>*)deeplinkRoutes;
@end

NS_ASSUME_NONNULL_END
