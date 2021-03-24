//
//  DDFamilyMembersListingVC.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 22/01/2020.
//

#import "DDFamilyMembersListingVC.h"
#import "DDFamilyMemberTVC.h"
#import "DDFamilyListingActionTVC.h"
#import "DDFamilyCreatedByTHFV.h"
#import "DDFamilyTreeDetailsTHFV.h"
#import "DDFamilyListingVM.h"

@interface DDFamilyMembersListingVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DDFamilyListingVM *listingVM;
@property (strong, nonatomic) DDEmptyView *emptyView;
@end

@implementation DDFamilyMembersListingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)setupScreenFromData:(id)data { // called from FamilyVC
    [self stopPullToRefresh];
    DDFamilyApiModel *temp = (DDFamilyApiModel*)data;
    if (temp) {
        [self.emptyView removeFromSuperview];
        DDEmptyViewModel *emptyVM = [DDFamilyUIManager.shared checkAndGetEmptyViewModelForFamily:temp.data];
        if (emptyVM != nil) {
            __weak typeof(self) weakSelf = self;
            self.emptyView = [DDEmptyView showAndReturnInConatiner:self.view withEmptyViewModel:emptyVM completion:^{
                [weakSelf addNewFamilyMemberAction:nil];
            }];
        }
        else {
            self.listingVM = [DDFamilyListingVM setUpApiDataIntoVM:temp];
            [self.tableView reloadData];
        }
    }
}

-(void)refreshData {
    if(self.familyVCCallBack != nil) {
        self.familyVCCallBack(nil);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshData];
}

- (void)designUI {
    [super designUI];
    self.tableView.backgroundColor = DDFamilyThemeManager.shared.selected_theme.bg_grey_244.colorValue;
}

#pragma mark - UITableView

