//
//  UITextField+DDTextField.m
//  DDCommons
//
//  Created by Awais Shahid on 25/02/2020.
//

#import "UITextField+DDTextField.h"

@implementation UITextField (DDTextField)

-(void)customPlaceHolderColor:(UIColor*)color {
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: color}];
}
-(BOOL)shouldDisplayAccessoryView {
    if (self.isFirstResponder && self.text.length > 0) {
        return YES;
    }
    return NO;
}
-(void)checkAndClearActiveText {
    if ([self shouldDisplayAccessoryView]) {
        self.text = @"";
    }
}
@end
