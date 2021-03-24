//
//  DDDraggableNavigationController.m
//  DDUI
//
//  Created by Awais Shahid on 02/03/2020.
//

#import "DDDraggableNavigationController.h"
#import "HWPanModal.h"
#import "HWPanContainerView.h"
#import "DDCommons.h"
#import "DDUIBaseViewController.h"

@interface DDDraggableNavigationController () <HWPanModalPresentable> {
    CGFloat previousYOffset;
}

@end

@implementation DDDraggableNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(CGFloat)panModelHeight {
    if ([self.viewControllers.firstObject isKindOfClass:DDUIBaseViewController.class]) {
        DDUIBaseViewController *baseVC = (DDUIBaseViewController *)self.viewControllers.firstObject;
        return baseVC.dragableHeight;
    }
    return _panModelHeight;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return DDCAppConfigManager.shared.statusBarStyle;
}

- (PanModalHeight)longFormHeight {
//    return PanModalHeightMake(PanModalHeightTypeMaxTopInset, 80);
    return PanModalHeightMake(PanModalHeightTypeMax, 0);
}

- (PanModalHeight)shortFormHeight {
    CGFloat fullScreenH = UIScreen.mainScreen.bounds.size.height;
    if (self.panModelHeight == 0) self.panModelHeight = fullScreenH * 0.70;
    return PanModalHeightMake(PanModalHeightTypeMaxTopInset, fullScreenH-self.panModelHeight);
}


- (CGFloat)topOffset {
    return 0;
}

//- (nullable UIView <HWPanModalIndicatorProtocol> *)customIndicatorView {
//    HWPanIndicatorView *indicatorView = [HWPanIndicatorView new];
//    indicatorView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 20);
//    indicatorView.backgroundColor = [UIColor redColor];
//    return indicatorView;
//}

- (BOOL)showDragIndicator {
    return NO;
}

- (BOOL)isAutoHandleKeyboardEnabled {
    return NO;
}

- (UIScrollView *)panScrollable {
    if (self.viewControllers.count) {
        UIViewController *vc = self.viewControllers.firstObject;
        for (UIView *v in vc.view.subviews) {
            if ([v isKindOfClass:[UIScrollView class]])
                return (UIScrollView*)v;
        }
    }
    return nil;
}

- (BOOL)allowScreenEdgeInteractive {
    return YES;
}

- (CGFloat)maxAllowedDistanceToLeftScreenEdgeForPanInteraction {
    return 0;
}

-(void)isdragableViewPresentedInFullScreen:(BOOL)fullScreen {
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)willTransitionToState:(PresentationState)state {
    self.isFullScreen = state == PresentationStateLong;
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf hw_panModalSetNeedsLayoutUpdate];
    });
    if (self.disableUpwardPan) {
        [self sendDragableViewTopOffset:0];
    }
    else {
//        [self sendDragableViewTopOffset:self.shortFormHeight.height];
    }
    if (self.panModelDelegate && [self.panModelDelegate respondsToSelector:@selector(isdragableViewPresentedInFullScreen:)]) {
        [self.panModelDelegate isdragableViewPresentedInFullScreen:self.isFullScreen];
    }
}
-(BOOL)shouldTransitionToState:(PresentationState)state {
    if (self.disableUpwardPan && state == PresentationStateLong) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hw_panModalTransitionTo:(PresentationStateShort) animated:YES];
            [self hw_panModalSetNeedsLayoutUpdate];
        });
        return NO;
    }
    return YES;
}

- (BOOL)shouldRespondToPanModalGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint vel = [panGestureRecognizer velocityInView:self.view];
    NSLog(@"P-Y %f <==> V-Y %f \n <==> A-Y %f",panGestureRecognizer.view.panContainerView.frame.origin.y,vel.y,self.shortFormHeight.height);
    if (!self.disableUpwardPan) {
        return self.panDraggableInFullScreen;
    }
    else {
//        if (self.disableUpwardPan) {
//            
//            if (panGestureRecognizer.view.panContainerView.frame.origin.y <= self.shortFormHeight.height && vel.y <= 0) {
//                panGestureRecognizer.enabled = NO;
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self hw_panModalTransitionTo:(PresentationStateShort) animated:YES];
//                    [self hw_panModalSetNeedsLayoutUpdate];
//                    panGestureRecognizer.enabled = YES;
//                });
//                return NO;
//            }
//        }
        return YES;
    }
}
-(void)hw_panModalSetNeedsLayoutUpdate {
    [super hw_panModalSetNeedsLayoutUpdate];
    if (self.disableUpwardPan) {
        CGRect frame = self.view.panContainerView.frame;
        frame.origin.y = self.shortFormHeight.height;
        self.view.panContainerView.frame = frame;
    }
}
- (void)willRespondToPanModalGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    [self sendDragableViewTopOffset:panGestureRecognizer.view.panContainerView.frame.origin.y];
}

-(void)sendDragableViewTopOffset:(CGFloat)topOffset {
    if (self.panModelDelegate && [self.panModelDelegate respondsToSelector:@selector(dragableViewTopOffset:)]) {
        [self.panModelDelegate dragableViewTopOffset:topOffset];
    }
}

-(UIView<HWPanModalIndicatorProtocol> *)customIndicatorView {
    HWPanIndicatorView *view = [HWPanIndicatorView new];
    view.backgroundColor = UIColor.whiteColor;
    view.indicatorColor = UIColor.blackColor;
//    [view roundCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) radius:12];
    return view;
}
- (void)panTransiotionToFullScreen {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf hw_panModalTransitionTo:(PresentationStateLong) animated:YES];
        [weakSelf hw_panModalSetNeedsLayoutUpdate];
    });
}
-(void)reloadInputViews {
    [self hw_panModalSetNeedsLayoutUpdate];
    [self hw_panModalTransitionTo:(PresentationStateShort) animated:YES];
    
}
-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    DDUIBaseViewController *baseVC = (DDUIBaseViewController *)self.viewControllers.firstObject;
    [baseVC panIsBeingDismissed];
    [super dismissViewControllerAnimated:flag completion:completion];
}
@end
