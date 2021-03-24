//
//  DDGamificationManager.m
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/7/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import "DDGamificationManager.h"
#import "PSHTTPClient.h"
#import <DDAuth/DDAuth.h>
#import <DDPodGamification/GamificationLib.h>
#import <DDCommons/DDCommons.h>
#import "DDNotificationManager.h"

//#import "DDHermesAppAnalytics.h"
static int rewardsListCount = 0;

static DDGamificationManager *_sharedManagerInstance;

@implementation DDGamificationManager


+ (DDGamificationManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManagerInstance = [[DDGamificationManager alloc] init];
    });
    return _sharedManagerInstance;
}

-(id)init {
    if ( self = [super init] ) {
        
    }
    return self;
}

+(void)logout {
    PSHTTPClient.sharedClient.session_token = nil;
}
-(void) initilizeGamificationLib:(NSNumber *) userId userName:(NSString *) username email:(NSString *) email GAMIFICATION_KEY:(NSString*)GAMIFICATION_KEY API_GAMIFICATION_URL:(NSString*)API_GAMIFICATION_URL LEVEL_URL:(NSString*)LEVEL_URL BADGE_URL:(NSString*)BADGE_URL API_G_U:(NSString*)G_U API_G_P:(NSString*)G_P BADGEVILLE_API_KEY:(NSString*)BADGEVILLE_API_KEY BADGEVILLE_SITE_ID:(NSString*)BADGEVILLE_SITE_ID BADGEVILLE_URL:(NSString*)BADGEVILLE_URL {
    
    self.GAMIFICATION_KEY = GAMIFICATION_KEY;
    self.API_GAMIFICATION_URL = API_GAMIFICATION_URL;
    self.LEVEL_URL = LEVEL_URL;
    self.BADGE_URL = BADGE_URL;
    self.G_U = G_U;
    self.G_P = G_P;
    self.BADGEVILLE_API_KEY = BADGEVILLE_API_KEY;
    self.BADGEVILLE_SITE_ID = BADGEVILLE_SITE_ID;
    self.BADGEVILLE_URL = BADGEVILLE_URL;

    PSHTTPClient.sharedClient.session_token = DDUserManager.shared.currentUser.session_token;
    [[PSPointSystemAction sharedAction] setKeyInfo:GAMIFICATION_KEY andUserId:userId andUserName:username andEmail:email baseUrl:API_GAMIFICATION_URL b_user:G_U b_password:G_P];

}

+(void) getLevels:(void (^)(id object, NSString *error))completion{
    [PSLevelInfo getLevelsInfo:^(id object, NSString *error) {
        if(object){
            completion(object,nil);
        } else {
            completion(nil,error);
        }
    }];
}

+(void)getEarnedBadgeAndLevels:(void (^)(id, NSString *))completion {
    [PSUserBadgesAndLevels getUserEarnedBadgeAndLevel:^(id object, NSString *error) {
        if(object){
            NSArray *levelsAndBadges = (NSArray *)object;
            NSArray *levels = [levelsAndBadges firstObject];
            NSArray *badges = [levelsAndBadges lastObject];
            PSBadgesInfo *earnedLevel = [levels firstObject];
            if (earnedLevel != nil) {
                #warning add DDHermesAppAnalytics here
//                [DDHermesAppAnalytics.defaultAnalytics updateCustomAttributes:@"Current Level" :@{@"Current_Level":earnedLevel.name}];
            }
            if (badges != nil) {
                #warning add DDHermesAppAnalytics here
//                [DDHermesAppAnalytics.defaultAnalytics updateCustomAttributes:@"total badges earned" :@{@"total_badges_earned":[self getEarnedCountOfBadge:badges].stringValue}];
            }
            
            completion(object,nil);
        } else {
            completion(nil,error);
        }
    }];
}
+(NSNumber *)getEarnedCountOfBadge:(NSArray *)badges {
    NSInteger count = 0;
    for (PSBadgesInfo *info in badges) {
        if (info.is_earned != nil && info.is_earned.boolValue) {
            count++;
        }
    }
    return @(count);
}

