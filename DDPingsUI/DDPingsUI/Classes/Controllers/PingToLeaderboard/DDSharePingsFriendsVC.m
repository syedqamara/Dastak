//
//  DDSharePingsFriendsVC.m
//  DDPingsUI
//
//  Created by Zubair Ahmad on 15/04/2020.
//

#import "DDSharePingsFriendsVC.h"
#import "DDSharePingsTVC.h"
#import "DDPingsUIManager.h"
#import <DDModels/DDModels.h>
#import "DDPingsFriendsTVC.h"
#import "DDUserManager.h"

@interface DDSharePingsFriendsVC () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    
    DDPingRequestM *pingModel;
    
    NSMutableArray *friends;
    NSMutableArray *filteredArray;
    
    NSInteger selectedIndex;
}
@property (weak, nonatomic) IBOutlet UIView *searchBGView;
@property (weak, nonatomic) IBOutlet UIImageView *search_imageView;
@property (weak, nonatomic) IBOutlet UITextField *search_textField;
@property (weak, nonatomic) IBOutlet UITableView *tblFriends;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@end

@implementation DDSharePingsFriendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    pingModel = self.navigation.routerModel.data;
    self.title = [PING_SHARE_LEADERBOARD localized];
    self.search_textField.delegate = self;
    friends = [[NSMutableArray alloc] init];
    self.emptyView.hidden = TRUE;
    selectedIndex = -1;
    [self setUpTableView];
    [self fetchDataFromServer];
}

-(void)fetchDataFromServer {
    __weak typeof(self) weakSelf = self;
    [DDFamilyManager.shared fetchFriendsRankingWithRequestModel:YES familyreq:nil completion:^(DDFriendsAPI * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
        }
        else if (model) {
            if (model.successfulApi) {
                if (model.data.user_friends_ranking.count == 0) {
                    [weakSelf showEmptyView:model];
                }
                else {
                    self->friends = model.data.user_friends_ranking.mutableCopy;
                    [weakSelf loadTableData];
                }
            }
            else {
                [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:nil];
            }
        }
    }];
}

-(void)addNewFriendAction:(id)params {
//    [DDAlertUtils showCancelActionSheetWithTitle:@"Have friends who also use the Entertainer?" message:@"Invite them to connect with you, and track your savings on leaderboard" buttonTexts:DDSocialPlatforms.allPlatform completion:^(int index) {
//
//    }];
}

- (void) showEmptyView : (DDFriendsAPI*)model {
    self.emptyView.hidden = NO;
    DDEmptyViewModel *emptyVM = [DDPingsUIManager.shared checkAndGetEmptyViewModelForNoFriends:model];
    [DDEmptyView showAndReturnInConatiner:self.emptyView withEmptyViewModel:emptyVM completion:^{
        [self addNewFriendAction:nil];
    }];
}

- (void) loadTableData {
    for (DDFriend *friend in friends) {
        if ([DDUserManager.shared.currentUser.user_id isEqual:friend.user_id]){
            [friends removeObject:friend];
            break;
        }
    }
    if (friends.count > 0){
        filteredArray = friends.mutableCopy;
        [self.tblFriends reloadData];
    }else {
        [self showEmptyView:nil];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tblFriends reloadData];
}

- (void) setUpTableView {
    self.tblFriends.dataSource = self;
    self.tblFriends.delegate = self;
    
    [self.tblFriends registerCellWithNibNames:@[@"DDPingsFriendsTVC"] forClass:self.class withIdentifiers:@[@"DDPingsFriendsTVC"]];
    
    self.tblFriends.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    self.tblFriends.sectionHeaderHeight = 50;
    self.tblFriends.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tblFriends.rowHeight = 150.0;
    
    self.tblFriends.tableFooterView = [UIView new];
}

