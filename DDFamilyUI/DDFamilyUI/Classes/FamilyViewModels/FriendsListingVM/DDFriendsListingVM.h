//
//  DDFriendsListingVM.h
//  DDFamilyUI
//
//  Created by Awais Shahid on 26/03/2020.
//

#import "DDFriendsListingVM.h"
#import <DDModels/DDModels.h>

@protocol DDFriendsListingSectionVM <NSObject> @end

typedef NS_ENUM(NSInteger, DDFriendsListingSectionVMType) {
    DDFriendsListingSectionVMTypeUnknown       = 0,
    DDFriendsListingSectionVMTypeLeaderBoard   = 1,
};

@interface DDFriendsListingSectionVM : JSONModel
@property (nonatomic, strong) NSString<Optional> *section_identifier;
@property (nonatomic, strong) NSString<Optional> *section_title;
@property (nonatomic, strong) NSString<Optional> *section_subtitle;
@property (nonatomic, strong) NSMutableArray<DDFriend, Optional> *friends_list;
@property (nonatomic, strong) DDFriendReferSection<Optional> * referral_section;
@property (nonatomic, strong) DDFriendShareSection<Optional> * share_section;
-(DDFriendsListingSectionVMType)type;
@end


@interface DDFriendsListingVM : JSONModel
@property (nonatomic, strong) NSArray<DDFriendsListingSectionVM, Optional> *sections;
+(DDFriendsListingVM*)setUpApiDataIntoVM:(DDFriendsAPI *)model;
@end



