//
//  DDOrderHistoryVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 04/08/2020.
//

#import "DDOrderHistoryVC.h"
#import "DDHomeThemeManager.h"
#import "DDOrderHistoryTVC.h"
#import "DDHomeManager.h"
#import "DDHomeUIManager.h"
@interface DDOrderHistoryVC ()<UITableViewDelegate, UITableViewDataSource> {
    DDBaseRequestModel *reqM;
}
@property (strong, nonatomic) DDOrderHistoryApiM *apiModel;
@end

@implementation DDOrderHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Orders".localized;
    [self.segmentControl setTitle:@"Past".localized forSegmentAtIndex:0];
    [self.segmentControl setTitle:@"Upcoming".localized forSegmentAtIndex:1];
    reqM = DDBaseRequestModel.new;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.tableView registerCells:@[@"DDOrderHistoryTVC"] forClass:self.class];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self loadData:YES];
    [self setupPullToRefreshOn:self.tableView withStartRefreshing:^{
        [self loadData:NO];
    }];
    // Do any additional setup after loading the view from its nib.
    
}
-(NSDictionary *)orderTypes {
    if (self.segmentControl.selectedSegmentIndex == 0) {
        return @{@"type": @"past"};
    }else {
        return @{@"type": @"present"};
    }
}
-(UITabBarItem *)tabBarItem {
    return [UITabBarItem.alloc initWithTitle:@"Orders".localized image:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"ic-my-order.png"] tag:1];
}
-(void)loadData:(BOOL)showHUD {
    [reqM addCustomParams:[self orderTypes]];
    [DDHomeManager.shared fetchOrderHistoryWithReq:reqM showHUD:showHUD onCompletion:^(DDOrderHistoryApiM * _Nullable model, NSError * _Nullable error) {
        self.apiModel = model;
        [self stopPullToRefresh];
        [self.tableView reloadData];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apiModel.data.orders.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDOrderHistoryM *order = self.apiModel.data.orders[indexPath.row];
    DDOrderHistoryTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDOrderHistoryTVC"];
    [cell setData:order];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDOrderHistoryM *order = self.apiModel.data.orders[indexPath.row];
    DDOrderRM *request = [DDOrderRM new];
    request.order_id = order.order_id;
    [DDHomeUIManager.shared showOrderStatus:self withData:request WithcallBack:nil];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setScrollViewVerticalContentOffset:scrollView.contentOffset.y];
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
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Order_History andModuleName:@"DDHomeUI" withClassRef:self.class];
}
- (IBAction)didChangeSegment:(id)sender {
    [self loadData:YES];
}
@end
