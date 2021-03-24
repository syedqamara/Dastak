//
//  DDOrderStatusVC.m
//  DDCashlessUI
//
//  Created by Syed Qamar Abbas on 30/03/2020.
//

#import "DDOrderStatusVC.h"
#import "DDModels.h"
#import "DDCashless.h"
#import "DDCashlessOrderInfoTHFV.h"
#import "DDCashlessDriverInfoTHFV.h"
#import "DDCashlessViewOrderTHFV.h"
#import "DDCashlessOrderDeliverToTHFV.h"
#import "DDCashlessOrderConcernsTHFV.h"
#import "DDCashlessOrderPickupTHFV.h"
#import "DDCashlessOrderPickupAddressTHFV.h"
#import "DDCashlessOrderCollectTHFV.h"
#import "DDCashlessOrderItemTVC.h"
@interface DDOrderStatusVC ()<UITableViewDelegate, UITableViewDataSource, DDCashlessViewOrderTHFVDelegate, DDCashlessOrderPickupDelegate> {
    BOOL navigationBarHidden;
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomButtonsContainerView;

@property (weak, nonatomic) IBOutlet UIView *editButtonContainerView;
@property (weak, nonatomic) IBOutlet UIView *cancelButtonContainerView;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) DDOrderDetailApiM *orderDetail;
@property (strong, nonatomic) NSDate *orderPlacedDate;
@property (readonly, nonatomic) DDOrderStatusRequestM *orderRequest;

@end

@implementation DDOrderStatusVC
-(DDOrderStatusRequestM *)orderRequest {
    return (DDOrderStatusRequestM *)self.navigation.routerModel.data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackArrowNavigtaionItemWithtitle:@"Back"];
    [DDBasket resetEditIdleOrderTimerAndMarkOrderIdNil:self.orderRequest.order_id];
    
    if (!self.orderRequest.shouldRetainBasketForEditOrder) {
        [DDBasket.shared resetBasketForceReset:YES];
    }
    [self loadCompleteDataFromApi:YES];
    [self setupTableView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    navigationBarHidden = self.navigationController.navigationBarHidden;
    self.navigationController.navigationBarHidden = NO;
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didAppBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = navigationBarHidden;
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[DDOrderTimer shared] stopOrReset];
    [self checkAndStopOrderStatusTimer];
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self checkAndStopOrderStatusTimer];
    });
    DDBasket.shared.webView = nil;
    DDBasket.shared.request = nil;
}

- (void)designUI {
    [self shouldHideEditButton:YES];
    self.tableView.backgroundColor = CASHLESS_THEME.bg_grey_240.colorValue;
    self.title = @"Order status".localized;
    
    [self.editButton setTitle:@"Edit Order".localized forState:(UIControlStateNormal)];
    [self.cancelButton setTitle:@"Cancel Order".localized forState:(UIControlStateNormal)];
    
    self.editButton.titleLabel.font = [UIFont DDBoldFont:17];
    self.cancelButton.titleLabel.font = [UIFont DDBoldFont:17];
    [self.editButton setTitleColor:CASHLESS_THEME.bg_white.colorValue forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:CASHLESS_THEME.app_theme.colorValue forState:UIControlStateNormal];
    self.editButton.backgroundColor = CASHLESS_THEME.app_theme.colorValue;
    self.cancelButton.backgroundColor = CASHLESS_THEME.bg_white.colorValue;
    [self.editButton setCornerR:5];
    [self.cancelButton setCornerR:5];
    self.bottomButtonsContainerView.backgroundColor = CASHLESS_THEME.bg_white.colorValue;
    
    [self setThemeNavigationBar];
}