+(NSMutableDictionary *) getMemberType{
    
    if([DDUserManager shared].currentUser && [DDUserManager shared].currentUser.user_id > 0){
        return [[NSMutableDictionary alloc] initWithDictionary:@{@"member_status":[DDUserManager shared].currentUser.member_type}];
    } else {
        return [[NSMutableDictionary alloc] initWithDictionary:@{}];
    }
    
    
}

+(void) sendBadgevilleEarnedPointsCall:(NSString *) action {
    
    NSMutableDictionary *paramsNew = [self getMemberType];
    [paramsNew addEntriesFromDictionary:@{@"session_token":[DDUserManager shared].currentUser.session_token ?: @""}];
    
    [[PSPointSystemAction sharedAction] performActionToLog:action params:paramsNew showDefaultAlert:NO completionAction:^(bool success, PSActionResponse *response) {
        if(success){
            if(response && response.alert && [response.alert boolValue]){
                [[DDNotificationManager sharedInstance] showGamificationNotification:response.title url:response.img message:response.message hint:nil completion:^(BOOL closed) {
                    
                }];
            }
            [DDGamificationManager updateGamificationInfo];
        }
    }];
}
+(NSMutableDictionary *) paramSessionTokenOnly{
    DDUserM *user = [DDUserManager shared].currentUser;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *sessionToken = user && user.user_id && user.session_token ? user.session_token : @"";
    [params setObject:sessionToken forKey:@"session_token"];
    return params;
}
+(void) sendBadgevilleEarnedPointsCallWithParams:(NSString *) action newParams:(NSDictionary *) newParams {
    NSMutableDictionary *paramsNew = [self getMemberType];
    [paramsNew addEntriesFromDictionary:newParams];
    [paramsNew addEntriesFromDictionary:[DDGamificationManager paramSessionTokenOnly]];
    [[PSPointSystemAction sharedAction] performActionToLog:action params:paramsNew showDefaultAlert:NO completionAction:^(bool success, PSActionResponse *response) {
        if(success){
            if(response && response.alert && [response.alert boolValue]){
                
                    [[DDNotificationManager sharedInstance] showGamificationNotification:response.title url:response.img message:response.message hint:nil completion:^(BOOL closed) {
                    }];
                
            }
            [DDGamificationManager updateGamificationInfo];
        }
    }];
}


+(void) sendBadgevilleEarnedPointsCallWithParamsForSmiles:(NSString *) action newParams:(NSDictionary *) newParams {
    return;
    NSMutableDictionary * params =[[NSMutableDictionary alloc] initWithDictionary:newParams];
    [params addEntriesFromDictionary:[self getMemberType]];

    
    if(![[DDUserManager shared] isMember]){
        return;
    }
    
    [[PSPointSystemAction sharedAction] performActionToLog:action params:params showDefaultAlert:NO completionAction:^(bool success, PSActionResponse *response) {
        if(success){
            //            if(response && response.alert && [response.alert boolValue]){
            //            }
            [DDGamificationManager updateSmilesList];
            
        }
    }];
}

+(void) showRewardsNotification:(NSArray *) rewards verb:(NSString *) verb{
    if(rewardsListCount < rewards.count){
        NSDictionary *rewardsInfo = [rewards objectAtIndex:rewardsListCount];
        NSMutableDictionary* appBoyDic = [[NSMutableDictionary alloc]init];
        [appBoyDic setValue:[NSDate date] forKey:@"BadgeDate"];
        [appBoyDic setValue:[rewardsInfo valueForKey:@"name"] forKey:@"BadgeName"];
//        [[Appboy sharedInstance] logCustomEvent:@"New Badge" withProperties:appBoyDic];
//        [[DDAppboyEventManager sharedInstance] addEventWithTitle:@"New Badge" andParam:appBoyDic];
        [[DDNotificationManager sharedInstance] showGamificationNotification:[rewardsInfo valueForKey:@"name"] url:[rewardsInfo valueForKey:@"image"] message:[rewardsInfo valueForKey:@"message"] identifier:verb completion:^(BOOL closed) {
            rewardsListCount ++ ;
            [self showRewardsNotification:rewards verb:verb];
        }];
    }
}
+(void) updateGamificationInfo{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:DDUpdateGamificationInfo object:nil];
    });
}
+(void) updateSmilesList{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:DDUpdateSmilesList object:nil];
    });
}
@end
