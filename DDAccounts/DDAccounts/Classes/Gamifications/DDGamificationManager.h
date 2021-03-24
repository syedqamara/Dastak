//
//  DDGamificationManager.h
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/7/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#define GAMIFICATION_REDEEMED_OFFER @"redeem_offer"
#define GAMIFICATION_PRODUCT_VALUE_REDEEMED @"product_value_redeemed"
#define GAMIFICATION_SAVED_BIG_VALUE @"saved_big_value"
#define GAMIFICATION_POST_PHOTO @"post_photo"
#define GAMIFICATION_BUY_PRODUCT @"buy_product"
#define GAMIFICATION_USE_UBER @"use_uber"
#define GAMIFICATION_REVIEW_MERCHANT_ON_TRIPADVISOR @"review_merchant_on_tripadvisor"
#define GAMIFICATION_OUTLET_SEARCH @"advanced_outlet_search"
#define GAMIFICATION_SHARE @"share"
#define GAMIFICATION_PROFILE_COMPLETED @"profile_completed"
#define GAMIFICATION_LOGIN @"login"
#define GAMIFICATION_REGISTER @"register"
#define GAMIFICATION_VISIT @"visit"
#define GAMIFICATION_QUESTIONER @"survey_taken"
#define GAMIFICATION_SMILES_SOCIAL_SHARE @"social_share"


#define GAMIFICATION_PARAM_YEARLY_SAVINGS  @"yearly_savings"
#define GAMIFICATION_PARAM_POST_REDEMPTION_SAVINGS  @"post_redemption_savings"
#define GAMIFICATION_PARAM_VALUE  10
#define PARAM_GAMIFICATION_KEY @"GAMIFICATION_KEY"
#define PARAM_API_GAMIFICATION_URL @"API_GAMIFICATION_URL"


#import <Foundation/Foundation.h>

@interface DDGamificationManager : NSObject


+ (DDGamificationManager *) sharedManager;


@property (nonatomic, assign) BOOL isLevelsNeedToRefresh;
@property (nonatomic, assign) BOOL isBadgesNeedToRefresh;

@property (strong, nonatomic) NSString *LEVEL_URL;
@property (strong, nonatomic) NSString *BADGE_URL;
@property (strong, nonatomic) NSString *API_GAMIFICATION_URL;
@property (strong, nonatomic) NSString *GAMIFICATION_KEY;
@property (strong, nonatomic) NSString *G_U;
@property (strong, nonatomic) NSString *G_P;
@property (strong, nonatomic) NSString *BADGEVILLE_API_KEY;
@property (strong, nonatomic) NSString *BADGEVILLE_SITE_ID;
@property (strong, nonatomic) NSString *BADGEVILLE_URL;


+(void) sendBadgevilleEarnedPointsCall:(NSString *) playerId;

+(void) sendBadgevilleEarnedPointsCallWithParams:(NSString *) action newParams:(NSDictionary *) newParams;

+(void) sendBadgevilleEarnedPointsCallWithParamsForSmiles:(NSString *) action newParams:(NSDictionary *) newParams;

//New Methods

-(void) initilizeGamificationLib:(NSNumber *) userId userName:(NSString *) username email:(NSString *) email GAMIFICATION_KEY:(NSString*)GAMIFICATION_KEY API_GAMIFICATION_URL:(NSString*)API_GAMIFICATION_URL LEVEL_URL:(NSString*)LEVEL_URL BADGE_URL:(NSString*)BADGE_URL API_G_U:(NSString*)G_U API_G_P:(NSString*)G_P BADGEVILLE_API_KEY:(NSString*)BADGEVILLE_API_KEY BADGEVILLE_SITE_ID:(NSString*)BADGEVILLE_SITE_ID BADGEVILLE_URL:(NSString*)BADGEVILLE_URL;

+(void) getLevels:(void (^)(id object, NSString *error))completion;
+(void) getEarnedBadgeAndLevels:(void (^)(id object, NSString *error))completion;

+(NSMutableDictionary *) getMemberType;
+(void)logout;
@end
