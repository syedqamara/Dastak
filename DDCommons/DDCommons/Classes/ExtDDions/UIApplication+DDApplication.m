//
//  UIApplication+DDApplicatio.m
//  DDSE_Example
//
//  Created by Raheel on 06/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//



#import "UIApplication+DDApplication.h"
#import "DDUILottieAnimationManager.h"
#import "DDConstants.h"
#import "Reachability.h"
#import "SVProgressHUD.h"
#import "NSString+DDString.h"

//#import "DDSEConst.h"
//#import "DDSEReachability.h"

@interface LoaderView: UIView

@end
@implementation LoaderView


@end


@implementation UIApplication (DDApplication)

+(UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    if([topController isKindOfClass:[UIAlertController class]]){
        topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    
    return topController;
}

+ (UIViewController*)visibleController {
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [[UIApplication sharedApplication] topViewControllerWithRootViewController:root];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

+(BOOL) isLessTheniOS11{
//    if (SYSTEM_VERSION_LESS_THAN(@"11")){
//        return true;
//    }
    return false;
}

-(void)showLoaderView {
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//    [SVProgressHUD show];
    
    LoaderView *loaderContainer;
    for (UIView *view in DDUILottieAnimationManager.shared.applicationWindow.subviews) {
        if ([view isKindOfClass:LoaderView.class]) {
            view.tag++;
            loaderContainer = (LoaderView *)view;
            break;
        }
    }
    if (loaderContainer == nil) {
        loaderContainer = [LoaderView.alloc initWithFrame:UIScreen.mainScreen.bounds];
        loaderContainer.tag = 1;
        loaderContainer.backgroundColor = [UIColor.darkGrayColor colorWithAlphaComponent:0.5];
        [DDUILottieAnimationManager.shared.applicationWindow addSubview:loaderContainer];
        CGFloat width = UIScreen.mainScreen.bounds.size.height/2;//Hard code the width, P.S width & height is same
        width = 90;
        CGFloat xAxis = CGRectGetMidX(UIScreen.mainScreen.bounds) - width/2;
        CGFloat yAxis = CGRectGetMidY(UIScreen.mainScreen.bounds) - width/2;
        UIView *subview = [UIView.alloc initWithFrame:CGRectMake(xAxis, yAxis, width, width)];
        subview.backgroundColor = UIColor.clearColor;
        subview.layer.cornerRadius = width/2;
        subview.clipsToBounds = YES;
        //Send this subView to Lottie Manager for Animation
        [DDUILottieAnimationManager.shared setupLoaderAnimationFor:subview];
        [loaderContainer addSubview:subview];
        [DDUILottieAnimationManager.shared startAnimation];
    }
}
-(void)hideLoaderView {
//    [SVProgressHUD popActivity];
    LoaderView *loaderContainer;
    for (UIView *view in DDUILottieAnimationManager.shared.applicationWindow.subviews) {
        if ([view isKindOfClass:LoaderView.class]) {
            view.tag--;
            loaderContainer = (LoaderView *)view;
            break;
        }
    }
    if (loaderContainer.tag == 0) {
        [loaderContainer removeFromSuperview];
    }
}
+(void) showDDLoaderAnimation {
    [UIApplication.sharedApplication showLoaderView];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//    [SVProgressHUD show];
}
+(BOOL)isHUDVisible {
    BOOL isAvailable = NO;
    for (UIView *view in DDUILottieAnimationManager.shared.applicationWindow.subviews) {
        if ([view isKindOfClass:LoaderView.class]) {
            isAvailable = YES;
            break;
        }
    }
    return isAvailable;
}

+(void) dismissDDLoaderAnimation {
    [UIApplication.sharedApplication hideLoaderView];
//    [SVProgressHUD popActivity];
//    if ([SVProgressHUD isVisible]){
//        [SVProgressHUD dismiss];
//    }
}
+(BOOL)isInternetConnected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reachability currentReachabilityStatus];
    if (status == NotReachable){
        return false;
    }
    return true;
}


+ (void)refreshAppWithParams:(NSDictionary * _Nullable)params {
    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_CONTROLLER_NOTIFICATION object:nil userInfo:params];
}

+ (BOOL) isRightToLeftDeviceSettings {
    if ([NSString.deviceLanguage.lowercaseString isEqualToString:@"ar"]) {
        return YES;
    }
    return NO;
}
@end
