//
//  DDReferAFriendVC.m
//  Appboy-iOS-SDK
//
//  Created by Awais Shahid on 26/03/2020.
//

#import "DDReferAFriendVC.h"
#import "DDFriendsListingVM.h"
#import <DDSocial/DDSocial.h>

@interface DDReferAFriendVC ()
@property (strong, nonatomic) DDFriendsListingVM *listingVM;
@end

@implementation DDReferAFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
        
    [DDFamilyManager.shared fetchFriendsRankingWithRequestModel:YES familyreq:nil completion:^(DDFriendsAPI * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        weakSelf.listingVM = [DDFriendsListingVM setUpApiDataIntoVM:model];
    }];
    
    DDEmptyViewModel *model = [DDFamilyUIManager.shared checkAndGetEmptyViewModelForReferAFriend:nil];
    DDEmptyView *view = [DDEmptyView showAndReturnInConatiner:self.view withEmptyViewModel:model completion:^{
        [weakSelf referAFreind];
    }];
}

- (void)designUI {
    self.title = REFER_A_FRIEND.localized;
}

-(void)referAFreind {
    NSArray *dataSource = DDSocialPlatforms.allPlatform ;
    NSString *title = @"Have friends who wants to use the Entertainer?";
    NSString *message = @"Invite them to purchase the DDERTAINER, and earn 2500 smiles";
    __weak typeof(self) weakSelf = self;
    [DDAlertUtils showCancelActionSheetWithTitle:title message:message buttonTexts:dataSource completion:^(int index) {
        if (index>=0) {
            NSString *title = [dataSource objectAtIndex:index];
            DDSocialPlatform *platform = [DDSocialPlatforms platformFromTitle:title];
            [weakSelf shareOnPlatform:platform];
        }
    }];
}

-(void)shareOnPlatform:(DDSocialPlatform*)platform {
    if (self.listingVM.sections.count == 0) return;
    [DDSocialManager.shared shareContent:[self getContent] from:self onPlatfrom:platform withCompletionCallback:^(BOOL status, NSString * _Nullable text) {
        if (status)
            [self goBackWithCompletion:nil];
        else
            [DDAlertUtils showOkAlertWithTitle:@"" subtitle:text completion:nil];
    }];
}

-(DDSocialShareContent*)getContent {
    if (self.listingVM.sections.count == 0) return nil;
    DDFriendsListingSectionVM *vmSection = self.listingVM.sections.firstObject;
    DDSocialShareContent *content = [DDSocialShareContent new];
    content.text = vmSection.referral_section.share_text;
    content.url = vmSection.referral_section.share_link;
    content.sub_text = vmSection.share_section.message;
    return content;
}

@end
