//
//  DDAddCustomisationTHFV.m
//  ANStepperView
//
//  Created by Syed Qamar Abbas on 30/07/2020.
//

#import "DDOrderDetailTHFV.h"
#import "DDHomeThemeManager.h"


@interface DDOrderDetailTHFV () {
    DDOrderStatusSectionM *section;
}
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;

@end


@implementation DDOrderDetailTHFV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)designUI {
    self.titleLabel.font = [UIFont DDSemiBoldFont:17];
    self.titleLabel.textColor = HOME_THEME.text_black.colorValue;
    [self.arrowImageView loadImageWithString:@"icArrowDown.png" forClass:self.class];
    [self.button addTarget:self action:@selector(didTapExpandButton) forControlEvents:(UIControlEventTouchUpInside)];
    self.containerView.backgroundColor = HOME_THEME.text_grey_238.colorValue;
    self.orderNumberLabel.textColor = HOME_THEME.text_white.colorValue;
    self.orderNumberLabel.superview.backgroundColor = HOME_THEME.app_theme.colorValue;
    self.orderNumberLabel.superview.cornerR = 5;
    self.orderNumberLabel.superview.clipsToBounds = YES;
    self.orderNumberLabel.font = [UIFont DDMediumFont:12];
}
-(void)setOrderNumber:(NSString *)orderNumber {
    self.orderNumberLabel.text = orderNumber;
}
-(void)setData:(id)data {
    section = data;
    [self.arrowImageView.superview setHidden:!section.isExpandable];
    [self.button setHidden:!section.isExpandable];
    self.titleLabel.text = section.title;
    [UIView performWithoutAnimation:^{
        [self setArrowPosition];
    }];
    [super setData:data];
}
-(void)setArrowPosition {
    CGAffineTransform transform = CGAffineTransformIdentity;
    if (section.isExpanded) {
        transform = CGAffineTransformMakeRotation(M_PI);
    }
    self.arrowImageView.transform = transform;
}

-(void)didTapExpandButton {
    [section toggle];
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
        [self.delegate didTapExpandCollapseButtonWithSection:section];
    }
}
@end
