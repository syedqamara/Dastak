//
//  DDNavigationView.m
//  DDUI
//
//  Created by M.Jabbar on 03/03/2020.
//

#import "DDNavigationView.h"

@implementation DDNavigationView

+ (DDNavigationView *)loadNavigationView:(UIView*)container {
    DDNavigationView *view = [DDNavigationView nibInstanceOfClass:DDNavigationView.class];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:view];
    [view equalToView:0];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:52];
    [view.superview addConstraint:constraint];
    view.viewHeight = constraint;
    return view;
}

@end
