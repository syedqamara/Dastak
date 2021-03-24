//
//  UIViewController+DDSEViewController.h
//  DDSE_Example
//
//  Created by Raheel on 06/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (DDViewController)

-(instancetype) initWithNibName:(NSString *) name forClass:(Class)cls;
-(void) openMapForLocation:(double) clatitude longitude:(double) clongitude mlatitude:(double) mlatitude mlongitude:(double) mlongitude title:(NSString *) title;
-(void) presentRegisterationProcessWithCompletionCallBack:(void (^)(BOOL))callBack;
-(void)dismissAllViewControllers;
-(UIViewController *)getViewControllerByClass:(Class)cls;
-(BOOL)addViewControllerToTabbar:(UIViewController *)viewController ;
-(void)addChildViewController:(UIViewController *)controller inContainerView:(UIView *)containerView;
-(void)changeDraggableContainerHeight:(CGFloat)height animationDuration:(NSTimeInterval)duration;
@end

NS_ASSUME_NONNULL_END
