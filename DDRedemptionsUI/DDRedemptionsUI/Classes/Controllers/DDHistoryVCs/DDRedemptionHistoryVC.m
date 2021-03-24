//
//  DDRedemptionHistoryVC.m
//  DDRedemptionsUI
//
//  Created by Hafiz Aziz on 24/02/2020.
//

#import "DDRedemptionHistoryVC.h"
#import "DDRedemptionTVC.h"
@interface DDRedemptionHistoryVC ()

@end

@implementation DDRedemptionHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Redemptions".localized;
    [self getHistoryData];
    
}
- (void)setdata:(DDBaseHistoryModel *)data{
    [super setdata:data];
    if (data.month_wise_redemmptions.count == 0) {
        [self showEmptyView:nil];
    }
}

-(void)showEmptyView:(NSError * _Nullable)error {
    DDEmptyViewModel *emptyView = [DDEmptyViewModel new];
    emptyView.image = @"empty_base_history.png";
    emptyView.title = UNKNOWN_ERROR;
    emptyView.sub_title = SOMETHING_WDD_WRONG;
    
    if (error) {
        emptyView.title = @"Error";
        emptyView.sub_title = error.localizedDescription;
        [DDAlertUtils showOkAlertWithTitle:@"Error" subtitle:error.localizedDescription completion:nil];
    }
    else {
        emptyView.title = @"You have not redeem any offer(s) yet.";
        emptyView.sub_title = @"Your redeemed offer(s) will appear";
    }
    
    [DDEmptyView showInConatiner:self.view withEmptyViewModel:emptyView completion:nil];
}

// MARK: - Fetch data from API
-(void)getHistoryData{
    DDHistoryRequestM *req = [[DDHistoryRequestM alloc] init];
    __weak typeof(self) weakSelf = self;
    [DDRedemptionsManager.shared getRedemptionHistory:req andCompletion:^(DDBaseHistoryAPIModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (model) {
            if (model.successfulApi) {
                DDBaseHistoryModel *baseData = (DDBaseHistoryModel*)model.data;
                [weakSelf setdata:baseData];
            }
            else {
                [weakSelf showEmptyView:model.apiError];
            }
        } else {
            [weakSelf showEmptyView:error];
        }
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    DDReservationDataModel
    DDRedemptionTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDRedemptionHistoryTableCell];
      [cell setData:[self.filteredArray objectAtIndex:indexPath.row]];
    return cell;
}

@end
