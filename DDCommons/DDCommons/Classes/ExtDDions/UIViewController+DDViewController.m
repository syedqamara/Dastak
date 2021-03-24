//
//  UIViewController+DDSEViewController.m
//  DDSE_Example
//
//  Created by Raheel on 06/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//

extern const struct DDNavigationApps
{
    __unsafe_unretained NSString *appleMaps;
    __unsafe_unretained NSString *googleMaps;
    __unsafe_unretained NSString *hereWeGo;
    
} navigationApps;

const struct DDNavigationApps navigationApps =
{
    .appleMaps = @"Maps",
    .googleMaps = @"Google Maps",
    .hereWeGo = @"Cancel"
};

#import "UIViewController+DDViewController.h"
#import "NSBundle+DDNSBundle.h"
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
//#import "DDSEAlertUtil.h"
//#import "DDSEConst.h"
//#import "DDSEControllers.h"

@implementation UIViewController (DDViewController)


-(instancetype) initWithNibName:(NSString *) name forClass:(Class)cls {
    NSBundle *bundle = [NSBundle getNibBundle:cls];
    NSString *className = [NSString stringWithFormat:@"%@.nib",NSStringFromClass(cls)];
    NSArray <NSString *> *fileNames = [NSFileManager.defaultManager contentsOfDirectoryAtPath:bundle.bundleURL.path error:NULL];
    if ([fileNames containsObject:className]) {
        return [self initWithNibName:name bundle:bundle];
    }
    return [self init];
}

-(void) openMapForLocation:(double) clatitude longitude:(double) clongitude mlatitude:(double) mlatitude mlongitude:(double) mlongitude title:(NSString *) title {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"Choose a map to view the route" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:navigationApps.appleMaps style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{
            CLLocationCoordinate2D mosqueLocation = CLLocationCoordinate2DMake(mlatitude,mlongitude);
            
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:mosqueLocation addressDictionary:nil];
            MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
            item.name = title;
            NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
            [item openInMapsWithLaunchOptions:options];
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:navigationApps.googleMaps style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?saddr=&daddr=%f,%f&directionsmode=driving",clatitude,clongitude]];
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            } else {
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.co.in/maps/dir/?saddr=&daddr=%f,%f&directionsmode=driving",clatitude,clongitude]];
                [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
            }
        }];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:navigationApps.hereWeGo style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // OK button tapped.
        
        //[self dismissViewControllerAnimated:YES completion:^{
        //}];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];

}

-(void) presentRegisterationProcessWithCompletionCallBack:(void (^)(BOOL))callBack {
//    [UIApplication showDDLoaderAnimation];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [[DDSEControllers sharedInstance] showLoginEmailViewController:DDSEPRESDD obj:nil controller:self isNavigationController:TRUE deeplink_model:nil callBack:^(DDSEAPICommonModel * data, UIViewController * _Nonnull controller) {
//            callBack(TRUE);
//        } completionAfterControllerPresented:^{
//            [UIApplication dismissDDLoaderAnimation];
//        }];
//    });
}
-(void)dismissAllViewControllers {
    while (self.presentingViewController != nil) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
-(UIViewController *)getViewControllerByClass:(Class)cls {
    UITabBarController *tabVC = (UITabBarController *)self;
    UIViewController *selectedVC;
    for (UIViewController *vc in tabVC.viewControllers) {
        if ([vc isKindOfClass:cls]) {
            NSInteger index = [tabVC.viewControllers indexOfObject:vc];
            [tabVC setSelectedIndex:index];
            selectedVC = vc;
            break;
        }
        else if ([vc isKindOfClass:UINavigationController.class]) {
            UIViewController *rootVC = ((UINavigationController *)vc).viewControllers.firstObject;
            if ([rootVC isKindOfClass:cls]) {
                NSInteger index = [tabVC.viewControllers indexOfObject:vc];
                [tabVC setSelectedIndex:index];
                selectedVC = rootVC;
                break;
            }
        }
    }
    return selectedVC;
}
-(BOOL)addViewControllerToTabbar:(UIViewController *)viewController  {
    UITabBarController *tabVC = (UITabBarController *)self;
    BOOL isAdded = NO;
    if (tabVC != nil) {
        isAdded = YES;
        NSMutableArray <UIViewController *> *controllers = tabVC.viewControllers.mutableCopy;
        if (controllers == nil) {
            controllers = [NSMutableArray new];
        }
        for (UIViewController *controller in controllers) {
            UINavigationController *prevNavVC = (UINavigationController *)controller;
            UINavigationController *newNavVC = (UINavigationController *)viewController;
            if (prevNavVC != nil && newNavVC != nil) {
                if ([prevNavVC.viewControllers.firstObject isKindOfClass:newNavVC.viewControllers.firstObject.class]) {
                    NSInteger index = [controllers indexOfObject:controller];
                    [controllers replaceObjectAtIndex:index withObject:newNavVC];
                    [controllers removeObject:prevNavVC];
                    [tabVC setViewControllers:controllers animated:NO];
                    return YES;
                }
            }
        }
        [controllers addObject:viewController];
        [tabVC setViewControllers:controllers animated:NO];
    }
    return isAdded;
}
-(void)addChildViewController:(UIViewController *)controller inContainerView:(UIView *)containerView {
    [controller willMoveToParentViewController:self];
    controller.view.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:controller.view];
    
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:controller.view attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:containerView attribute:(NSLayoutAttributeTop) multiplier:1.0 constant:0]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:controller.view attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:containerView attribute:(NSLayoutAttributeLeading) multiplier:1.0 constant:0]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:controller.view attribute:(NSLayoutAttributeTrailing) relatedBy:(NSLayoutRelationEqual) toItem:containerView attribute:(NSLayoutAttributeTrailing) multiplier:1.0 constant:0]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:controller.view attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:containerView attribute:(NSLayoutAttributeBottom) multiplier:1.0 constant:0]];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
}
-(void)changeDraggableContainerHeight:(CGFloat)height animationDuration:(NSTimeInterval)duration {
    NSAssert(false, @"Do not use this method. This is only used by DDDragableVC");
}
@end
