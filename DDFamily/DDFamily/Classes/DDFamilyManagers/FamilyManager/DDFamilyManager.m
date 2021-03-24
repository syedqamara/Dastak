//
//  DDFamilyManager.m
//  DDFamily
//
//  Created by Awais Shahid on 27/01/2020.
//

#import "DDFamilyManager.h"


@implementation DDFamilyManager

static DDFamilyManager *_sharedObject;

+(DDFamilyManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDFamilyManager alloc]init];
    });
    return _sharedObject;
}


-(void)performActionWithInfo:(DDFamilyMemberInfoM*)info completion:(familyCompletionCallBack)completion {
    if (info == nil || info.family_delete_message.length == 0) return;
    if ([info isSecondaryMember]) {
        [self leaveFamilyWithRequestModel:nil Completion:completion];
    }
    else if (info && [info isPrimaryMemberNotExpiredAndGracePeriodNotRunning]) {
        [self leaveFamilyWithRequestModel:nil Completion:completion];
    }
    else if ([info isPrimaryMemberNotExpiredAndGracePeriodRunning]) {
        NSString *deeplink = [NSString stringWithFormat:@"%@%@", DDCAppConfigManager.shared.app_config.APPLICATION_DEEPLINK_SCHEME, PRODUCT_LISTING_SCHEME];
        [DDWebManager.shared openURL:deeplink title:@"" onController:UIApplication.topMostController];
    } else {
        [self reActivateFamilyWithRequestModel:nil Completion:completion];
    }
}

- (NSString *)familyMemberDetailScreenTitleFromMemberDetailInfo:(DDFamilyMemberDetailInfoM*)detailInfo {
    if (detailInfo.isRejected) {
        return @"Rejected Invitation".localized;
    }
    else if (detailInfo.isPending) {
        return @"Pending Invitation".localized;
    }
    else {
        return @"Member Detail".localized;
    }
}

-(BOOL)canRemoveFriend:(DDFriend* _Nullable)frnd {
    if (frnd == nil) return NO;
    BOOL you = [frnd.user_id isEqualToNumber:DDUserManager.shared.currentUser.user_id];
    return !(you || frnd.isNew || frnd.isFamilyMember);
}

- (BOOL)canRemoveFamilyMember:(DDFamilyMemberM *)member {
    return member.isFamilyMember || member.isRejected || member.isPending;
}

- (BOOL)canAddFamilyMember:(DDFamilyMemberM *)member {
    return member.isFamilyMember || member.isRejected || member.isPending;
}



-(void)fetchMyFamilyWithRequestModel:(DDFamilyRequestM* _Nullable)requestM WithCompletion:(familyCompletionCallBack)completion{
    [DDNetworkManager.shared post:DDApisType_Family_My_Family
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion((DDFamilyApiModel*)model, response, error);
        }
    }];
}

-(void)leaveFamilyWithRequestModel:(DDFamilyRequestM* _Nullable)requestM Completion:(familyCompletionCallBack)completion {
    [DDNetworkManager.shared post:DDApisType_Family_Leave_Family
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion((DDFamilyApiModel*)model, response, error);
        }
    }];
}

-(void)removeFamilyMemberWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion {
    if (requestM.identifier.length == 0) {
        [NSException raise:FAMILY_EXCEPTION format:@"Valid member identifier required in family request model"];
    };
    [DDNetworkManager.shared post:DDApisType_Family_Remove_Member
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion((DDFamilyApiModel*)model, response, error);
        }
    }];
}

-(void)reActivateFamilyWithRequestModel:(DDFamilyRequestM* _Nullable)requestM Completion:(familyCompletionCallBack)completion {
    [DDNetworkManager.shared post:DDApisType_Family_Re_Activate_Family
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion((DDFamilyApiModel*)model, response, error);
        }
    }];
}

-(void)editFamilyCheersWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion {
    if (requestM.cheers_accepted == nil) {
        [NSException raise:FAMILY_EXCEPTION format:@"cheers accepted flag is required in family request model"];
    };
    [DDNetworkManager.shared post:DDApisType_Family_Edit_Family_Member_Cheers
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion((DDFamilyApiModel*)model, response, error);
        }
    }];
    
}

