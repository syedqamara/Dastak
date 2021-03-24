//
//  UIWindow+RootVC.m
//  DDCommons
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "UIWindow+RootVC.h"

@implementation UIWindow (RootVC)
-(void)setNewRootVC:(UIViewController *)vc {
    self.rootViewController = nil;
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    self.rootViewController = vc;
}
@end
