//
//  DDWhiteCheckbox.m
//  Thedynamicdelivery
//
//  Created by Kamil Kocemba on 13/06/2013.
//  Copyright (c) 2013 Future Workshops. All rights reserved.
//

#import "DDWhiteCheckbox.h"

@implementation DDWhiteCheckboxBlue

- (id)initWithFrame:(CGRect) frame {
    if (self = [super initWithFrame:frame]) {
        self.on = NO;
        [self addTarget:self action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.on = self.selected;
    [self addTarget:self action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setOn:(BOOL)on {
    self->_on = on;
    NSString *imageName = on ? @"checkbox" : @"checkbox_uncheck_blue";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    });
    
    if ([self.delegate respondsToSelector:@selector(didTapOnCheckBox:checkBox:)]){
        [self.delegate didTapOnCheckBox:self->_on checkBox:self];
    }
}

- (void)setOnWithoutCallback:(BOOL)on {
    NSString *imageName = on ? @"checkbox_blue" : @"checkbox_uncheck_blue";
    dispatch_async(dispatch_get_main_queue(), ^{
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    });
}

- (void)toggle {
    self.on = !self.on;
}


@end

@implementation DDWhiteCheckbox

- (id)initWithFrame:(CGRect) frame {
    if (self = [super initWithFrame:frame]) {
        self.on = NO;
        [self addTarget:self action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.on = self.selected;
    [self addTarget:self action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setOn:(BOOL)on {
    self->_on = on;
    NSString *imageName = on ? @"checked-box" : @"unchecked-box";
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)toggle {
    self.on = !self.on;
}


@end
