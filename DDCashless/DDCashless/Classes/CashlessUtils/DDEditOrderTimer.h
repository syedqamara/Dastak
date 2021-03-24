//
//  DDEditOrderTimer.h
//  The Entertainer
//
//  Created by Syed Qamar Abbas on 6/20/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TimerBlock)(NSTimeInterval totalTime, NSTimeInterval remainingTime);
typedef void (^MainTimerBlock)(NSTimeInterval totalTime, NSTimeInterval remainingTime, BOOL isFinished);
@interface DDEditOrderTimer : NSObject
+ (DDEditOrderTimer *_Nonnull)shared;
@property (assign, nonatomic) BOOL showTimerView;
-(void)startTimerForTime:(NSTimeInterval)time shouldClearBasketOnCompletion:(BOOL)shouldClear completion:(TimerBlock _Nullable )block;
-(void)stopOrReset;
-(void)resumeTimer;
-(void)pauseTimer;
-(void)completeTimer;
+(int) getSeconds:(NSDate *) oldDate;
@end
