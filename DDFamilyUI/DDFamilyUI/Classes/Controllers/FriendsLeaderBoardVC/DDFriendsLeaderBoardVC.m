//
//  DDFriendsLeaderBoardVC.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 25/03/2020.
//

#import "DDFriendsLeaderBoardVC.h"
#import "DDFriendsListingVM.h"
#import "DDFriendLeaderBoardTVC.h"
#import "DDFriendLeaderBoardTHFV.h"
#import <DDAuth/DDAuth.h>
#import <DDSocial/DDSocial.h>

@interface DDFriendsLeaderBoardVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DDFriendsListingVM *listingVM;
@property (strong, nonatomic) DDEmptyView *emptyView;

@end

@implementation DDFriendsLeaderBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchDataFromServer];
}

-(void)fetchDataFromServer {
    __weak typeof(self) weakSelf = self;
    [DDFamilyManager.shared fetchFriendsRankingWithRequestModel:YES familyreq:nil completion:^(DDFriendsAPI * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [weakSelf stopPullToRefresh];
        [weakSelf.emptyView removeFromSuperview];
                
        if (error) {
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
        }
        else if (model) {
            if (model.successfulApi) {
                if (model.data.user_friends_ranking.count == 0) {
                    DDEmptyViewModel *emptyVM = [DDFamilyUIManager.shared checkAndGetEmptyViewModelForFriends:model];
                    weakSelf.emptyView = [DDEmptyView showAndReturnInConatiner:self.view withEmptyViewModel:emptyVM completion:^{
                        [weakSelf addNewFriendAction:nil];
                    }];
                }
                else {
                    weakSelf.listingVM = [DDFriendsListingVM setUpApiDataIntoVM:model];
                    [weakSelf.tableView reloadData];
                }
            }
            else {
                [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:nil];
            }
        }
    }];
}

- (void)designUI {
    self.tableView.backgroundColor = DDFamilyThemeManager.shared.selected_theme.bg_grey_240.colorValue;
    self.title = LEADERBOARD.localized;
}


-(void)setupTableView {
    NSArray *cells = @[FriendLeaderBoardTVC];
    [self.tableView registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    NSArray *header = @[FriendLeaderBoardTHFV];
    [self.tableView registerHeaderFooterWithNibNames:header forClass:self.class withIdentifiers:header];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 62;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = 28.0;
    self.tableView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    __weak typeof (self) weakSelf = self;
    [self setupPullToRefreshOn:self.tableView withStartRefreshing:^{
        [weakSelf fetchDataFromServer];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listingVM.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DDFriendsListingSectionVM *vmSection = [self.listingVM.sections objectAtIndex:section];
    if (vmSection.type == DDFriendsListingSectionVMTypeLeaderBoard) {
        return vmSection.friends_list.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDFriendsListingSectionVM *vmSection = [self.listingVM.sections objectAtIndex:indexPath.section];
    if (vmSection.type == DDFriendsListingSectionVMTypeLeaderBoard) {
        DDFriendLeaderBoardTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:FriendLeaderBoardTVC forIndexPath:indexPath];
        DDFriend *friend = [vmSection.friends_list objectAtIndex:indexPath.row];
        [cell setData:friend];
        cell.accessoryType = friend.isNew ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    return [UITableViewCell new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DDFriendsListingSectionVM *vmSection = [self.listingVM.sections objectAtIndex:section];
    if (vmSection.type == DDFriendsListingSectionVMTypeLeaderBoard) {
        DDFriendLeaderBoardTHFV *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:FriendLeaderBoardTHFV];
        [view setData:vmSection];
        return view;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDFriendsListingSectionVM *vmSection = [self.listingVM.sections objectAtIndex:indexPath.section];
    if (vmSection.type == DDFriendsListingSectionVMTypeLeaderBoard) {
        DDFriend *friend = [vmSection.friends_list objectAtIndex:indexPath.row];
        if (friend.isNew) {
            [self addNewFriendAction:nil];
        }
        else {
            if (friend.user_id != DDUserManager.shared.currentUser.user_id){
                [self friendDetailAction:friend];
            }
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDFriendsListingSectionVM *vmSection = [self.listingVM.sections objectAtIndex:indexPath.section];
    if (vmSection.type == DDFriendsListingSectionVMTypeLeaderBoard) {
        DDFriend *friend = [vmSection.friends_list objectAtIndex:indexPath.row];
        if ([DDFamilyManager.shared canRemoveFriend:friend])
            return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DDFriendsListingSectionVM *vmSection = [self.listingVM.sections objectAtIndex:indexPath.section];
        DDFriend *friend = [vmSection.friends_list objectAtIndex:indexPath.row];
        if (!friend.isNew) {
            __weak typeof (self) weakSelf = self;
            [self removeFriend:friend completion:^{
                [weakSelf fetchDataFromServer]; // refreshFamily from api
                [vmSection.friends_list removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [tableView reloadData];
            }];
        }
    }
}


#pragma mark - Other

-(void)friendDetailAction:(id)params {
    [DDFamilyUIManager.shared showFriendDetailsFrom:self withData:params andControllerCallBack:nil];
}

-(void)addNewFriendAction:(id)params {
    NSArray *dataSource = DDSocialPlatforms.allPlatform ;
    NSString *title = @"Have friends who also use the Entertainer?";
    NSString *message = @"Invite them to connect with you, and track your savings on leaderboard";
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
        if (!status)
            [DDAlertUtils showOkAlertWithTitle:@"" subtitle:text completion:nil];
    }];
}

-(DDSocialShareContent*)getContent {
    if (self.listingVM.sections.count == 0) return nil;
    DDFriendsListingSectionVM *vmSection = self.listingVM.sections.firstObject;
    DDSocialShareContent *content = [DDSocialShareContent new];
    content.text = vmSection.share_section.share_text;
    content.url = vmSection.share_section.share_link;
    content.sub_text = vmSection.share_section.message;
    return content;
}


-(void)removeFriend:(DDFriend*)friend completion:(void (^ _Nullable)(void))completion {
    [DDAlertUtils showAlertWithTitle:DELETE_A_FRIEND_TITLE subtitle:DELETE_A_FRIEND_SUBTITLE buttonNames:@[CANCEL, CONTINUE] onClick:^(int index) {
        if (index == 1) {
            DDFamilyRequestM *req = [DDFamilyRequestM new];
            req.friend_id = friend.user_id;
            [DDFamilyManager.shared removeFriendFromLeaderBoard:req completion:^(DDFriendsAPI * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (model) {
                    if (model.successfulApi) {
                        [DDAlertUtils showOkAlertWithTitle:nil subtitle:model.data.unfriend_status completion:nil];
                        if (completion) {
                            completion();
                        }
                    }
                    else {
                        [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:nil];
                    }
                }
                else {
                    [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
                }
            }];
        }
    }];
}

@end








