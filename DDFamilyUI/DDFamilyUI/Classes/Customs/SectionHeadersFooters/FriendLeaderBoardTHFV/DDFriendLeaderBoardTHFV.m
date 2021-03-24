//
//  FriendLeaderBoardTHFV.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 26/03/2020.
//

#import "DDFriendLeaderBoardTHFV.h"
#import "DDFriendsListingVM.h"

@interface DDFriendLeaderBoardTHFV()
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;
@end

@implementation DDFriendLeaderBoardTHFV

- (void)setData:(id)data {
    if (![data isKindOfClass:[DDFriendsListingSectionVM class]]) return;
    DDFriendsListingSectionVM *section = (DDFriendsListingSectionVM*)data;
    self.titleLbl.text = section.section_title;
    [super setData:data];
}

- (void)designUI {
    self.contentView.backgroundColor = DDFamilyThemeManager.shared.selected_theme.bg_grey_240.colorValue;
    self.titleLbl.font = [UIFont DDMediumFont:13];
    self.titleLbl.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
}

@end