-(void)resendInvitationWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion {
    if (!requestM.isValidRequestForResendInvites) {
        [NSException raise:FAMILY_EXCEPTION format:@"%@", requestM.validationErrorForResendInvites];
    };
    [DDNetworkManager.shared post:DDApisType_Family_Resend_Invitation
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion((DDFamilyApiModel*)model, response, error);
        }
    }];
}

-(void)cancelInvitationWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion {
    if (requestM.identifier.length == 0) {
        [NSException raise:FAMILY_EXCEPTION format:@"Valid member identifier required in family request model"];
    };
    [DDNetworkManager.shared post:DDApisType_Family_Cancel_Invitation
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion((DDFamilyApiModel*)model, response, error);
        }
    }];
}

-(void)acceptInvitationWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion {
    if (requestM.identifier.length == 0) {
        [NSException raise:FAMILY_EXCEPTION format:@"Required parameters are missing in family request model"];
    };
    [DDNetworkManager.shared post:DDApisType_Family_Accept_Invitation
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion((DDFamilyApiModel*)model, response, error);
        }
    }];
}

-(void)editFamilyMemberWithWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion {
    if (!requestM.isValidRequestForEditFamilyMember) {
        [NSException raise:FAMILY_EXCEPTION format:@"%@", requestM.validationErrorForEditFamilyMember];
    };
    [DDNetworkManager.shared post:DDApisType_Family_Edit_Member
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion((DDFamilyApiModel*)model, response, error);
        }
    }];
}

-(void)addFamilyMemberWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion {
    if (!requestM.isValidRequestForAddFamilyMember) {
        [NSException raise:FAMILY_EXCEPTION format:@"%@", requestM.validationErrorForAddFamilyMember];
    };
    [DDNetworkManager.shared post:DDApisType_Family_Add_Member
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion((DDFamilyApiModel*)model, response, error);
        }
    }];
}

-(void)fetchMemberDetailsWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion {
    if (requestM.identifier.length == 0) {
        [NSException raise:FAMILY_EXCEPTION format:@"Valid member identifier required in family request model"];
    };
    [DDNetworkManager.shared post:DDApisType_Family_Member_Details
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion((DDFamilyApiModel*)model, response, error);
        }
    }];
}


-(void)fetchFriendsRankingWithRequestModel:(BOOL)showLoader familyreq:(DDFamilyRequestM* _Nullable)requestM completion:(friendsCompletionCallBack)completion {
    [DDNetworkManager.shared post:DDApisType_Friends_Ranking
                           showHUD:showLoader
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion((DDFriendsAPI*)model, response, error);
        }
    }];
}

-(void)removeFriendFromLeaderBoard:(DDFamilyRequestM* _Nullable)requestM completion:(friendsCompletionCallBack)completion {
    if (!requestM.isValidRequestForRemoveFriendFromLeaderBoard) {
        [NSException raise:FAMILY_EXCEPTION format:@"%@", requestM.validationErrorForRemoveFriendFromLeaderBoard];
    };
    [DDNetworkManager.shared post:DDApisType_Friends_Remove
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion((DDFriendsAPI*)model, response, error);
        }
    }];
}

-(void)fetchFamilyPendingInvitesWithRequestModel:(DDFamilyRequestM* _Nullable)requestM completion:(familyCompletionCallBack)completion {
    [DDNetworkManager.shared post:DDApisType_Family_Pending_Invites
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion((DDFamilyApiModel*)model, response, error);
        }
    }];
}

- (void)fetchProfileFamilyWithRequestModel:(DDFamilyRequestM *)requestM WithCompletion:(void (^)(DDProfileApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    [DDNetworkManager.shared post:DDApisType_Friends_Ranking
                           showHUD:NO
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion((DDProfileApiM*)model,response ,error);
        }
    }];
}

@end