-(void)setupTableView {
    NSArray *cells = @[];
    [self.tableView registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    NSArray *header = @[CashlessOrderCollectTHFV,CashlessOrderPickupAddressTHFV,CashlessOrderPickupTHFV, CashlessOrderInfoTHFV, CashlessDriverInfoTHFV, CashlessViewOrderTHFV, CashlessOrderDeliverToTHFV, CashlessOrderConcernsTHFV];
    [self.tableView registerHeaderFooterWithNibNames:header forClass:self.class withIdentifiers:header];
    [self.tableView registerCellWithNibNames:@[CashlessOrderItemTVC] forClass:self.class withIdentifiers:@[CashlessOrderItemTVC]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 62;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = 66.0;
    self.tableView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];
    if (@available(iOS 11.0, *)) {
        [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }

    __weak typeof (self) weakSelf = self;
    [self setupPullToRefreshOn:self.tableView withStartRefreshing:^{
        [weakSelf loadCompleteDataFromApi:NO];
    }];
}

-(void)loadOrderStatus {
    [DDCashlessManager.shared orderStatus:self.orderRequest showHUD:NO andOrderDetail:self.orderDetail withCompletion:^(DDOrderDetailApiM * _Nullable model, NSError * _Nullable error) {
        if (self.orderDetail.data.orderStatus.isOrderCompleted) {
            [self checkAndStopOrderStatusTimer];
        }
        if ([self.orderDetail.data.orderStatus isOrderRejected] && ![self.orderDetail.data.orderDetail isOrderRejected]){
            [self checkAndStopOrderStatusTimer];
            [self showOrderRejectedAlert];
        }
        [self.tableView reloadData];
    }];
}
-(void)showOrderRejectedAlert {
    NSString *title = @"Order rejected";
    NSString *detail = @"Unfortunately the restaurant has had to cancel your order. We will be following up with them to ensure this does not happen again. We have refunded your payment. ";
    [DDAlertUtils showOkAlertWithTitle:title subtitle:detail completion:^{}];
}
-(void)loadCompleteDataFromApi:(BOOL)showHUD {
    [self checkAndStopOrderStatusTimer];
    __weak typeof(self) weakSelf = self;
    [DDCashlessManager.shared completeOrderStatusApi:self.orderRequest showHUD:showHUD withCompletion:^(DDOrderDetailApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        weakSelf.orderDetail = model;
        [weakSelf resetTimerToCallOrderStatus];
        [weakSelf startBeforeEditOrderTimer];
        [weakSelf.tableView reloadData];
        [weakSelf stopPullToRefresh];
    }];
}
-(void)startBeforeEditOrderTimer {
    if (self.orderRequest.type == DDOrderStatusOrderTypeNewOrder) {
        if (![DDOrderTimer.shared isTimerRunning]){
            [self initiateTimer:0];
        }
    }
    [self shouldHideEditButton:NO];
}
-(void)resetTimerToCallOrderStatus {
    if (self.orderDetail.data.orderDetail != nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:self.orderDetail.data.orderDetail.order_status_refresh_interval.doubleValue repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self loadOrderStatus];
        }];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.orderDetail.data.sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DDOrderDetailSectionM *sect = self.orderDetail.data.sections[section];
    if (sect.type == DDOrderDetailSectionTypeOrderDetail) {
        return 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDOrderDetailSectionM *sect = self.orderDetail.data.sections[indexPath.section];
    if (sect.type == DDOrderDetailSectionTypeOrderDetail) {
        DDCashlessOrderItemTVC *cell = [tableView dequeueReusableCellWithIdentifier:CashlessOrderItemTVC];
        [cell setData:sect];
        [cell layoutIfNeeded];
        return cell;
    }
    return [UITableViewCell new];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setScrollViewVerticalContentOffset:scrollView.contentOffset.y];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DDOrderDetailSectionM *sect = self.orderDetail.data.sections[section];
    if (sect.type == DDOrderDetailSectionTypeOrderStatus) {
        DDCashlessOrderInfoTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessOrderInfoTHFV];
        [view setData:sect.order_status];
        return view;
    }
    else if (sect.type == DDOrderDetailSectionTypeLastMileInfo) {
        DDCashlessDriverInfoTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessDriverInfoTHFV];
        [view setData:sect.order_status];
        return view;
    }
    else if (sect.type == DDOrderDetailSectionTypeOrderDetail) {
        DDCashlessViewOrderTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessViewOrderTHFV];
        [view setData:sect];
        view.delegate = self;
        return view;
    }
    else if (sect.type == DDOrderDetailSectionTypeCustomerDetails) {
        DDCashlessOrderDeliverToTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessOrderDeliverToTHFV];
        [view setData:sect];
        return view;
    }
    else if (sect.type == DDOrderDetailSectionTypeQuestion) {
        DDCashlessOrderConcernsTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessOrderConcernsTHFV];
        [view setData:sect];
        return view;
    }
    else if (sect.type == DDOrderDetailSectionTypeOrderPickup) {
        DDCashlessOrderPickupTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessOrderPickupTHFV];
        view.delegate = self;
        [view setData:sect];
        return view;
    }
    else if (sect.type == DDOrderDetailSectionTypeCollect) {
        DDCashlessOrderCollectTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessOrderCollectTHFV];
        [view setData:sect];
        return view;
    }
    else if (sect.type == DDOrderDetailSectionTypePickupAddress) {
        DDCashlessOrderPickupAddressTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessOrderPickupAddressTHFV];
        [view setData:sect];
        return view;
    }
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
-(void)didTapExpandButton {
    NSInteger index = -1;
    for (DDOrderDetailSectionM *sect in self.orderDetail.data.sections) {
        if (sect.type == DDOrderDetailSectionTypeOrderDetail) {
            index = [self.orderDetail.data.sections indexOfObject:sect];
        }
    }
//    [UIView performWithoutAnimation:^{
//        [self.tableView reloadData];
//    }];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:(UITableViewRowAnimationNone)];
}
-(void)didTapPickupOrderButton {
    [DDCashlessManager.shared orderPickedup:self.orderRequest withCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (model.code.integerValue == 200 && model.message.length > 0) {
            [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:^{}];
        }else if (model.message.length > 0){
            [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:^{}];
        }else {
            [DDAlertUtils showOkAlertWithTitle:@"" subtitle:error.localizedDescription completion:^{}];
        }
    }];
}
-(void)startEditingOrder {
    [DDOrderTimer.shared stopOrReset];
    DDBasket.shared.currentOrder.order_id = self.orderRequest.order_id;
    DDBasket.shared.currentOrder.purchased_order_date = self.orderPlacedDate;
    DDBasket.shared.currentOrder.edit_order_date = [NSNumber numberWithDouble:[NSDate date].timeIntervalSince1970];
    [DDBasket.shared.currentOrder resetEditOrderDate];
    [super goBackWithCompletion:^{}];
}
-(void)didAppBecomeActive {
    if (self.orderRequest.type == DDOrderStatusOrderTypeNewOrder) {
        [self refreshEditOrderStatus:NO];
    }
    [self checkAndRunOrderStatusTimer:NO];
}
-(void)refreshEditOrderStatus:(BOOL)refresh {
    if (self.orderPlacedDate != nil) {
        [[DDOrderTimer shared] stopOrReset];
        int seconds = [DDOrderTimer getSeconds:self.orderPlacedDate];
        if (seconds >= DDBasket.shared.currentOrder.merchant.edit_order_timer_value.intValue){
            [self shouldHideEditButton:YES];
            self.orderPlacedDate = nil;
            
        } else {
            int remainingSeconds = DDBasket.shared.currentOrder.merchant.edit_order_timer_value.intValue - seconds;
            [self initiateTimer:remainingSeconds];
        }
    }
}
- (void)initiateTimer:(int) remainingSeconds
{
    if (!self.orderRequest.isAllowEdit) {
        [DDOrderTimer.shared stopOrReset];
        return;
    }
    NSTimeInterval time = 0;
    if (DDBasket.shared.currentOrder.order_id != nil) {
        time = DDBasket.shared.currentOrder.merchant.edit_order_timer_value.doubleValue;
        if (remainingSeconds == 0){
            self.orderPlacedDate = [NSDate date];
        }
    }
    
    if (remainingSeconds > 0){
        time = remainingSeconds;
    }
    if (![DDBasket.shared isOrderInEditState]) {
        [DDBasket.shared loadTimerWithTime:time shouldClearBasketOnCompletion:YES withCompletion:^(NSTimeInterval totalTime, NSTimeInterval remainingTime, BOOL isFinished) {
            if (isFinished) {
                [self.orderRequest setAllowEdit:NO];
                [self shouldHideEditButton:YES];
                self.orderPlacedDate = nil;
            }
        }];
    }else {
        if (DDBasket.shared.currentOrder.orderID == self.orderRequest.orderID) {
            [self shouldHideEditButton:NO];
        }else {
            [self shouldHideEditButton:YES];
        }
    }
}
-(void)checkAndRunOrderStatusTimer:(BOOL)refresh {
    if (![UIApplication isInternetConnected]){
        return;
    }
    
    
    if (self.orderDetail.data.orderStatus.isOrderRejected){
        return;
    }
    [self loadOrderStatus];
    if (!self.orderDetail.data.orderDetail.isOrderRejected) {
        if (self.orderDetail.data.orderDetail) {
            [self checkAndStopOrderStatusTimer];
            [self resetTimerToCallOrderStatus];
        }
    }
}
-(void) checkAndStopOrderStatusTimer{
    if (timer != nil){
        [timer  invalidate];
    }
    timer = nil;
}
- (IBAction)didTapEditButton:(id)sender {
    [DDOrderTimer.shared pauseTimer];
    [DDCashlessManager.shared editOrder:self.orderRequest withCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            [self startEditingOrder];
        }else {
            [DDOrderTimer.shared resumeTimer];
            [DDAlertUtils showOkAlertWithTitle:@"" subtitle:error.localizedDescription completion:^{}];
        }
    }];
}
-(void)goBackWithCompletion:(void (^)(void))completion {
    __weak typeof(self) weakSelf = self;
    void (^backCompletion)(void) = ^{
        [weakSelf.navigation.routerModel sendDataCallback:nil withData:nil withController:self];
        if (completion != nil) {
            completion();
        }
    };
    if ([[DDOrderTimer shared] isTimerRunning] && self.orderRequest.isAllowEdit) {
        __weak typeof(self) weakSelf = self;
        [DDAlertUtils showAlertWithTitle:@"" subtitle:@"Are you sure you want to navigate away \nfrom this screen?\nYou will no longer be able to edit\nyour order." buttonNames:@[@"Cancel",@"CONTINUE"] onClick:^(int index) {
            if (index == 1) {
                [weakSelf resetBasketWhenGoBack];
                [super goBackWithCompletion:backCompletion];
            }
        }];
    }else {
        [super goBackWithCompletion:backCompletion];
    }
}

-(void)resetBasketWhenGoBack {
    [self checkAndStopOrderStatusTimer];
    [DDBasket.shared resetBasketForceReset:YES];
    [DDOrderTimer.shared stopOrReset];
}
-(void)shouldHideEditButton:(BOOL)shouldHideEditButton {
    BOOL showEditButton = (!shouldHideEditButton && self.orderRequest.isAllowEdit);
    [self.editButtonContainerView setHidden:!showEditButton];
    
    BOOL showCancelButton = self.orderDetail.data.orderStatus.isShowCancelButton;
    [self.cancelButtonContainerView setHidden:!showCancelButton];
}
- (IBAction)didTapCancelButton:(id)sender {
    
}
+(NSArray<DDUIRouterM *> *)deeplinkRoutes {
    DDUIRouterM *route = [DDUIRouterM new];
    route.route_link = DD_Nav_Cashless_Order_Status;
    route.transition = DDUITransitionPush;
    route.action_identifier = @"deeplink";
    return @[route];
}
@end
