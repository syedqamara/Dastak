
//
//  DDNotificationManager.m
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/8/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import "DDNotificationManager.h"
//#import "DDRedeemViewControllerStep1.h"
//#import "DDGamificationSimpleNotification.h"
//#import "DDGamificationShareNotification.h"
#import <DDModels/DDModels.h>
#import <DDAuthUI/DDAuthUI.h>

#define GAMIFICATION_REDEEMED_OFFER @"redeem_offer"

@interface DDNotificationManager(){
//    DDRedeemViewControllerStep1 *redeemedNotification;
//    DDGamificationSimpleNotification *simpleNotification;
//    DDGamificationShareNotification *shareNotification;
}

@property (nonatomic, copy) void(^didClosePopup)(BOOL, NSError *);

@end

@implementation DDNotificationManager

+(DDNotificationManager *) sharedInstance {
    static DDNotificationManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[DDNotificationManager alloc] init];
    });
    return _sharedInstance;
}

-(id)init{
    if (self=[super init]) {
//        [self initRedeemOfferStep1];
        [self initSimpleNotification];
        [self initShareNotification];
    }
    return self;
}
#warning initRedeemOfferStep1
//-(void) initRedeemOfferStep1{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Gamification" bundle:nil];
//    redeemedNotification  = [storyboard instantiateViewControllerWithIdentifier:@"Step1"];
//    redeemedNotification.view.frame = CGRectMake(0, 0, 286, 444);
//}

-(void) initSimpleNotification{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Gamification" bundle:nil];
//    simpleNotification  = [storyboard instantiateViewControllerWithIdentifier:@"SimpleNotification"];
//    simpleNotification.view.frame = CGRectMake(0, 0, 286, 350);
}

-(void) initShareNotification{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Gamification" bundle:nil];
//    shareNotification  = [storyboard instantiateViewControllerWithIdentifier:@"ShareNotification"];
//    shareNotification.view.frame = CGRectMake(0, 0, 286, 362);
}


-(void) showGamificationNotification:(NSString *) name url:(NSString *) url message:(NSString *) message identifier:(NSString *) identifier completion:(void (^)(BOOL))completion{
    
    UIView *view = nil;

    DDUserM *user = [DDUserManager shared].currentUser;
    
    
    if([identifier isEqualToString:GAMIFICATION_REDEEMED_OFFER] && [user.member_type integerValue] == 3 && user.onboarding_redemptions_count && [user.onboarding_redemptions_count integerValue] == 2 ){
        
//        [simpleNotification setDetail:url name:name message:message hint:nil];
//        view = simpleNotification.view;
        
    } else if([identifier isEqualToString:GAMIFICATION_REDEEMED_OFFER] && [user.member_type integerValue] == 3){
    #warning simpleNotification
//        [redeemedNotification setDetail:url name:name message:message];
//        view = redeemedNotification.view;
    
    } else {
        
//        [simpleNotification setDetail:url name:name message:message hint:nil];
//        view = simpleNotification.view;
    
    }
    
    [KGModal sharedInstance].completion = ^() {

        completion (YES);
    };

    [KGModal sharedInstance].tapOutsideToDismiss = NO;
    [KGModal sharedInstance].animateWhenDismissed = NO;
    [[KGModal sharedInstance] setModalBackgroundColor:[UIColor clearColor]];
    [[KGModal sharedInstance] setCloseButtonType:KGModalCloseButtonTypeNone];
    [[KGModal sharedInstance] showWithContentView:view andAnimated:YES];
}


-(void) showGamificationNotification:(NSString *) name url:(NSString *) url message:(NSString *) message hint:(NSString *) hint completion:(void (^)(BOOL))completion{
    
    UIView *view = nil;
    
//    [simpleNotification setDetail:url name:name message:message hint:hint];
//    view = simpleNotification.view;

    
    [KGModal sharedInstance].tapOutsideToDismiss = YES;
    [KGModal sharedInstance].animateWhenDismissed = YES;
    [[KGModal sharedInstance] setModalBackgroundColor:[UIColor clearColor]];
    [[KGModal sharedInstance] setCloseButtonType:KGModalCloseButtonTypeNone];;
    dispatch_async(dispatch_get_main_queue(), ^{
//        [[KGModal sharedInstance] showWithContentViewController:simpleNotification andAnimated:YES];
    });
}

-(void) showGamificationNotificationWithShareButton:(NSString *) name url:(NSString *) url message:(NSString *) message shareMessage:(NSString *) shareMessage reward_id:(NSString *) reward_id  levelBadgeId:(NSNumber *) levelBadgeId completion:(void (^)(BOOL))completion{
    
    
    
    UIView *view = nil;
//    shareNotification.isLevel = self.isLevel;
//    
//    [shareNotification setDetailWithShareButtonEnable:url name:name message:message shareMessage:shareMessage reward_id:reward_id levelBadgeId:levelBadgeId];
//    
//    
//    
//    view = shareNotification.view;
    
    
    [KGModal sharedInstance].tapOutsideToDismiss = YES;
    [KGModal sharedInstance].animateWhenDismissed = YES;
    [[KGModal sharedInstance] setModalBackgroundColor:[UIColor clearColor]];
    [[KGModal sharedInstance] setCloseButtonType:KGModalCloseButtonTypeNone];
    [[KGModal sharedInstance] showWithContentView:view andAnimated:YES];
}




@end
