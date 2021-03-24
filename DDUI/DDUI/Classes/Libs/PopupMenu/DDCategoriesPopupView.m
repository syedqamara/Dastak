//
//  DDCategoriesPopupView.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 06/02/2020.
//

#import "DDCategoriesPopupView.h"


@interface DDCategoriesPopupView() <DDAnimatedHorizontalViewDelegate>{
    CGRect popupInitialFrame;
    DDAnimatedHorizontalView *menuView;
}
@property (copy, nonatomic) void (^completionHandler)(NSInteger selectedIndex);
@end

@implementation DDCategoriesPopupView
+(void)showCategoriesFromView:(UIView *)view withDataSource:(NSArray<DDCategoriesPopupVM *> *)categories andCompletion:(void (^)(NSInteger selectedIndex))completion {
    CGRect frame = [UIApplication.sharedApplication.keyWindow convertRect:view.frame fromView:nil];
    DDCategoriesPopupView *overlayView = [[DDCategoriesPopupView alloc]initWithFrame:UIScreen.mainScreen.bounds];
    overlayView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
    overlayView->popupInitialFrame = frame;
    [overlayView loadInnerCollection];
    overlayView->menuView.dataSource = categories;
    overlayView->menuView.backgroundColor = view.backgroundColor;
    overlayView.tintColor = view.backgroundColor;
    overlayView.completionHandler = completion;
    [UIApplication.sharedApplication.keyWindow addSubview:overlayView];
    [overlayView animate];
}
-(void)loadInnerCollection {
    menuView = [DDAnimatedHorizontalView.alloc initWithFrame:popupInitialFrame];
    menuView.delegate = self;
    [self addSubview:menuView];
}
-(void)animate {
    CGRect newFrame = popupInitialFrame;
    newFrame.size.height = 100;
    newFrame.size.width = UIScreen.mainScreen.bounds.size.width - 32;
    newFrame.origin.x = 16;
    newFrame.origin.y = newFrame.origin.y - 50;
    menuView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.2 options:0 animations:^{
        self->menuView.backgroundColor = UIColor.whiteColor;
        self->menuView.transform = CGAffineTransformIdentity;
        self->menuView.frame = newFrame;
        [self->menuView reload];
    } completion:^(BOOL isAnimated){
        if (isAnimated) {
            
        }
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeViewWithIndex:-1];
}

- (void) didTapOnItem:(NSInteger)index {
    [self removeViewWithIndex:index];
}

-(void)removeViewWithIndex:(NSInteger)index {
    [menuView reset];
    self->menuView.backgroundColor = self.tintColor;
    CGRect frame = popupInitialFrame;
    frame.origin.x = CGRectGetMaxX(popupInitialFrame) - popupInitialFrame.size.width/2;
    frame.origin.y = CGRectGetMaxY(popupInitialFrame) - popupInitialFrame.size.height/2;
    frame.size = CGSizeZero;
    [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:0.2 options:0 animations:^{
        self->menuView.frame = frame;
    } completion:^(BOOL isAnimated){
        if (isAnimated) {
            [self removeFromSuperview];
            if (self.completionHandler != nil) {
                self.completionHandler(index);
            }
        }
    }];
}
@end
