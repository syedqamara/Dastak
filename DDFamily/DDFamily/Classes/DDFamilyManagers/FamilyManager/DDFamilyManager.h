//
//  DDFamilyManager.h
//  DDFamily
//
//  Created by Awais Shahid on 27/01/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDNetwork/DDNetwork.h>
#import <DDModels/DDModels.h>
#import <DDAuth/DDAuth.h>

#import "DDFamilyConstants.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ _Nullable familyCompletionCallBack)(DDFamilyApiModel * _Nullable model,  NSURLResponse * _Nullable response, NSError * _Nullable error);
typedef void(^ _Nullable friendsCompletionCallBack)(DDFriendsAPI * _Nullable model,  NSURLResponse * _Nullable response, NSError * _Nullable error);


@interface DDFamilyManager : NSObject

+(DDFamilyManager *)shared;
-(NSString *)familyMemberDetailScreenTitleFromMemberDetailInfo:(DDFamilyMemberDetailInfoM*)detailInfo;
-(void)performActionWithInfo:(DDFamilyMemberInfoM*)info completion:(familyCompletionCallBack)completion;
-(BOOL)canRemoveFamilyMember:(DDFamilyMemberM*)member;
-(BOOL)canRemoveFriend:(DDFriend* _Nullable)frnd;

-(void)fetchProfileFamilyWithRequestModel:(DDFamilyRequestM* _Nullable)requestM WithCompletion:(void (^)(DDProfileApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error ))completion;
-(void)fetchMyFamilyWithRequestModel:(DDFamilyRequestM* _Nullable)requestM WithCompletion:(familyCompletionCallBack)completion;
-(void)removeFamilyMemberWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion;
-(void)editFamilyCheersWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion;
-(void)resendInvitationWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion;
-(void)cancelInvitationWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion;
-(void)acceptInvitationWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion;
-(void)editFamilyMemberWithWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion;
-(void)addFamilyMemberWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion;
-(void)fetchMemberDetailsWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion;
-(void)fetchFamilyPendingInvitesWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion;

-(void)fetchFriendsRankingWithRequestModel:(BOOL)showLoader familyreq:(DDFamilyRequestM* _Nullable)requestM completion:(friendsCompletionCallBack)completion;
-(void)removeFriendFromLeaderBoard:(DDFamilyRequestM* _Nullable)requestM completion:(friendsCompletionCallBack)completion;


@end

NS_ASSUME_NONNULL_END
