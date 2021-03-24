//
//  UIView+DDSEView.m
//  AFNetworking
//
//  Created by Adnan Ahmad Janjua on 11/29/18.
//

#import "UIView+DDView.h"
#import "UIColor+DDColor.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "NSBundle+DDNSBundle.h"


@implementation UIView (DDView)

static char UIView_PlaceHolder_KEY;
static char UIView_GradientLayer_KEY;
static char UIView_startLocations_KEY;
static char UIView_endLocations_KEY;
static char UIView_gradientBackgroundColor_KEY;
static char UIView_gradientMovingColor_KEY;
static char UIView_movingAnimationDuration_KEY;
static char UIView_delayBetweenAnimationLoops_KEY;

@dynamic placeHolder;

-(void)layoutSubviews{
    [self startAnimating];
}

-(void)setPlaceHolder:(BOOL)placeHolder{
    [self startAnimating];
    self.holder = @(placeHolder);
    
    if (placeHolder) {
        [self startAnimating];
    }else{
        [self endAnimation];
    }
}
-(void)setHolder:(NSNumber *)holder{
    objc_setAssociatedObject(self, &UIView_PlaceHolder_KEY, holder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSNumber*)holder{
    return (NSNumber*)objc_getAssociatedObject(self, &UIView_PlaceHolder_KEY);
}
-(void)setGradientLayer:(CAGradientLayer *)gradientLayer{
    objc_setAssociatedObject(self, &UIView_GradientLayer_KEY, gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CAGradientLayer *)gradientLayer{
    return (CAGradientLayer*)objc_getAssociatedObject(self, &UIView_GradientLayer_KEY);
}
- (NSMutableArray<NSNumber *> *)startLocations{
    return (NSMutableArray<NSNumber *> *)objc_getAssociatedObject(self, &UIView_startLocations_KEY);
}
- (void)setStartLocations:(NSMutableArray<NSNumber *> *)startLocations{
    objc_setAssociatedObject(self, &UIView_startLocations_KEY, startLocations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSMutableArray<NSNumber *> *)endLocations{
    return (NSMutableArray<NSNumber *> *)objc_getAssociatedObject(self, &UIView_endLocations_KEY);
}
-(void)setEndLocations:(NSMutableArray<NSNumber *> *)endLocations{
    objc_setAssociatedObject(self, &UIView_endLocations_KEY, endLocations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)setGradientBackgroundColor:(UIColor *)gradientBackgroundColor{
    objc_setAssociatedObject(self, &UIView_gradientBackgroundColor_KEY, gradientBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIColor *)gradientBackgroundColor{
    return (UIColor*)objc_getAssociatedObject(self, &UIView_gradientBackgroundColor_KEY);
}
-(void)setGradientMovingColor:(UIColor *)gradientMovingColor{
    objc_setAssociatedObject(self, &UIView_gradientMovingColor_KEY, gradientMovingColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIColor *)gradientMovingColor{
    return (UIColor*)objc_getAssociatedObject(self, &UIView_gradientMovingColor_KEY);
}
//-(CFTimeInterval)movingAnimationDuration{
//    return (CFTimeInterval)objc_getAssociatedObject(self, &UIView_gradientMovingColor_KEY);
//}
//-(void)setMovingAnimationDuration:(CFTimeInterval)movingAnimationDuration{
//    objc_setAssociatedObject(self, &UIView_gradientMovingColor_KEY, movingAnimationDuration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
-(void)startAnimating{
    
    if (self.holder.boolValue) {
        if (self.gradientLayer) {
            [self endAnimation];
        }
        self.startLocations = self.startLocations ?: [[NSMutableArray alloc] initWithArray:@[@-1.0,@-0.5, @0.0]];
        self.endLocations = self.endLocations ?: [[NSMutableArray alloc] initWithArray:@[@1.0,@1.5, @2.0]];
      
        CAGradientLayer *gradiantMask = [CAGradientLayer layer];
        gradiantMask.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        gradiantMask.bounds = CGRectMake(0.0, 0.0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        gradiantMask.colors = [NSArray arrayWithObjects:(id)[UIColor DDcolorFromHexString:@"c7c7c7"].CGColor, (id)[UIColor whiteColor].CGColor,(id)[UIColor DDcolorFromHexString:@"c7c7c7"].CGColor, nil];
        gradiantMask.startPoint = CGPointMake(0.0, 1.0);
        gradiantMask.endPoint = CGPointMake(1.0, 1.0);

//        self.layer.mask = gradiantMask;
        self.gradientLayer = gradiantMask;
        self.gradientLayer.locations = self.startLocations;
        [self.layer addSublayer:self.gradientLayer];
        //        self.gradientLayer = gradiantMask;
        
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
        animation.fromValue = self.startLocations;
        animation.toValue = self.endLocations;
        animation.duration = 0.8;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
        
        animationGroup.duration = 0.8 + 1.0; //self.movingAnimationDuration + self.delayBetweenAnimationLoops;
        animationGroup.animations = @[animation];
        animationGroup.repeatCount = INFINITY;
        [self.gradientLayer addAnimation:animationGroup forKey:animation.keyPath];
    }
}
-(void)endAnimationForViews:(NSArray<UIView*>*)views{

    for (UIView *view in views) {
//        if([self.subviews containsObject:view]){//view.holder.boolValue){
            [view setPlaceHolder:NO];
            view.layer.mask = nil;
//        }
    }
}
-(void)endAnimation{
    if (self.gradientLayer) {
        [self.gradientLayer removeAllAnimations];
        [self.gradientLayer removeFromSuperlayer];
        self.layer.mask = nil;
    }
}
- (void)DDTRViewRadius:(float)radius andColor:(UIColor *)color {
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 0.8;
    self.clipsToBounds = NO;
}

-(void)rotateViewUpward:(BOOL)isOpen withDuration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        if (isOpen) {
            self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
        }else {
            self.transform = CGAffineTransformIdentity;
        }
    }];
}

- (void)setCornerR:(CGFloat)cornerR {
    self.layer.cornerRadius = cornerR;
    //please do not use bellow line here for drawing shadow on rounded view
//    self.clipsToBounds = YES;
    //self.clipsToBounds = YES; // developer needs to do it manually. this is because of shadow and corner at a time.
}

- (void)setBorderW:(CGFloat)borderW {
    self.layer.borderWidth = borderW;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = [borderColor CGColor];
}

- (void)setCircle:(BOOL)circle {
    if (circle) {
        self.layer.cornerRadius = circle ? self.bounds.size.height/2 : 0;
    }
    self.clipsToBounds = YES;
    //self.clipsToBounds = circle; // developer needs to do it manually. this is because of shadow and corner at a time.
}

- (BOOL)circle {
    return self.layer.cornerRadius * 2 == self.bounds.size.height;
}
-(void)setShadowSize:(CGSize)shadowSize {
    if (shadowSize.width != 0 || shadowSize.height != 0) {
        self.layer.shadowOffset = shadowSize;
    }else {
        self.layer.shadowOffset = CGSizeZero;
    }
}
-(void)setShadowRadius:(CGFloat)shadowRadius {
    if (shadowRadius > 0) {
        self.layer.shadowRadius = shadowRadius;
    }
}
-(void)setShadowOpacity:(CGFloat)shadowOpacity {
    if (shadowOpacity > 0) {
        self.layer.shadowOpacity = shadowOpacity;
    }
}

- (void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
}

- (void)setShadowWithCorner:(BOOL)shadowWithCorner {
    if (!shadowWithCorner) return;
    
    UIView *shadowView = [[UIView alloc] init];
    shadowView.layer.shadowOpacity = 0.4;
    shadowView.layer.shadowOffset = CGSizeMake(0, 0);
    shadowView.layer.shadowRadius = 3; //spread
    shadowView.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    
    shadowView.backgroundColor = [UIColor blueColor];
    self.backgroundColor = [UIColor redColor];
    
    shadowView.clipsToBounds = NO;
    shadowView.layer.cornerRadius = 61;
    self.clipsToBounds = YES;
    //
    ////    [self.superview addSubview:shadowView];
    ////    [self.superview sendSubviewToBack:shadowView];
    //
    //    [self addSubview:shadowView];
    //    shadowView.center = self.center;
    //    shadowView.frame = self.frame;
    //
    //    [shadowView setNeedsLayout];
    //    [shadowView layoutIfNeeded];
}

- (void)setShadow:(BOOL)shadow {
    if (!shadow) return;
    self.layer.shadowOpacity = shadow ? 1.0 : 0.1;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = shadow ? 4 : 0; //spread
    self.layer.shadowColor = shadow ? [[UIColor DDLineBorderShadowColor] CGColor] : [[UIColor clearColor] CGColor];
}
-(void)clearConstraints{
    for (UIView *subView in self.subviews) {
        [subView clearConstraints];
    }
    [self removeConstraints:self.constraints];
}
-(void)centerInSuperview{
    [self centerHorizontallyInSuperview:0];
    [self centerVerticallyInSuperview:0];
    [self setNeedsLayout];
}
- (void)equalAndCenterToSupper{
    
    [self centerVerticallyInSuperview:0];
    [self centerHorizontallyInSuperview:0];
    [self leadingInSuperview:0];
    [self trailingInSuperview:0];
    [self topInSuperview:0];
    [self bottomInSuperview:0];
    [self setNeedsLayout];
}
- (void)equalToView:(CGFloat)constant{
    
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-0-[subview]-%f-|", constant] options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"subview" : self}]];
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[subview]-%f-|", constant] options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"subview" : self}]];
}
-(void)centerHorizontallyInSuperview:(CGFloat)constant{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:constant];
    [self.superview addConstraint:constraint];
}
- (void)centerVerticallyInSuperview:(CGFloat)constant{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:constant];
    [self.superview addConstraint:constraint];
}
- (void)leadingInSuperview:(CGFloat)constant{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:constant];
    [self.superview addConstraint:constraint];
}
- (void)trailingInSuperview:(CGFloat)constant{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:constant];
    [self.superview addConstraint:constraint];
}
- (void)topInSuperview:(CGFloat)constant{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1 constant:constant];
    [self.superview addConstraint:constraint];
}
- (void)bottomInSuperview:(CGFloat)constant{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:constant];
    [self.superview addConstraint:constraint];
}
- (void)heightConstraint:(CGFloat)constant{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:constant];
    [self.superview addConstraint:constraint];
}
- (void)widthConstraint:(CGFloat)constant{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:constant];
    [self.superview addConstraint:constraint];
}
-(void)roundCorners: (UIRectCorner) corners radius:(CGFloat)radius {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    mask.path = path.CGPath;
    self.layer.mask = mask;
}
-(void)rotateBy90 {
    self.transform = CGAffineTransformMakeRotation(M_PI_2);
}

-(void)rotateBy180:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}
-(void)resetRotation:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}
-(void)reset {
    self.transform = CGAffineTransformIdentity;
}
@end
