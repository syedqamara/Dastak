//
//  DDFamilyApiManager.m
//  DDFamily
//
//  Created by Awais Shahid on 27/01/2020.
//

#import "DDFamilyApiManager.h"
#import "DDFamilyConstants.h"

@implementation DDFamilyApiManager

-(void)myFamily {}
-(void)leaveFamily {}
-(void)removeMember {}
-(void)reActivateFamily {}
-(void)editFamilyMemberCheers {}
-(void)resendInvitation {}
-(void)cancelInvitation {}
-(void)acceptInvitation {}
-(void)editMember {}
-(void)addMember {}
-(void)memberDetails {}
-(void)pendingInvites {}
-(void)friendsRankings {}
-(void)removeFriendFromLeaderBoard {}

+(void)registerApiConfiguration {
    [DDApisConfiguration registerConfigurations:DDApisType_Family_My_Family classObj:self responseClassObj:DDFamilyApiModel.class selector:@selector(myFamily) endPoint:K_FAMILY_EP_MY_FAMILY_MERGERD isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Family_Leave_Family classObj:self responseClassObj:DDFamilyApiModel.class selector:@selector(leaveFamily) endPoint:K_FAMILY_EP_LEAVE_FAMILY isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Family_Remove_Member classObj:self responseClassObj:DDFamilyApiModel.class selector:@selector(removeMember) endPoint:K_FAMILY_EP_REMOVE_MEMBER isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Family_Re_Activate_Family classObj:self responseClassObj:DDFamilyApiModel.class selector:@selector(reActivateFamily) endPoint:K_FAMILY_EP_RE_ACTIVATE_FAMILY isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Family_Edit_Family_Member_Cheers classObj:self responseClassObj:DDFamilyApiModel.class selector:@selector(editFamilyMemberCheers) endPoint:K_FAMILY_EP_EDIT_FAMILY_MEMBER_CHEERS isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Family_Resend_Invitation classObj:self responseClassObj:DDFamilyApiModel.class selector:@selector(resendInvitation) endPoint:K_FAMILY_EP_RESEND_INVITATION isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Family_Cancel_Invitation classObj:self responseClassObj:DDFamilyApiModel.class selector:@selector(cancelInvitation) endPoint:K_FAMILY_EP_CANCEL_INVITATION isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Family_Accept_Invitation classObj:self responseClassObj:DDFamilyApiModel.class selector:@selector(acceptInvitation) endPoint:K_FAMILY_EP_ACCEPT_INVITATION isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Family_Edit_Member classObj:self responseClassObj:DDFamilyApiModel.class selector:@selector(editMember) endPoint:K_FAMILY_EP_EDIT_MEMBER isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Family_Add_Member classObj:self responseClassObj:DDFamilyApiModel.class selector:@selector(addMember) endPoint:K_FAMILY_EP_ADD_MEMBER isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Family_Member_Details classObj:self responseClassObj:DDFamilyApiModel.class selector:@selector(memberDetails) endPoint:K_FAMILY_EP_MEMBER_DETAILS isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Family_Pending_Invites classObj:self responseClassObj:DDFamilyApiModel.class selector:@selector(pendingInvites) endPoint:K_FAMILY_EP_PENDING_INVITES isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Friends_Ranking classObj:self responseClassObj:DDFriendsAPI.class selector:@selector(friendsRankings) endPoint:K_FRIENDS_EP_RANKING isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Friends_Remove classObj:self responseClassObj:DDFriendsAPI.class selector:@selector(removeFriendFromLeaderBoard) endPoint:K_FRIENDS_EP_REMOVE isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    
}
@end
