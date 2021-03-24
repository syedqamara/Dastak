//
//  DDUIShadowView.m
//  The dynamicdelivery
//
//  Created by mac on 4/16/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import "DDUIShadowView.h"

@implementation DDUIShadowView

- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = [shadowColor CGColor];
}

- (void)setOffset:(CGSize)offset {
    self.layer.shadowOffset = offset;
}

- (void)setRadius:(CGFloat)radius {
    self.layer.shadowRadius = radius;
}

- (void)setOpacity:(CGFloat)opacity {
    self.layer.shadowOpacity = opacity;
}

@end
