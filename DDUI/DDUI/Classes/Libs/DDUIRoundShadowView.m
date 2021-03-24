//
//  DDUIRoundShadowView.m
//  The dynamicdelivery
//
//  Created by Syed Qamar Abbas on 4/30/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import "DDUIRoundShadowView.h"

@interface DDUIRoundShadowView () {
    CGFloat width;
    CGFloat radius;
    UIColor *border;
    CAShapeLayer *roundLayer;
    BOOL shouldAdd;
    UIColor *actualBackgroundColor;
}
@end
@implementation DDUIRoundShadowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setBorderColor:(UIColor *)borderColor{
    border = borderColor;
    [self setDesignableViewArguments];
}
-(void)setBorderWidth:(CGFloat)borderWidth {
    width = borderWidth;
    [self setDesignableViewArguments];
}
-(void)setCornerRadius:(CGFloat)cornerRadius {
    radius = cornerRadius;
    [self setDesignableViewArguments];
}
-(void)setShouldAddSubLayer:(BOOL)shouldAddSubLayer {
    shouldAdd = shouldAddSubLayer;
    [self setDesignableViewArguments];
}
-(void)setBackgroundColor:(UIColor *)backgroundColor {
    actualBackgroundColor = backgroundColor;
    if (shouldAdd) {
        roundLayer.fillColor = backgroundColor.CGColor;
        super.backgroundColor = UIColor.clearColor;
    }else {
        super.backgroundColor = backgroundColor;
    }
}
-(UIColor *)backgroundColor {
    return actualBackgroundColor;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    [self setDesignableViewArguments];
}
-(void)setDesignableViewArguments {
    if (shouldAdd) {
        [roundLayer removeFromSuperlayer];
        roundLayer = nil;
        if (roundLayer == nil) {
            roundLayer = [CAShapeLayer layer];
            [self layoutIfNeeded];
            roundLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:self.cornerRadius].CGPath;
            roundLayer.fillColor = actualBackgroundColor.CGColor;
            [self.layer insertSublayer:roundLayer atIndex:0];
        }
        roundLayer.strokeColor = border.CGColor;
        [self resetParentBorders];
    }else {
        
        [self.layer setCornerRadius:radius];
        [self.layer setBorderColor:border.CGColor];
        [self.layer setBorderWidth:width];
        [self.layer setMasksToBounds:YES];
    }
    
}
-(void)resetParentBorders {
    [self.layer setCornerRadius:0];
    [self.layer setBorderColor:UIColor.clearColor.CGColor];
    [self.layer setBorderWidth:0];
}
@end

@interface DDUIRoundButton () {
    CGFloat width;
    CGFloat radius;
    UIColor *border;
    CAShapeLayer *roundLayer;
    BOOL shouldAdd;
    UIColor *actualBackgroundColor;
}
@end

@implementation DDUIRoundButton
-(void)setBorderColor:(UIColor *)borderColor{
    border = borderColor;
    [self setDesignableViewArguments];
}
-(void)setBorderWidth:(CGFloat)borderWidth {
    width = borderWidth;
    [self setDesignableViewArguments];
}
-(void)setCornerRadius:(CGFloat)cornerRadius {
    radius = cornerRadius;
    [self setDesignableViewArguments];
}
-(void)setShouldAddSubLayer:(BOOL)shouldAddSubLayer {
    shouldAdd = shouldAddSubLayer;
    [self setDesignableViewArguments];
}
-(void)setBackgroundColor:(UIColor *)backgroundColor {
    actualBackgroundColor = backgroundColor;
    if (shouldAdd) {
        roundLayer.fillColor = backgroundColor.CGColor;
        super.backgroundColor = UIColor.clearColor;
    }else {
        super.backgroundColor = backgroundColor;
    }
}
-(UIColor *)backgroundColor {
    return actualBackgroundColor;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    [self setDesignableViewArguments];
}
-(void)setDesignableViewArguments {
    if (shouldAdd) { 
        [roundLayer removeFromSuperlayer];
        roundLayer = nil;
        if (roundLayer == nil) {
            roundLayer = [CAShapeLayer layer];
            [self layoutIfNeeded];
            roundLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:self.layer.bounds.size.height/2].CGPath;
            roundLayer.fillColor = UIColor.systemPinkColor.CGColor;
            [self.layer addSublayer:roundLayer];
        }
        roundLayer.strokeColor = border.CGColor;
        [self resetParentBorders];
    }else {
        
        [self.layer setCornerRadius:radius];
        [self.layer setBorderColor:border.CGColor];
        [self.layer setBorderWidth:width];
        [self.layer setMasksToBounds:YES];
    }
    
}
-(void)resetParentBorders {
    [self.layer setCornerRadius:0];
    [self.layer setBorderColor:UIColor.clearColor.CGColor];
    [self.layer setBorderWidth:0];
}
@end
