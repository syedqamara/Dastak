//
//  DDAddCustomisationTHFV.m
//  ANStepperView
//
//  Created by Syed Qamar Abbas on 30/07/2020.
//

#import "DDAddCustomisationTHFV.h"
#import "DDHomeThemeManager.h"


@interface DDAddCustomisationTHFV () {
    DDMerchantMenuItemCustomizationM *cust;
}

@end


@implementation DDAddCustomisationTHFV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)designUI {
    self.titleLabel.font = [UIFont DDSemiBoldFont:15];
    self.subtitleLabel.font = [UIFont DDRegularFont:15];
    
    self.titleLabel.textColor = HOME_THEME.text_black.colorValue;
    [self.arrowImageView loadImageWithString:@"icArrowDown.png" forClass:self.class];
    [self.button addTarget:self action:@selector(didTapExpandButton) forControlEvents:(UIControlEventTouchUpInside)];
}
-(void)setData:(id)data {
    cust = data;
    
    [UIView performWithoutAnimation:^{
        [self setArrowPosition];
    }];
    self.titleLabel.text = cust.title;
    self.subtitleLabel.text = cust.sub_title;
    [super setData:data];
}
-(void)setArrowPosition {
    CGAffineTransform transform = CGAffineTransformIdentity;
    if (cust.isOpened) {
        transform = CGAffineTransformMakeRotation(M_PI);
    }
    self.arrowImageView.transform = transform;
}

-(void)didTapExpandButton {
    [cust toggle];
    [UIView animateWithDuration:0.2 animations:^{
        [self setArrowPosition];
    } completion:^(BOOL finished) {
        if (finished) {
            [self sendExpandCollpaseDelegate];
        }
    }];
}
-(void)sendExpandCollpaseDelegate {
    if (self.delegate != nil) {
        [self.delegate didTapExpandCollapseButtonWithCust:cust];
    }
}
@end