-(void)setupTableView {
    NSArray *cells = @[FamilyMemberTVC, FamilyListingActionTVC];
    [self.tableView registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    NSArray *header = @[FamilyTreeDetailsTHFV, FamilyCreatedByTHFV];
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
        [weakSelf refreshData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listingVM.family_listing_sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DDFamilyListingSectionVM *vmSection = [self.listingVM.family_listing_sections objectAtIndex:section];
    if (vmSection.type == DDFamilyListingSectionVMTree) {
        return vmSection.members_list.count;
    }
    else if (vmSection.type == DDFamilyListingSectionVMAction) {
        return vmSection.actions_list.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDFamilyListingSectionVM *vmSection = [self.listingVM.family_listing_sections objectAtIndex:indexPath.section];
    if (vmSection.type == DDFamilyListingSectionVMTree) {
        DDFamilyMemberTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:FamilyMemberTVC forIndexPath:indexPath];
        DDFamilyMemberM *member = [vmSection.members_list objectAtIndex:indexPath.row];
        cell.accessoryType = (self.listingVM.member_info.isPrimaryMember && !member.isNew) ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
        [cell setData:member];
        return cell;
    }
    else if (vmSection.type == DDFamilyListingSectionVMAction) {
        DDFamilyMemberTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:FamilyListingActionTVC forIndexPath:indexPath];
        DDFamilyListingActionVM *action = [vmSection.actions_list objectAtIndex:indexPath.row];
        [cell setData:action];
        return cell;
    }
    return [UITableViewCell new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DDFamilyListingSectionVM *vmSection = [self.listingVM.family_listing_sections objectAtIndex:section];
    if (vmSection.type == DDFamilyListingSectionVMTree) {
        DDFamilyTreeDetailsTHFV *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:FamilyTreeDetailsTHFV];
        [view setData:vmSection];
        return view;
    }
    else if (vmSection.type == DDFamilyListingSectionVMCreatedBy) {
        DDFamilyCreatedByTHFV *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:FamilyCreatedByTHFV];
        [view setData:vmSection];
        return view;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDFamilyListingSectionVM *vmSection = [self.listingVM.family_listing_sections objectAtIndex:indexPath.section];
    if (vmSection.type == DDFamilyListingSectionVMAction) {
        [self performActionOnFamily:[vmSection.actions_list objectAtIndex:indexPath.row]];
    }
    if (self.listingVM.member_info.isPrimaryMember && vmSection.type == DDFamilyListingSectionVMTree) {
        DDFamilyMemberM *member = [vmSection.members_list objectAtIndex:indexPath.row];
        if (member.canAddNewMember) {
            [self addNewFamilyMemberAction:nil];
        }
        else if (!member.isNew) {
            [self familyMemberDetailAction:member];
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDFamilyListingSectionVM *vmSection = [self.listingVM.family_listing_sections objectAtIndex:indexPath.section];
    if (vmSection.type == DDFamilyListingSectionVMTree) {
        DDFamilyMemberM *member = [vmSection.members_list objectAtIndex:indexPath.row];
        if (self.listingVM.member_info.isPrimaryMember && !member.isNew)
            return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DDFamilyListingSectionVM *vmSection = [self.listingVM.family_listing_sections objectAtIndex:indexPath.section];
        DDFamilyMemberM *member = [vmSection.members_list objectAtIndex:indexPath.row];
        if (!member.isNew) {
            __weak typeof (self) weakSelf = self;
            [self removeMember:member completion:^{
                [weakSelf refreshData]; // refreshFamily from api
                [(NSMutableArray*)vmSection.members_list removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [tableView reloadData];
            }];
        }
    }
}

#pragma mark - Others

-(void)addNewFamilyMemberAction:(id)params {
    [DDFamilyUIManager.shared showAddNewFamilyMemeberFrom:self withData:nil andControllerCallBack:nil];
}

-(void)familyMemberDetailAction:(id)params {
    [DDFamilyUIManager.shared showFamilyMemberDetailFrom:self withData:params andControllerCallBack:nil];
}

-(void)removeMember:(DDFamilyMemberM*)member completion:(void (^ _Nullable)(void))completion {
    NSString *subtitle = [NSString stringWithFormat:MEMBER_REMOVE_ALERT_SUBTITLE,member.name];
    [DDAlertUtils showAlertWithTitle:REMOVE_FROM_FAMILY subtitle:subtitle buttonNames:@[CANCEL, CONTINUE] onClick:^(int index) {
        if (index == 1) {
            DDFamilyRequestM *request = [DDFamilyRequestM new];
            request.identifier = member.identifier;
            [DDFamilyManager.shared removeFamilyMemberWithRequestModel:request completion:^(DDFamilyApiModel * _Nullable model, NSURLResponse * _Nullable response , NSError * _Nullable error) {
                if (model) {
                    if(model.success.boolValue) {
                        if (completion!=nil) {
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

-(void)performActionOnFamily:(DDFamilyListingActionVM*)action {
    if (action.member_info.isPrimaryMemberProductExpired || action.member_info.isPrimaryMemberNotExpiredAndGracePeriodRunning) {
        [self actionWithInfo:action.member_info];
    }
    else {
        [self leaveOrDeleteWithAction:action];
    }
}

-(void)leaveOrDeleteWithAction:(DDFamilyListingActionVM*)action {
    __weak typeof(self) weakSelf = self;
    NSString *title, *leftBtn, *rightBtn;
    if (action.member_info.isPrimaryMember) {
        title = @"Close Family";
        leftBtn = CANCEL;
        rightBtn = CONTINUE;
    }
    else {
        title = @"Leave Family";
        leftBtn = @"No";
        rightBtn = @"Yes";
    }
    [DDAlertUtils showAlertWithTitle:title subtitle:action.member_info.family_delete_message buttonNames:@[leftBtn, rightBtn] highlightedAt:1 onClick:^(int index) {
        if (index == 1) {
            [weakSelf actionWithInfo:action.member_info];
        }
    }];
}

-(void)actionWithInfo:(DDFamilyMemberInfoM*)info {
    __weak typeof(self) weakSelf = self;
    [DDFamilyManager.shared performActionWithInfo:info completion:^(DDFamilyApiModel * _Nullable model, NSURLResponse * _Nullable response , NSError * _Nullable error) {
        if (model) {
            if (model.success) {
                [weakSelf refreshData];
            }
            else {
                [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
            }
        }
        else {
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
        }
    }];
}

@end
