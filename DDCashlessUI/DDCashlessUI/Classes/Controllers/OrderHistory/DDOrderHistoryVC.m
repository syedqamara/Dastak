//
//  OrderHistoryVC.m
//  DDCashlessUI
//
//  Created by Hafiz Aziz on 07/04/2020.
//

#import "DDOrderHistoryVC.h"
#import "DDOrderHistoryTVC.h"
#import "DDCashlessUIConstants.h"
#import "DDCashlessManager.h"
#import "DDCashlessUIManager.h"
#import "DDLocations.h"

@interface DDOrderHistoryVC (){
    DDOrderStatusRequestM *orderStatusRequestM;
    DDCashlessRequestM* cashlessRequestM ;
    
}

@end

@implementation DDOrderHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    orderStatusRequestM = [DDOrderStatusRequestM new];
    cashlessRequestM = [DDCashlessRequestM new];
    self.title = @"Orders".localized;
    [self registerCells];
    [self getHistoryData];
    
}
-(void)registerCells{
    [super registerCells];
    NSArray *tableCells = @[DDOrderHistoryTableCell];
    [self.mainTableView registerCellWithNibNames:tableCells forClass:self.class withIdentifiers:tableCells];
    //    self.mainTableView.estimatedRowHeight = 156;
    //    self.mainTableView.rowHeight = UITableViewAutomaticDimension;
    //    self.monthCollectionView.dataSource = self;
    //    self.monthCollectionView.delegate = self;
}
- (void)setdata:(DDBaseHistoryModel *)data{
    NSString *currentYear = data.current_year;
    NSArray *tempArray = [data.month_wise_orders filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(DDOrderHistoryDataM  * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.month containsString:currentYear];
    }]];
    data.month_wise_orders = tempArray;
    if (data.month_wise_orders.count == 0) {
        [self showEmptyView:nil];
    }else{
        [super setdata:data];
    }
}


-(void)showEmptyView:(NSError* _Nullable)error {
    DDEmptyViewModel *emptyView = [DDEmptyViewModel new];
    emptyView.image = @"empty_base_history.png";
    emptyView.title = UNKNOWN_ERROR;
    emptyView.sub_title = SOMETHING_WDD_WRONG;
    
    if (error){
        emptyView.title = @"Error";
        emptyView.sub_title = error.localizedDescription;
        [DDAlertUtils showOkAlertWithTitle:@"Error" subtitle:error.localizedDescription completion:nil];
    }
    else {
        emptyView.title = @"You have not make any delivery/takeaway order(s) yet.".localized;
        emptyView.sub_title = @"Your delivery/takeaway order(s) will appear here.".localized;
    }
    [DDEmptyView showInConatiner:self.view withEmptyViewModel:emptyView completion:nil];
}


// MARK: - Fetch data from API
-(void)getHistoryData{
    DDHistoryRequestM * req = [[DDHistoryRequestM alloc] init];
    __weak typeof(self) weakSelf = self;
    [DDCashlessManager.shared getOrderHistory:req withCompletion:^(DDBaseHistoryAPIModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (model) {
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
    DDOrderHistoryTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDOrderHistoryTableCell];
    [cell setData:[self.filteredArray objectAtIndex:indexPath.row]];
    cell.buttonCallback = ^(DDOrderM * _Nonnull data, BOOL isreOrderSelected) {
        if (isreOrderSelected){
            [self checkAndValidateReorder:data];
            
        }else
            [self showOrderStatusScreen:data];
    };
    return cell;
}

-(void)showOrderStatusScreen: (DDOrderM*)orderData {
    orderStatusRequestM.order_id = orderData.order_id;
    [DDCashlessUIManager.shared showOrderStatus:orderStatusRequestM onController:self andControllerCallBack:^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {}];
}

-(void)checkAndValidateReorder:(DDOrderM*)orderObj {
    if ([orderObj.is_take_away_order boolValue]){
        [self validateOrder:orderObj];
    }
    else {
        __weak typeof(self) weakSelf = self;
        [DDCashlessUIManager showDeliveryLocationsVCFrom:self withData:nil andControllerCallBack:^(NSString * _Nonnull txt, id _Nonnull data, UIViewController * _Nonnull from) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [from.navigationController dismissViewControllerAnimated:YES completion:^{
                    [DDBasket.shared.currentOrder resetEditOrderDate];
                    [weakSelf validateOrder:orderObj];
                }];
            });
        }];
    }
    
}

-(void)validateOrder:(DDOrderM*)orderObj {
    cashlessRequestM.order_id = orderObj.order_id;
    [DDCashlessManager.shared validateReorder:cashlessRequestM withCompletion:^(DDCashlessReorderApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (model) {
            if (model.data.validation && model.data.validation.shouldDisplayAlert) {
                [DDAlertUtils showOkAlertWithTitle:model.data.validation.title subtitle:model.data.validation.message completion:nil];
            }
            else if (model.data.validation.shouldNavigateOnSelection) {
                [DDEditOrderTimer.shared stopOrReset];
                if (model.data.addedProducts != nil) {
                    DDCashlessMerchantM *merchant = [model.data.outlet.merchant.toDictionary decodeTo:DDCashlessMerchantM.class];
                    DDOrderBasketM *order = [[DDOrderBasketM alloc]init];
                    order.merchant = merchant;
                    order.outlet = model.data.outlet;
                    order.selected_region = DDBasket.shared.currentOrder.selected_region;
                    order.addedProducts = model.data.addedProducts.mutableCopy;
                    DDBasket.shared.currentOrder = order;
                    DDBasket.shared.currentOrder.saveAsJson;
                    [self openOutletDetail:orderObj];
                }
            }
        }
    }];
}

-(void)openOutletDetail:(DDOrderM*)orderObj{
    cashlessRequestM.outlet_id = orderObj.outlet_id;
    cashlessRequestM.merchant_id = orderObj.merchant_id;
    cashlessRequestM.is_delivery_tab_selected = @(!orderObj.is_take_away_order.boolValue);
    [DDCashlessUIManager.shared showCashlessMerchantDetailVCFrom:self withData:cashlessRequestM andControllerCallBack:nil];
}
@end
