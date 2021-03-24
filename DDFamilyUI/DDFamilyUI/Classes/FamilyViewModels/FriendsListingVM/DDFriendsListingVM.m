//
//  DDFriendsListingVM.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 26/03/2020.
//

#import "DDFriendsListingVM.h"
#import "DDFamilyUIConstants.h"

@implementation DDFriendsListingSectionVM

-(DDFriendsListingSectionVMType)type {
    if ([self.section_identifier isEqualToString:FRIENDS_LEADERBOARD]) {
        return DDFriendsListingSectionVMTypeLeaderBoard;
    }
    return DDFriendsListingSectionVMTypeUnknown;
}

@end

@implementation DDFriendsListingVM

+ (DDFriendsListingVM *)setUpApiDataIntoVM:(DDFriendsAPI *)model {
    if (model == nil) return nil;
    
    DDFriendsListingVM *temp = [DDFriendsListingVM new];
    DDFriendsListingSectionVM *leaderBoardSection = [DDFriendsListingSectionVM new];
    leaderBoardSection.section_identifier = FRIENDS_LEADERBOARD;
    leaderBoardSection.section_title = FRIENDS_LEADERBOARD;
    leaderBoardSection.referral_section = model.data.friends_connect_referral_sections.referral_section;
    leaderBoardSection.share_section = model.data.friends_connect_referral_sections.connect_section;
    DDFriend *newF = [DDFriend new];
    newF.name = ADD_FRIEND;
    NSMutableArray *friends = [[NSMutableArray alloc] initWithObjects:newF, nil];
    if (model.data.user_friends_ranking.count)
        friends = [friends arrayByAddingObjectsFromArray:model.data.user_friends_ranking].mutableCopy;
    leaderBoardSection.friends_list = friends;
    temp.sections = @[leaderBoardSection];
    
    return temp;
}

@end
