//
//  DDSharePingsLeaderboardVC.m
//  DDPingsUI
//
//  Created by Zubair Ahmad on 15/04/2020.
//

#import "DDSharePingsLeaderboardVC.h"
#import "DDSharePingsTVC.h"
#import "DDPingsUIManager.h"
#import <DDModels/DDModels.h>
#import "DDPingsLeaderBoardTVC.h"
#import "DDPingsFriendsTVC.h"

@interface DDSharePingsLeaderboardVC () <UITableViewDelegate, UITableViewDataSource>{
    
    NSMutableArray *leaderboardOptions;
}
@property (weak, nonatomic) IBOutlet UITableView *tblLeaderboard;
@end

@implementation DDSharePingsLeaderboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [PING_SHARE_LEADERBOARD localized];
    leaderboardOptions = [[NSMutableArray alloc] init];
    [leaderboardOptions addObject:@{@"title":@"Friends", @"sub_title":@"Connected friends in your leaderboard"}];
   
    [self setUpTableView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tblLeaderboard reloadData];
}

- (void) setUpTableView {
    self.tblLeaderboard.dataSource = self;
    self.tblLeaderboard.delegate = self;
    [self.tblLeaderboard registerCellWithNibNames:@[@"DDPingsLeaderBoardTVC"] forClass:self.class withIdentifiers:@[@"DDPingsLeaderBoardTVC"]];
    
    self.tblLeaderboard.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    self.tblLeaderboard.sectionHeaderHeight = 50;
    self.tblLeaderboard.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tblLeaderboard.rowHeight = 150.0;
}

-(void) designUI {
    self.view.backgroundColor = DDPingsThemeManager.shared.selected_theme.bg_white.colorValue;
   
    [self addNavigationItemWithTitle:CANCEL identifier:CANCEL tintColor:DDPingsThemeManager.shared.selected_theme.text_white.colorValue direction:DDNavigationItemDirectionLeft];
    
    [self addNavigationItemWithTitle:NEXT identifier:NEXT tintColor:DDPingsThemeManager.shared.selected_theme.text_white.colorValue direction:DDNavigationItemDirectionRight];
}

- (void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    if ([sender.identifier isEqualToString:CANCEL]) {
        [self goBackWithCompletion:nil];
    }else if  ([sender.identifier isEqualToString:NEXT]) {
        [[DDPingsUIManager shared] goToAnotherViewController:self withPingsModel:self.navigation.routerModel.data routeLink:DD_Nav_Pings_LB_FRIENDS andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
            [self.navigation.routerModel sendDataCallback:identifier withData:data withController:controller];
        }];
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
    return leaderboardOptions.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DDPingsLeaderBoardTVC *cell = [self.tblLeaderboard dequeueReusableCellWithIdentifier:@"DDPingsLeaderBoardTVC"];
    [cell setData:leaderboardOptions[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
