//
//  DDOrderTimer.h
//  The Entertainer
//
//  Created by Syed Qamar Abbas on 6/20/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TimerBlock)(NSTimeInterval totalTime, NSTimeInterval remainingTime);
typedef void (^MainTimerBlock)(NSTimeInterval totalTime, NSTimeInterval remainingTime, BOOL isFinished);
@interface DDOrderTimer : NSObject
+ (DDOrderTimer *_Nonnull)shared;
@property (assign, nonatomic) BOOL showTimerView;
-(void)startTimerForTime:(NSTimeInterval)time shouldClearBasketOnCompletion:(BOOL)shouldClear completion:(TimerBlock _Nullable )block;
-(void)stopOrReset;
-(void)resumeTimer;
-(void)pauseTimer;
+(int) getSeconds:(NSDate *) oldDate;
-(BOOL)isTimerRunning;
@end
