//
//  Autolayout.m
//  FloatingDemo
//
//  Created by Syed Qamar Abbas on 4/30/18.
//  Copyright © 2018 Syed Qamar Abbas. All rights reserved.
//

#import "Autolayout.h"

@interface Autolayout() {
    NSLayoutConstraint *currentConstraint;
}
@end
@implementation Autolayout

+(NSMutableArray <Autolayout *> *)addConstrainsToParentView:(UIView *)parentView andChildView:(UIView *)childView withConstraintTypeArray:(NSArray <NSNumber *>*)types andValues:(NSArray <NSNumber *>*)values {
    [childView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addSubview:childView];
    NSMutableArray <Autolayout *> *constraints = [NSMutableArray new];
    for (NSInteger index = 0; index < types.count; index++) {
        ConstraintType type = types[index].integerValue;
        CGFloat value = (CGFloat) values[index].floatValue;
        Autolayout *layout = [[Autolayout alloc] init];
        layout.type = type;
        layout.value = value;
        layout.childView = childView;
        layout.parentView = parentView;
        NSLayoutConstraint *contraint;
        if (type == AutolayoutHeight || type == AutolayoutWidth) {
            contraint = [NSLayoutConstraint constraintWithItem:childView attribute:[Autolayout getConstrainType:type] relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1.0 constant:value];
            [childView addConstraint:contraint];
        }else {
            if (type == AutolayoutBottom || type == AutolayoutRight) {
                value = value * -1.0;
            }
            contraint = [NSLayoutConstraint constraintWithItem:childView attribute:[Autolayout getConstrainType:type] relatedBy:(NSLayoutRelationEqual) toItem:parentView attribute:[Autolayout getConstrainType:type] multiplier:1.0 constant:value];
            [parentView addConstraint:contraint];
        }
        [layout setConstraint:contraint];
        [constraints addObject:layout];
    }
    return constraints;
}

+(NSMutableArray <Autolayout *> *)addConstrainsToRefView:(UIView *)parentView andChildView:(UIView *)childView withConstraintTypeArray:(NSArray <NSNumber *>*)types andValues:(NSArray <NSNumber *>*)values {
    [childView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSMutableArray <Autolayout *> *constraints = [NSMutableArray new];
    for (NSInteger index = 0; index < types.count; index++) {
        ConstraintType type = types[index].integerValue;
        CGFloat value = (CGFloat) values[index].floatValue;
        Autolayout *layout = [[Autolayout alloc] init];
        layout.type = type;
        layout.value = value;
        layout.childView = childView;
        layout.parentView = parentView;
        NSLayoutConstraint *contraint;
        if (type == AutolayoutHeight || type == AutolayoutWidth) {
            contraint = [NSLayoutConstraint constraintWithItem:childView attribute:[Autolayout getConstrainType:type] relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1.0 constant:value];
            [childView addConstraint:contraint];
        }else {
            NSLayoutAttribute reftAttr = [Autolayout getConstrainType:type];
            if (type == AutolayoutBottom || type == AutolayoutRight) {
                value = value * -1.0;
            }
            if (type == AutolayoutBottom) {
                reftAttr = NSLayoutAttributeTop;
            }else if (type == AutolayoutTop) {
                reftAttr = NSLayoutAttributeBottom;
            }
            contraint = [NSLayoutConstraint constraintWithItem:childView attribute:[Autolayout getConstrainType:type] relatedBy:(NSLayoutRelationEqual) toItem:parentView attribute:reftAttr multiplier:1.0 constant:value];
            [parentView.superview addConstraint:contraint];
        }
        [layout setConstraint:contraint];
        [constraints addObject:layout];
    }
    return constraints;
}

+(NSLayoutAttribute)getConstrainType:(ConstraintType) type {
    NSLayoutAttribute attr = NSLayoutAttributeTop;
    switch (type) {
        case AutolayoutHeight:
            attr = NSLayoutAttributeHeight;
            break;
        case AutolayoutWidth:
            attr = NSLayoutAttributeWidth;
            break;
        case AutolayoutTop:
            attr = NSLayoutAttributeTop;
            break;
        case AutolayoutBottom:
            attr = NSLayoutAttributeBottom;
            break;
        case AutolayoutLeft:
            attr = NSLayoutAttributeLeading;
            break;
        case AutolayoutRight:
            attr = NSLayoutAttributeTrailing;
            break;
        default:
            break;
    }
    return attr;
}
-(void)changeConstraintValue:(CGFloat)newValue {
    if (self.value != newValue) {
        self.value = newValue;
        currentConstraint.constant = newValue;
        [self.parentView.superview layoutIfNeeded];
    }
}
-(void)setConstraint:(NSLayoutConstraint *)constraint {
    currentConstraint = constraint;
    
}
@end


@implementation AutolayoutView

-(void)sampleUsage {
    NSArray *types = @[@(AutolayoutTop), @(AutolayoutBottom), @(AutolayoutLeft), @(AutolayoutRight)];
    NSArray *values = @[@(10), @(20), @(30), @(40)];
    AutolayoutView *cont;// This is your child view which should be inherit from AutolayoutView
    cont.allConstraints = [Autolayout addConstrainsToParentView:nil andChildView:nil withConstraintTypeArray:@[] andValues:@[]];
    Autolayout *layout = [cont getConstraintWithType:AutolayoutLeft];
    [layout changeConstraintValue:20];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint locationPoint = [[[touches allObjects] firstObject] locationInView:self];
    UIView* viewYouWishToObtain = [self hitTest:locationPoint withEvent:event];
    if (viewYouWishToObtain == self) {
        if (_delegate != nil && [_delegate respondsToSelector:@selector(didTouchThisView:)]) {
            [_delegate didTouchThisView:self];
        }
    }
}
-(Autolayout *)getConstraintWithType:(ConstraintType)type {
    Autolayout *layout;
    for (Autolayout *constraint in self.allConstraints) {
        if (type == constraint.type) {
            layout = constraint;
            break;
        }
    }
    return layout;
}
-(void)changeConstraintValue:(CGFloat)value ofType:(ConstraintType)type {
    Autolayout *layout = [self getConstraintWithType:type];
    [layout changeConstraintValue:value];
}
@end
