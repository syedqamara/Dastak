//
//  DDCustomiseHeaderView.m
//  The Entertainer
//
//  Created by apple on 5/31/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import "DDCustomiseHeaderView.h"

@implementation DDCustomiseHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setBorderWidth:1 andBorderColor:UIColor.darkGrayColor];
}

- (void)setIsHeaderSelected:(BOOL)isHeaderSelected
{
    headerIsSelected = isHeaderSelected;
    if (isHeaderSelected) {
        _checkMarkView.backgroundColor = _checkMarkView.tintColor;
        [self setBorderWidth:0 andBorderColor:UIColor.clearColor];
    }else {
        _checkMarkView.backgroundColor = UIColor.clearColor;
        [self setBorderWidth:1 andBorderColor:UIColor.darkGrayColor];
    }
}
-(BOOL)isHeaderSelected {
    return headerIsSelected;
}
-(void)setBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor *)borderColor{
    [_checkMarkView.layer setBorderWidth:borderWidth];
    [_checkMarkView.layer setBorderColor:borderColor.CGColor];
}

- (IBAction)btnSelectionAction:(id)sender {
    self.isHeaderSelected = !self.isHeaderSelected;
    DDCustomiseOption actionOption = DDCustomiseOptionAdd;
    if (!self.isHeaderSelected) {
        actionOption = DDCustomiseOptionRemove;
    }
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didHeaderSelectedWithMode:atIndex:)]) {
        [_delegate didHeaderSelectedWithMode:actionOption atIndex:_index];
    }
}
@end