-(void) designUI {
    
    pingModel = [[DDPingRequestM alloc] init];
    
    self.view.backgroundColor = DDPingsThemeManager.shared.selected_theme.bg_white.colorValue;
    self.searchBGView.layer.cornerRadius = 12.0;
    self.searchBGView.layer.borderWidth = 1.0;
    self.searchBGView.layer.borderColor = [DDPingsThemeManager.shared.selected_theme.bg_grey_199.colorValue CGColor];
    self.searchBGView.clipsToBounds = TRUE;
    self.search_imageView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icSearch"];
    
    [self addNavigationItemWithTitle:CANCEL identifier:CANCEL tintColor:DDPingsThemeManager.shared.selected_theme.text_white.colorValue direction:DDNavigationItemDirectionLeft];
    
    [self addNavigationItemWithTitle:NEXT identifier:NEXT tintColor:DDPingsThemeManager.shared.selected_theme.text_white.colorValue direction:DDNavigationItemDirectionRight];
}

- (void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    if ([sender.identifier isEqualToString:CANCEL]) {
        [self goBackWithCompletion:nil];
    }else if  ([sender.identifier isEqualToString:NEXT]) {
        if (filteredArray.count > 0 && selectedIndex > -1 && selectedIndex < filteredArray.count) {
            [self sendPingToFriend:filteredArray[selectedIndex]];
        }
    }
}


- (void) sendPingToFriend : (DDFriend*) friend {
    __weak typeof(self) weakSelf = self;
    if (friend.email != nil && friend.email.length){
        pingModel.email = friend.email;
        pingModel.customer_id = DDUserManager.shared.currentUser.user_id;
    }else{
        return;
    }
    if (pingModel.isValidRequestForSendPingCall){
        [DDPingsManager.shared sendPingRequest:pingModel andCompletion:^(DDPingApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * error) {
            if (error == nil) {
                if (model.data.status && model.data.status.boolValue){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [DDAlertUtils showOkAlertWithTitle:nil subtitle:model.data.message completion:^{
                            [weakSelf.navigation.routerModel sendDataCallback:PING_SDD_CALLBACK_MESSAGE withData:model withController:self];
                        }];
                    });
                }else{
                    NSString *string = @"";
                    if (model.data.message && model.data.message.length){
                        string = model.data.message;
                    }else{
                        string = @"Something went wrong";
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [DDAlertUtils showOkAlertWithTitle:nil subtitle:string completion:nil];
                    });
                }
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
                });
            }
        }];
    }else {
        [DDAlertUtils showOkAlertWithTitle:nil subtitle:self->pingModel.validationErrorMessageForSendPing completion:nil];
    }
}
 

#pragma mark - UI-TABLE-VIEW

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return filteredArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DDPingsFriendsTVC *cell = [self.tblFriends dequeueReusableCellWithIdentifier:@"DDPingsFriendsTVC"];
    [cell setData:filteredArray[indexPath.row]];
    if (indexPath.row == selectedIndex) {
        [cell.selectionImgV setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icControlSelected"]];
        cell.overlayView.hidden = YES;
    }else {
        [cell.selectionImgV setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icControlUnselected"]];
        cell.overlayView.hidden = NO;
    }
    if  (selectedIndex == -1){
        cell.overlayView.hidden = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == selectedIndex){
        selectedIndex = -1;
        [self.tblFriends reloadData];
    }else {
        if (selectedIndex > -1){
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:@"Sorry, You can not select multiple friends" completion:nil];
        }else {
            selectedIndex = indexPath.row;
            [self.tblFriends reloadData];
        }
    }
}


// MARK:- Filter Array
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    selectedIndex = -1;
    if ([textField.text length] + [string length] - range.length){
        [self filertTable:[NSString stringWithFormat:@"%@%@",textField.text,string.lowercaseString]];
    }else{
        [self filertTable:@""];
    }
    return YES;
}
-(void)filertTable :(NSString*)str{
    filteredArray = [friends filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(DDFriend  * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.name.lowercaseString containsString:str];
    }]];
    if (filteredArray.count == 0) {
        filteredArray = friends;
    }
    [self.tblFriends reloadData];
}

@end
