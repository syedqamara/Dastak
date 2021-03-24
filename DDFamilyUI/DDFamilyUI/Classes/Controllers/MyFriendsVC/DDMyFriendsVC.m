//
//  DDMyFriendsVC.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 25/03/2020.
//

#import "DDMyFriendsVC.h"
#import "DDMyFriendsTVC.h"

@interface DDMyFriendsVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *options;

@end

@implementation DDMyFriendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.options = @[@"Friends Leaderboard", @"Refer a Friend"];
    [self setupTableView];
}

- (void)designUI {
    self.title = @"My Friends".localized;
    self.tableView.backgroundColor = DDFamilyThemeManager.shared.selected_theme.bg_grey_244.colorValue;
}

#pragma mark - UITableView

-(void)setupTableView {
    NSArray *cells = @[MyFriendsTVC];
    [self.tableView registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 62;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = 32;
    self.tableView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DDMyFriendsTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:MyFriendsTVC forIndexPath:indexPath];
    [cell setData:[self.options objectAtIndex:indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [DDFamilyUIManager.shared showMyFriendsLeaderBoardFrom:self withData:nil andControllerCallBack:nil];
    }
    else {
        [DDFamilyUIManager.shared showReferAFriendFrom:self withData:nil andControllerCallBack:nil];
    }
}



@end
