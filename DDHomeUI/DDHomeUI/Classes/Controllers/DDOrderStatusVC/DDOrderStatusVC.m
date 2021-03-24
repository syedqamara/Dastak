//
//  DDOrderStatusVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/07/2020.
//

#import "DDOrderStatusVC.h"
#import "DDHomeThemeManager.h"
#import "DDHome.h"
#import "DDOrderDetailTHFV.h"
#import "DDOrderStatusTHFV.h"
#import "DDOrderInfoTHFV.h"
#import "DDOrderTotalTHFV.h"
#import "DDOrderItemTVC.h"
#import "DDHomeUIManager.h"
#import "DDBasketManager.h"
#import "DDDriverInfoTHFV.h"
@interface DDOrderStatusVC ()<UITableViewDelegate, UITableViewDataSource, DDOrderDetailTHFVTHFVDelegate> {
    NSTimer *timer;
    BOOL ratingIsDisplayedOnce;
}
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *canelButton;
@property (strong, nonatomic) DDOrderStatusApiM *apiModel;

@end

@implementation DDOrderStatusVC
-(DDOrderRM *)request {
    if ([self.navigation.routerModel.data isKindOfClass:DDOrderRM.class]) {
        return self.navigation.routerModel.data;
    }
    [self goBackWithCompletion:nil];
    return nil;
}
-(void)goBackWithCompletion:(void (^)(void))completion {
    [timer invalidate];
    timer = nil;
    [super goBackWithCompletion:completion];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Track Order".localized;
    [self addCrossImageWithColor:HOME_THEME.app_theme.colorValue withDirection:(DDNavigationItemDirectionLeft)];
    [DDBasketManager.shared resetBasketWithOutMerchant];
    [self loadData: YES];
    [self setupPullToRefreshOn:self.tableView withStartRefreshing:^{
        [self->timer invalidate];
        self->timer = nil;
        [self loadData:NO];
    }];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)loadData:(BOOL)showHUD {
    [DDHomeManager.shared fetchOrderDetailWithReq:[self request] showHUD:showHUD onCompletion:^(DDOrderStatusApiM * _Nullable model, NSError * _Nullable error) {
        self.apiModel = model;
        [self stopPullToRefresh];
        if (self.apiModel.data.showRating && !self->ratingIsDisplayedOnce) {
            self->ratingIsDisplayedOnce = YES;
            DDRatingRM *req = [DDRatingRM new];
            req.merchant_id = model.data.merchant_id;
            req.outlet_id = model.data.outlet_id;
            req.order_id = model.data.order_id;
            req.merchant_name = model.data.merchant_name;
            [DDHomeUIManager.shared showOrderRating:self withData:req WithcallBack:nil];
        }
        [self.canelButton.superview setHidden:!self.apiModel.data.canCancelOrder];
        [self drawTableViewBottomLine];
        if (model.data.refreshTimeInterval > 0 && !model.data.isOrderComplete) {
            [self->timer invalidate];
            self->timer = nil;
            self->timer = [NSTimer scheduledTimerWithTimeInterval:model.data.refreshTimeInterval repeats:NO block:^(NSTimer * _Nonnull timer) {
                [self loadData:NO];
            }];
        }
    }];
}
-(void)drawTableViewBottomLine {
    UIView *view = [UIView.alloc initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 5)];
    view.backgroundColor = HOME_THEME.text_grey_238.colorValue;
    self.tableView.tableFooterView = view;
    [self.tableView reloadData];
}
-(void)dummyStatusChange {
    //Deprecated
    if (DDCAppConfigManager.shared.isEditConfigAllowed) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.apiModel.data.canMarkAnotherTrue) {
                [self.apiModel.data markAnOtherStatusTrue];
                [self.tableView reloadData];
                [self dummyStatusChange];
            }
        });
    }
}
-(void)designUI {
    self.canelButton.titleLabel.font = [UIFont DDSemiBoldFont:17];
    [self.canelButton setTitle:@"Cancel Order".localized forState:(UIControlStateNormal)];
    [self.canelButton setTitleColor:HOME_THEME.app_theme.colorValue forState:(UIControlStateNormal)];
    self.canelButton.cornerR = 12;
    self.canelButton.borderW = 1;
    self.canelButton.borderColor = HOME_THEME.app_theme.colorValue;
    [self.tableView registerCells:@[@"DDOrderItemTVC"] forClass:self.class];
    [self.tableView registerTHFV:@[@"DDOrderDetailTHFV", @"DDOrderStatusTHFV", @"DDOrderInfoTHFV",@"DDOrderTotalTHFV", @"DDDriverInfoTHFV"] forClass:self.class];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 50;
    
    self.tableView.sectionFooterHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionFooterHeight = 100;
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.apiModel.data.sections.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DDOrderStatusSectionM *sect = self.apiModel.data.sections[section];
    if (sect.type == DDOrderStatusSectionTypeDetail && sect.isExpanded) {
        return sect.order_detail.items.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDOrderStatusSectionM *sect = self.apiModel.data.sections[indexPath.section];
    DDOrderItemTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDOrderItemTVC"];
    [cell setData:sect.order_detail.items[indexPath.row]];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DDOrderStatusSectionM *sect = self.apiModel.data.sections[section];
    if (sect.type == DDOrderStatusSectionTypeDetail) {
        DDOrderDetailTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DDOrderDetailTHFV"];
        view.orderNumber = self.apiModel.data.order_no;
        view.delegate = self;
        [view setData:sect];
        return view;
    }
    if (sect.type == DDOrderStatusSectionTypeStatus) {
        DDOrderStatusTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DDOrderStatusTHFV"];
        [view setData:sect];
        return view;
    }
    if (sect.type == DDOrderStatusSectionTypeMerchantInfo || sect.type == DDOrderStatusSectionTypeDeliveryInfo) {
        DDOrderInfoTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DDOrderInfoTHFV"];
        [view setData:sect];
        if (sect.type == DDOrderStatusSectionTypeMerchantInfo) {
            view.button.tag = section;
            [view.button addTarget:self action:@selector(didTapMerchantCallBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        return view;
    }
    if (sect.type == DDOrderStatusSectionTypeDriverInfo) {
        DDDriverInfoTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DDDriverInfoTHFV"];
        [view setData:sect];
        return view;
    }
    return nil;
}
-(void)didTapMerchantCallBtn:(UIButton *)btn {
    DDOrderStatusSectionM *sect = self.apiModel.data.sections[btn.tag];
    [sect.phone_number makeCall];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    DDOrderStatusSectionM *sect = self.apiModel.data.sections[section];
    if (sect.type == DDOrderStatusSectionTypeDetail && sect.isExpanded) {
        DDOrderTotalTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DDOrderTotalTHFV"];
        
        [view setData:sect.order_detail];
        return view;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    DDOrderStatusSectionM *sect = self.apiModel.data.sections[section];
    if (sect.type == DDOrderStatusSectionTypeDetail && sect.isExpanded) {
        return UITableViewAutomaticDimension;
    }
    return 0.0;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setScrollViewVerticalContentOffset:scrollView.contentOffset.y];
}
-(void)didTapExpandCollapseButtonWithSection:(DDOrderStatusSectionM *)section {
    NSInteger index = [self.apiModel.data.sections indexOfObject:section];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:(UITableViewRowAnimationAutomatic)];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTapCancelButton:(id)sender {
    [DDHomeManager.shared cancelOrder:[self request] showHUD:YES onCompletion:^(DDBaseApiModel * _Nullable model, NSError * _Nullable error) {
        if (model.message.length > 0) {
            [DDAlertUtils showOkAlertWithTitle:@"" subtitle:model.message completion:^{
                if (model.successfulApi) {
                    [self goBackWithCompletion:nil];
                }
            }];
        }else {
            [DDAlertUtils showOkAlertWithTitle:@"" subtitle:error.localizedDescription completion:nil];
        }
    }];
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Order_Status andModuleName:@"DDHomeUI" withClassRef:self];
}
@end
