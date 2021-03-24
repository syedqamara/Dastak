//
//  DDLocationsManager.h
//  DDLocation
//
//  Created by Zubair Ahmad on 04/02/2020.
//  Copyright © 2020 The Entertainer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDConstants/DDConstants.h>
#import <DDModels/DDModels.h>
#import "DDSocialShareContent.h"

typedef NS_ENUM (NSUInteger, DDShareType){
    DDShareSavings,
    DDSharePostRedemptionSavings,
    DDShareBadge,
    DDShareLevel,
    DDShareInviteOutlet,
    DDShareRedemptionHistory,
    DDShareRedemptionSaving
};

NS_ASSUME_NONNULL_BEGIN

@interface DDSocialManager : NSObject

+(DDSocialManager *)shared;

-(void)shareContent:(DDSocialShareContent*)content from:(UIViewController*)controller onPlatfrom:(DDSocialPlatform*)platform withCompletionCallback:(StatusCompletionCallBack)callback;

-(void)shareContent:(DDSocialShareContent*)content from:(UIViewController*)controller onNativeShareSheet:(StatusCompletionCallBack)callback;
-(void)shareContent:(DDSocialShareContent*)content from:(UIViewController*)controller onEmailWithCallback:(StatusCompletionCallBack)callback;
-(void)shareContent:(DDSocialShareContent*)content from:(UIViewController*)controller onSMSWithCallback:(StatusCompletionCallBack)callback;
-(void)shareContent:(DDSocialShareContent*)content from:(UIViewController*)controller onFacebookWithCallback:(StatusCompletionCallBack)callback;
-(void)shareContent:(DDSocialShareContent*)content from:(UIViewController*)controller onWhatsAppWithCallback:(StatusCompletionCallBack)callback;
-(void)shareContent:(DDSocialShareContent*)content from:(UIViewController*)controller onMessangerWithCallback:(StatusCompletionCallBack)callback;

-(NSString *) getShareText:(DDShareType) shareType text:(NSString *) text merchantNameInCasePostRedemption:(NSString *)merchantName;
@end

NS_ASSUME_NONNULL_END
