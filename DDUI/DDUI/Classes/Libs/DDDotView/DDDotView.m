//
//  DDDotView.m
//  AppAuth
//
//  Created by Syed Qamar Abbas on 13/10/2020.
//

#import "DDDotView.h"

@interface DDDotView()
@property (strong, nonatomic) NSMutableArray <CALayer *> *layers;
@end

@implementation DDDotView
-(void)layoutSubviews {
    [super layoutSubviews];
    for (CALayer *layer in self.layers) {
        [layer removeFromSuperlayer];
    }
    if (self.direction == DDDotViewDirectionVertical) {
        [self addVeritcalDots];
    }
    
}
-(void)addVeritcalDots {
    self.layers = [NSMutableArray new];
    CGFloat height = self.frame.size.height;
    for (CGFloat y = 0; y < height; y += self.size + self.space ) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, y, self.size, self.size);
        layer.backgroundColor = self.dotColor.CGColor;
        layer.cornerRadius = self.size/2;
        layer.masksToBounds = YES;
        [self.layer addSublayer:layer];
        [self.layers addObject:layer];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
