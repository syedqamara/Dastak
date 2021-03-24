//
//  DDFamilyUIAppUIConfiguration.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDFamilyUIAppUIConfiguration.h"
#import "DDFamilyUI.h"
@implementation DDFamilyUIAppUIConfiguration
+(void)loadUIConfiguration {
    NSString *moduleName = @"DDFamily";
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_MY_Family andModuleName:moduleName withClassRef:DDMyFamilyVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Family_Members_Listing andModuleName:moduleName withClassRef:DDFamilyMembersListingVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Family_Member_Details andModuleName:moduleName withClassRef:DDFamilyMemberDetailsVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Add_New_Family_Member andModuleName:moduleName withClassRef:DDAddNewFamilyMemberVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Family_Pending_Invites andModuleName:moduleName withClassRef:DDFamilyPendingInvitesVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Family_Temp andModuleName:moduleName withClassRef:DDTempVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_My_Friends andModuleName:moduleName withClassRef:DDMyFriendsVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_My_Friends_LeaderBoard andModuleName:moduleName withClassRef:DDFriendsLeaderBoardVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Refer_A_Friend andModuleName:moduleName withClassRef:DDReferAFriendVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Friend_Details andModuleName:moduleName withClassRef:DDFriendDetailsVC.class];
                                     
}
@end
