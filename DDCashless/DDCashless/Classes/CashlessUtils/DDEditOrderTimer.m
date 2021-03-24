//
//  DDEditOrderTimer.m
//  The Entertainer
//
//  Created by Syed Qamar Abbas on 6/20/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import "DDEditOrderTimer.h"
#import "DDBasket.h"

@interface DDEditOrderTimer() {
    NSTimer *timerObject;
    NSTimeInterval totalTime;
    NSTimeInterval remainingSeconds;
    TimerBlock completionHandler;
    BOOL shouldClearBasket;
    UIView *view;
    UILabel *label;
}
@end
@implementation DDEditOrderTimer
static DDEditOrderTimer *timer;
+ (DDEditOrderTimer *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timer = [[DDEditOrderTimer alloc] init];
    });
    return timer;
}
-(void)initializeViews {
    self.showTimerView = YES;
    [view removeFromSuperview];
    view = [UIView.alloc initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 100)];
    view.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.2];
    [view setUserInteractionEnabled:NO];
    [UIApplication.sharedApplication.keyWindow addSubview:view];
    [view setHidden: !self.showTimerView];
    label = [UILabel.alloc initWithFrame:CGRectMake(30, 30, 250, 50)];
    label.textColor = UIColor.whiteColor;
    label.font = [UIFont systemFontOfSize:15 weight:(UIFontWeightBold)];
    label.text = @"";
    [view addSubview:label];
}
-(void)startTimerForTime:(NSTimeInterval)time shouldClearBasketOnCompletion:(BOOL)shouldClear completion:(TimerBlock)block {
    [self initializeViews];
    shouldClearBasket = shouldClear;
    totalTime = time;
    if (remainingSeconds <= 0) {
        remainingSeconds = time;
    }
    completionHandler = block;
    timerObject = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self->remainingSeconds--;
        self->label.text = [NSString stringWithFormat:@"Edit Order Remaing Time: %ld",(NSInteger)self->remainingSeconds];
        self->completionHandler(self->totalTime, self->remainingSeconds);
        if (self->remainingSeconds <= 0) {
            if (shouldClearBasket) {
                [DDBasket.shared resetBasketForceReset:YES];
            }
            [self completeTimer];
        }
        
    }];
}


-(void)pauseTimer {
    if (timerObject != nil) {
        [timerObject invalidate];
    }
    timerObject = nil;
}
-(void)completeTimer {
    [self stopOrReset];
    DDBasket.shared.currentOrder.edit_order_date = nil;
    [view removeFromSuperview];
    if (shouldClearBasket) {
        [DDBasket.shared resetBasketForceReset:YES];
    }
    
//    [NSNotificationCenter.defaultCenter postNotificationName:DDEditOrderTimerIsCompleted object:nil];
}
-(void)resumeTimer {
    [self startTimerForTime:totalTime shouldClearBasketOnCompletion:shouldClearBasket completion:completionHandler];
}
-(void)stopOrReset {
    [view removeFromSuperview];
    [timerObject invalidate];
    timerObject = nil;
    totalTime = 0;
    remainingSeconds = 0;
}

+(int) getSeconds:(NSDate *) oldDate{
    NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:oldDate];
    return seconds;
}
@end
