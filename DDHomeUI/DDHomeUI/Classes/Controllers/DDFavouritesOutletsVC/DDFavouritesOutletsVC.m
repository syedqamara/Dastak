//
//  DDFavouritesOutletsVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 04/08/2020.
//

#import "DDFavouritesOutletsVC.h"
#import "DDHomeThemeManager.h"
#import "DDHomeUIManager.h"
#import "DDModels.h"
#import "DDHomeManager.h"
#import "DDOutletsTVC.h"

@interface DDFavouritesOutletsVC ()<UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DDOutletApiM *apiModel;
@end

@implementation DDFavouritesOutletsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self setupPullToRefreshOn:self.tableView withStartRefreshing:^{
        [self loadData];
    }];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
-(UITabBarItem *)tabBarItem {
    return [UITabBarItem.alloc initWithTitle:@"Favourite".localized image:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"ic-heart.png"] tag:3];
}
-(void)loadData {
    DDBaseRequestModel *req = [DDBaseRequestModel new];
    [DDHomeManager.shared fetchFavOutletListingWithReq:req showHUD:YES onCompletion:^(DDOutletApiM * _Nullable model, NSError * _Nullable error) {
        self.apiModel = model;
        [self stopPullToRefresh];
        [self.tableView reloadData];
    }];
}
-(void)designUI {
    self.title = @"Favourite".localized;
    [self.tableView registerCells:@[@"DDOutletsTVC"] forClass:self.class];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apiModel.data.favorites.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDOutletsTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDOutletsTVC"];
    DDOutletM *outlet = self.apiModel.data.favorites[indexPath.row];
    [cell setData:outlet];
    MGSwipeButton *button = [MGSwipeButton buttonWithTitle:@"Remove".localized backgroundColor:HOME_THEME.bg_red_39.colorValue];
    button.tag = indexPath.row;
    cell.delegate = self;
    cell.rightButtons = @[button];
    cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
    return cell;
}
-(void)didTapRemoveAtIndex:(NSInteger)index {
    DDOutletM *outlet = self.apiModel.data.favorites[index];
    DDMerchantRM *requestM = [DDMerchantRM new];
    requestM.outlet_id = outlet.outlet_id;
    requestM.merchant_id = outlet.merchant_id;
    requestM.category_id = outlet.category_id;
    requestM.is_mark_fav = @(NO);
    [requestM addCustomParams:outlet.api_params];
    [DDHomeManager.shared markFavourite:requestM showHUD:YES onCompletion:^(DDBaseApiModel * _Nullable model, NSError * _Nullable error) {
        if (model.successfulApi) {
            [self removeObjectAtIndex:index];
        }else {
            if (model.message.length > 0) {
                [DDAlertUtils showOkAlertWithTitle:@"" subtitle:model.message completion:nil];
            }else {
                [DDAlertUtils showOkAlertWithTitle:@"" subtitle:error.localizedDescription completion:nil];
            }
        }
        
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setScrollViewVerticalContentOffset:scrollView.contentOffset.y];
}
-(BOOL)swipeTableCell:(MGSwipeTableCell *)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL)fromExpansion {
    [self didTapRemoveAtIndex:index];
    return NO;
}
-(void)removeObjectAtIndex:(NSInteger)index {
    [self.apiModel.data.favorites removeObjectAtIndex:index];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView performWithoutAnimation:^{
            [self.tableView reloadData];
        }];
    });
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDOutletM *outlet = self.apiModel.data.favorites[indexPath.row];
    DDMerchantRM *outletRM = [DDMerchantRM new];
    outletRM.outlet_id = outlet.outlet_id;
    outletRM.merchant_id = outlet.merchant_id;
    [outletRM addCustomParams:outlet.api_params];
    NSMutableDictionary *dict = outlet.api_params.mutableCopy;
    [outletRM addCustomParams:dict];
    
    [DDHomeUIManager.shared showMerchantDetail:self withReqModel:outletRM andControllerCallBack:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Favourites_Main andModuleName:@"DDHomeUI" withClassRef:self];
}
@end
