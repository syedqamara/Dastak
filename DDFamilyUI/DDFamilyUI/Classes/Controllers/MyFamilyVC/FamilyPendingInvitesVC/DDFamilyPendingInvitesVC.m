//
//  DDFamilyPendingInvitesVC.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 03/02/2020.
//

#import "DDFamilyPendingInvitesVC.h"
#import "DDFamilyPendingInvitesTVC.h"
#import "DDFamilyPendingInvitesTHFV.h"

@interface DDFamilyPendingInvitesVC () <UITableViewDelegate, UITableViewDataSource, DDFamilyPendingInvitesTVCDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DDFamilyApiModel *familyResponse;


@end

@implementation DDFamilyPendingInvitesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupScreenFromData:(id)data {
    DDFamilyApiModel *temp = (DDFamilyApiModel*)data;
    if (temp) {
        DDEmptyViewModel *emptyVM = [DDFamilyUIManager.shared checkAndGetEmptyViewModelForFamily:temp.data];
        if (emptyVM != nil) {
            [DDEmptyView showAndReturnInConatiner:self.view withEmptyViewModel:emptyVM completion:^{
            }];
        }
        else {
            self.familyResponse = temp;
            [self.tableView reloadData];
        }
    }
}

#pragma mark - UITableView

-(void)setupTableView {
    NSArray *cells = @[FamilyPendingInvitesTVC];
    [self.tableView registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    NSArray *headers = @[FamilyPendingInvitesTHFV];
    [self.tableView registerHeaderFooterWithNibNames:headers forClass:self.class withIdentifiers:headers];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 125;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = 40;
    self.tableView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.familyResponse != nil ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.familyResponse.data.pending_invites_section.pending_invites.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDFamilyPendingInvitesTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:FamilyPendingInvitesTVC forIndexPath:indexPath];
    DDPendingInviteInfoM *invite = [self.familyResponse.data.pending_invites_section.pending_invites objectAtIndex:indexPath.row];
    [cell setData:invite];
    [cell setDelegate:self];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DDFamilyPendingInvitesTHFV *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:FamilyPendingInvitesTHFV];
    [view setData:@"You can accept only 1 invitation"];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

#pragma mark - DDFamilyPendingInvitesTVCDelegate

- (void)rejectAction:(DDPendingInviteInfoM *)invite {
    DDFamilyRequestM *request = [DDFamilyRequestM new];
    request.identifier = invite.identifier;
    __weak typeof(self) weakSelf = self;
    [DDFamilyManager.shared cancelInvitationWithRequestModel:request completion:^(DDFamilyApiModel * _Nullable model, NSURLResponse * _Nullable response , NSError * _Nullable error) {
        if (model) {
            if (model.successfulApi) {
                [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:^{
                    if (weakSelf.familyVCCallBack != nil) {
                        weakSelf.familyVCCallBack(@(1));
                    }
                }];
            }
        }
        else {
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
        }
    }];
}

- (void)acceptAction:(DDPendingInviteInfoM *)invite {
    DDFamilyRequestM *request = [DDFamilyRequestM new];
    request.identifier = invite.identifier;

    if (invite.isAlcohalAllowed) {
        request.cheers_accepted = invite.isCheersConfirmed ? @(1) : @(0);
    }
    
    __weak typeof(self) weakSelf = self;
    [DDFamilyManager.shared acceptInvitationWithRequestModel:request completion:^(DDFamilyApiModel * _Nullable model, NSURLResponse * _Nullable response , NSError * _Nullable error) {
        if (model) {
            #warning : things to do here branch and analytics
            DDPendingInviteAcceptInfoM *info = model.data.invitation_accept_content;
            if (model.success.boolValue && info) {
                [DDAlertUtils showAlertWithTitle:info.title subtitle:info.message buttonNames:@[info.button_title] onClick:^(int index) {
                    // go to my family
                    if (weakSelf.familyVCCallBack != nil) {
                        weakSelf.familyVCCallBack(@(1));
                    }
                }];
            }
        }
        else {
            [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:nil];
        }
    }];
}


@end
