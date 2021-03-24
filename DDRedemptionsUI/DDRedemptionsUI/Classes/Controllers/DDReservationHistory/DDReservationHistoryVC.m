//
//  DDReservationHistoryVC.m
//  DDRedemptionsUI
//
//  Created by Hafiz Aziz on 13/02/2020.
//

#import "DDReservationHistoryVC.h"
#import "DDReservationTVC.h"

@interface DDReservationHistoryVC ()

@end

@implementation DDReservationHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Reservations".localized;
    [self getHistoryData];
    
}
- (void)setdata:(DDBaseHistoryModel *)data{
    [super setdata:data];
    if (data.month_wise_reservations.count == 0){
        [self showEmptyView:nil];
    }
}

-(void)showEmptyView:(NSError* _Nullable)error {
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
        emptyView.title = @"You have not make any reservation(s) yet.";
        emptyView.sub_title = @"Your reservations will appear here as you book a table in the app";
    }
    
    [DDEmptyView showInConatiner:self.view withEmptyViewModel:emptyView completion:nil];
}

// MARK: - Fetch data from API
-(void)getHistoryData{
    DDHistoryRequestM * req = [[DDHistoryRequestM alloc] init];
    __weak typeof(self) weakSelf = self;
    [DDRedemptionsManager.shared getReservationHistory:req andCompletion:^(DDBaseHistoryAPIModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (model){
            if (model.successfulApi) {
                DDBaseHistoryModel *baseData = (DDBaseHistoryModel*)model.data;
                [weakSelf setdata:baseData];
            }
            else {
                [weakSelf showEmptyView:model.apiError];
            }
        }
        else {
            [weakSelf showEmptyView:error];
        }
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    DDReservationDataModel
    DDReservationTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDReservationHistoryTableCell];
      [cell setData:[self.filteredArray objectAtIndex:indexPath.row]];
    return cell;
}

+(NSArray<DDUIRouterM *> *)deeplinkRoutes {
    DDUIRouterM *r = [[DDUIRouterM alloc]init];
    r.route_link = DD_Nav_Reservation_History;
    r.should_embed_in_nav = YES;
    r.transition = DDUITransitionPush;
    return @[r];
}

@end
