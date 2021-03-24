//
//  DDTagM.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 11/02/2020.
//

#import "DDTagM.h"

@implementation DDTagM

-(CGFloat)space {
    if (_space > 0) {
        return _space;
    }
    if (self.is_enabled) {
        return Space;
    }
    return 0.0;
}
-(UIFont *)font {
    if (self.is_selected) {
        return self.font_selected;
    }
    return self.font_normal;
}

-(void)calculateWidth {
    if (self.is_enabled) {
        if (!self.is_fix_width) {
            CGFloat normalWidth = [self widthOfString:self.title withFont:self.font_normal] + (self.space * 2);
            CGFloat selectedWidth = [self widthOfString:self.title withFont:self.font_selected] + (self.space * 2);
            if (normalWidth > selectedWidth) {
                self.width = normalWidth;
            }
            else {
                self.width = selectedWidth;
            }
        }
    }else {
        self.width = 0.0;
    }
    
}
- (CGFloat)widthOfString:(NSString *)text withFont:(UIFont *)textFont {
    if (!text) {
        return 0.0f;
    }
    CGFloat textHeight = self.height;
    CGSize boundingSize = CGSizeMake(CGFLOAT_MAX, textHeight);

    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text
                                                                         attributes:@{ NSFontAttributeName: textFont }];

    CGRect rect = [attributedText boundingRectWithSize:boundingSize
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize requiredSize = rect.size;
    return requiredSize.width;
}
-(void)toggleOffSelection {
    self.is_selected = NO;
//    [self animateWithIndex:1 withInitialScale:0.6];
}
-(void)toggleOnSelection {
    self.is_selected = YES;
    [self animateWithIndex:1.2 withInitialScale:1.2];
}
-(void)layoutSubView {
    if (self.is_selected) {
        self.label.textColor = self.title_color_selected;
    }else {
        self.label.textColor = self.title_color_normal;
    }
    self.view.backgroundColor = self.backgroundColor;
    self.label.font = self.font;
}
-(void)animateWithIndex:(NSInteger)index withInitialScale:(CGFloat) scale{
    self.label.transform = CGAffineTransformMakeScale(scale, scale);
    [UIView animateWithDuration:(index + 1) * 0.3 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:0.1 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        self.label.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished){
        
    }];
}
-(UIColor *)backgroundColor {
    if (!self.is_selected) {
        return self.background_color;
    }
    return UIColor.clearColor;
}
@end
