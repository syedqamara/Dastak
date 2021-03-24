//
//  DDCashlessApiManager.m
//  
//
//  Created by Syed Qamar Abbas on 17/03/2020.
//

#import "DDCashlessApiManager.h"
#import "DDNetwork.h"

#define KEP_CASHLESS_CANCEL_ORDER @"cashless/cancel_order"
#define KEP_CASHLESS_EDIT_ORDER @"cashless/edit_order"
#define KEP_CASHLESS_EDIT_ORDER_STATE @"cashless/edit_order_state"
#define KEP_CASHLESS_ORDER_PICKED_UP @"cashless/order_picked_up"
#define KEP_CASHLESS_ORDER_CURRDD_STATUS @"cashless/order_current_status"
#define KEP_CASHLESS_ORDER_DETAIL @"cashless/order_details"
#define KEP_CASHLESS_PENDING_ORDER_STATUS @"cashless/pending_order_status"
#define KEP_CASHLESS_MERCHANT_DETAIL @"merchants/:merchant_id"
#define KEP_CASHLESS_OUTLETS @"outlets_cashless" //need to change to "outlets"
#define KEP_CASHLESS_ORDER_HISTORY @"cashless/order_history" //need to change to "order_history"
#define KEP_CASHLESS_REORDER_VALIDATION @"cashless/re-order/validation"
#define KEP_CASHLESS_OUTLET_ONLINE_STATUS @"outlet_online_state"

@implementation DDCashlessApiManager
-(void)reorder{}
-(void)orderHistory {}
-(void)validateReorder {}
-(void)merchantDetail {}
-(void)orderDetail {}
-(void)orderCurrentStatus {}
-(void)pendingOrderStatus {}
-(void)outletOnlineStatus {}
-(void)editOrder{}
-(void)checkEditOrder{}
-(void)cancelOrder{}
-(void)orderPickedup{}
+(void)registerApiConfiguration {
    
    
    [DDApisConfiguration registerConfigurations:(DDApisType_Cashless_Current_Check_Edit_Order) classObj:self.class responseClassObj:DDBaseApiModel.class selector:@selector(checkEditOrder) endPoint:KEP_CASHLESS_EDIT_ORDER_STATE isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:(DDApiAuthorizationTypeBasicAuth)];
    
    [DDApisConfiguration registerConfigurations:(DDApisType_Cashless_Current_Cancel_Order) classObj:self.class responseClassObj:DDBaseApiModel.class selector:@selector(cancelOrder) endPoint:KEP_CASHLESS_CANCEL_ORDER isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:(DDApiAuthorizationTypeBasicAuth)];
    
    [DDApisConfiguration registerConfigurations:(DDApisType_Cashless_Current_Edit_Order) classObj:self.class responseClassObj:DDBaseApiModel.class selector:@selector(editOrder) endPoint:KEP_CASHLESS_EDIT_ORDER isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:(DDApiAuthorizationTypeBasicAuth)];
    
    [DDApisConfiguration registerConfigurations:(DDApisType_Cashless_Current_Order_Picked_Up) classObj:self.class responseClassObj:DDBaseApiModel.class selector:@selector(orderPickedup) endPoint:KEP_CASHLESS_ORDER_PICKED_UP isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:(DDApiAuthorizationTypeBasicAuth)];
    
    
    [DDApisConfiguration registerConfigurations:(DDApisType_Cashless_Current_Order_Status) classObj:self.class responseClassObj:DDOrderStatusAPIM.class selector:@selector(orderCurrentStatus) endPoint:KEP_CASHLESS_ORDER_CURRDD_STATUS isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:(DDApiAuthorizationTypeBasicAuth)];
    
    [DDApisConfiguration registerConfigurations:(DDApisType_Cashless_Pending_Order_Status) classObj:self.class responseClassObj:DDFABListAPIM.class selector:@selector(pendingOrderStatus) endPoint:KEP_CASHLESS_PENDING_ORDER_STATUS isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:(DDApiAuthorizationTypeBasicAuth)];
    
    [DDApisConfiguration registerConfigurations:(DDApisType_Cashless_Order_Detail) classObj:self.class responseClassObj:DDOrderDetailApiM.class selector:@selector(orderDetail) endPoint:KEP_CASHLESS_ORDER_DETAIL isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:(DDApiAuthorizationTypeBasicAuth)];
    
    [DDApisConfiguration registerConfigurations:(DDApisType_Cashless_Reorder_Validation) classObj:self.class responseClassObj:DDCashlessReorderApiM.class selector:@selector(validateReorder) endPoint:KEP_CASHLESS_REORDER_VALIDATION isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:(DDApiAuthorizationTypeBasicAuth)];
    
    [DDApisConfiguration registerConfigurations:(DDApisType_Cashless_Merchant_Detail) classObj:self.class responseClassObj:DDCashlessMerchantApiM.class selector:@selector(merchantDetail) endPoint:KEP_CASHLESS_MERCHANT_DETAIL isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:(DDApiAuthorizationTypeBasicAuth)];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Cashless_Outlet_Online_Status classObj:self.class responseClassObj:DDLastMileRegionCheckApiM.class selector:@selector(outletOnlineStatus) endPoint:KEP_CASHLESS_OUTLET_ONLINE_STATUS isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Cashless_Order_History classObj:self responseClassObj:DDBaseHistoryAPIModel.class selector:@selector(orderHistory) endPoint:KEP_CASHLESS_ORDER_HISTORY isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Cashless_Order_Reorder classObj:self responseClassObj:DDOrderHistoryApiM.class selector:@selector(reorder) endPoint:KEP_CASHLESS_ORDER_HISTORY isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
}
@end

