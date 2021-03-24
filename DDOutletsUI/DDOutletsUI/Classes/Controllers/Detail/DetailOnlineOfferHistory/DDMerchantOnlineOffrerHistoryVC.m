//
//  DDMerchantOnlineOffrerHistoryVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 24/03/2020.
//

#import "DDMerchantOnlineOffrerHistoryVC.h"
#import "DDOutletsUIConstants.h"
#import "DDMDOnlineOfferHistoryDetailTVC.h"
#import "DDOutletsManager.h"
#import "DDOutletsUIManager.h"

@interface DDMerchantOnlineOffrerHistoryVC () <UITableViewDelegate,UITableViewDataSource>{
   NSMutableArray *offerHistoryArray;
    NSString *merchantID;
}

@end

@implementation DDMerchantOnlineOffrerHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    offerHistoryArray = [NSMutableArray new];
    self.title = @"Online Offers History".localized;
    merchantID = (NSString*)self.navigation.routerModel.data;
    [self setThemeNavigationBar];
    [self setUpTableView];
    [self loadData];
}

- (void) setUpTableView {
    
    NSArray *tableCells = @[DDMDOnlineOfferHistoryDetailTVCell];
    [self.tblView registerCellWithNibNames:tableCells forClass:self.class withIdentifiers:tableCells];
    self.tblView.dataSource = self;
    self.tblView.delegate = self;
    self.tblView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tblView.rowHeight = 100.0;
    [self.tblView reloadData];
}


- (void) loadData {
    DDBaseRequestModel *model = [[DDBaseRequestModel alloc] init];
    model.custom_parameters = @{@"merchant_id":merchantID}.mutableCopy;
    [[DDOutletsManager shared] fetchMerchantBaseOnlineOfferHistory:model showLoader:YES andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
         DDBaseHistoryAPIModel *historyModel = (DDBaseHistoryAPIModel *)model;
        if (historyModel.data.month_wise_redemmptions !=  nil && historyModel.data.month_wise_redemmptions.count > 0){
            self->offerHistoryArray = historyModel.data.month_wise_redemmptions.mutableCopy;
            [self.tblView reloadData];
        }else{
            DDEmptyViewModel *emptyVM = [[DDOutletsUIManager shared] checkAndGetEmptyViewModelForOnlineOfferHistory:historyModel];
            if (emptyVM != nil) {
                [DDEmptyView showInConatiner:self.tblView withEmptyViewModel:emptyVM completion:^{
                    [self dismissViewControllerAnimated:NO completion:nil];
                }];
            }
            [self->offerHistoryArray removeAllObjects];
            [self.tblView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return offerHistoryArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DDMDOnlineOfferHistoryDetailTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDMDOnlineOfferHistoryDetailTVCell forIndexPath:indexPath];
    DDRedemptionDataModel *model = [offerHistoryArray objectAtIndex:indexPath.section];
    DDRedemptionsData *redemption = [model.redemptions objectAtIndex:indexPath.row];
    [cell setData:redemption];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DDRedemptionDataModel *model = [offerHistoryArray objectAtIndex:section];
    return [model.is_expanded boolValue] ? 0 : model.redemptions.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}


@end
