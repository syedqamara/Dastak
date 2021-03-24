//
//  DDNotificationManager.h
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/8/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDNotificationManager : NSObject

+(DDNotificationManager *) sharedInstance;

@property (nonatomic, assign) BOOL isLevel;

-(void) showGamificationNotification:(NSString *) name url:(NSString *) url message:(NSString *) message identifier:(NSString *) identifier completion:(void (^)(BOOL))completion;
-(void) showGamificationNotification:(NSString *) name url:(NSString *) url message:(NSString *) message hint:(NSString *) hint completion:(void (^)(BOOL))completion;
-(void) showGamificationNotificationWithShareButton:(NSString *) name url:(NSString *) url message:(NSString *) message shareMessage:(NSString *) shareMessage reward_id:(NSString *) reward_id levelBadgeId:(NSNumber *) levelBadgeId  completion:(void (^)(BOOL))completion;

@end
