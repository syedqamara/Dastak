//
//  CashlessOrderStatusGradientCVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 09/04/2020.
//

#import "DDCashlessOrderStatusGradientCVC.h"

@interface DDCashlessOrderStatusGradientCVC()
@property (strong, nonatomic) DDOrderStatusM *status;
@end

@implementation DDCashlessOrderStatusGradientCVC

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setData:(id)data {
    
    self.status = data;
    
    NSMutableArray *colors = [NSMutableArray new];
    for (NSString *color in self.status.line_gradient_colors) {
        [colors addObject:(id)color.colorValue.CGColor];
    }
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.colors = colors;
    [self.layer addSublayer:gradient];
    
    [self designUI];
}

- (void)designUI {
    
}

@end

