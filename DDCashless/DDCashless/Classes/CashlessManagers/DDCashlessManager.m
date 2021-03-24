//
//  DDCashlessManager.m
//  DDCashless
//
//  Created by Syed Qamar Abbas on 17/03/2020.
//

#import "DDCashlessManager.h"
#import <DDFilters/DDFilters.h>
#import <DDOutlets/DDOutlets.h>

@implementation DDCashlessManager
static DDCashlessManager * _sharedObject;
+(DDCashlessManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [DDCashlessManager.alloc init];
    });
    return _sharedObject;
}
-(void)validateReorder:(DDCashlessRequestM * _Nullable)requestM withCompletion:(void (^)(DDCashlessReorderApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    [DDNetworkManager.shared post:(DDApisType_Cashless_Reorder_Validation) showHUD:YES withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDCashlessReorderApiM *apiModel = (DDCashlessReorderApiM *)model;
        completion(apiModel, response, error);
    }];
}
-(void)orderHistory:(DDCashlessRequestM * _Nullable)requestM withCompletion:(void (^)(DDOrderHistoryApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    [DDNetworkManager.shared post:(DDApisType_Cashless_Order_Reorder) showHUD:YES withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDOrderHistoryApiM *merchant = (DDOrderHistoryApiM *)model;
        completion(merchant, response, error);
    }];
}
-(void)merchantDetail:(DDCashlessRequestM * _Nullable)requestM withCompletion:(void (^)(DDCashlessMerchantApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    [DDNetworkManager.shared post:DDApisType_Cashless_Merchant_Detail showHUD:YES withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDCashlessMerchantApiM *merchant = (DDCashlessMerchantApiM *)model;
        completion(merchant, response, error);
    }];
}
-(void)allMerchantDetailApis:(DDCashlessRequestM * _Nullable)requestM withCompletion:(void (^)(DDCashlessMerchantApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    [self orderHistory:requestM withCompletion:^(DDOrderHistoryApiM * _Nullable historymodel, NSURLResponse * _Nullable historyresponse, NSError * _Nullable historyerror) {
        [self merchantDetail:requestM withCompletion:^(DDCashlessMerchantApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSMutableArray <DDMerchantDetailSectionM, Optional> *arr = [NSMutableArray<DDMerchantDetailSectionM, Optional> new];
            for (DDMerchantDetailSectionM *sect in model.data.merchant.sections.mutableCopy) {
                if (sect.getType == DDMerchantSectionCashlessReorder) {
                    if (historymodel.data.orders.count == 0) {
                        continue;
                    }
                    sect.reorders = historymodel.data.orders;
                }
                if (sect.shouldHaveHeaderView) {
                    [arr addObject:sect];
                }
            }
            model.data.merchant.sections = arr;
            completion(model, response, error);
        }];
    }];
}

- (void)checkLastMileRegion:(DDCashlessRequestM *)requestM withCompletion:(void (^)(DDLastMileRegionCheckApiM * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    [DDNetworkManager.shared post:DDApisType_Cashless_Outlet_Online_Status
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDLastMileRegionCheckApiM *apiModel = (DDLastMileRegionCheckApiM *)model;
        completion(apiModel, response, error);
    }];
}

-(void)fetchOuteltsWithRequest:(DDOutletsRequestM * _Nullable)requestM showLoader:(BOOL)showLoader completion:(void (^)(DDOutletApiM * _Nullable model, NSError * _Nullable error))completion {
    requestM.radius = nil;
    [DDOutletsManager.shared fetchListOfOutlets:requestM
                                      showLoader:showLoader
                                   andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDOutletApiM *outletsApi = (DDOutletApiM *)model;
        if (completion)
            completion(outletsApi, error);
    }];
}

-(void)fetchCashlessFiltersWithCompletion:(void (^ _Nullable)(DDFiltersApiModel * _Nullable model, NSError * _Nullable error))completion {
    [DDFiltersManager.shared fetchDeliveryFiltersWithCompletion:^(DDFiltersApiModel * _Nullable model, NSError * _Nullable error) {
        if (completion) {
            completion(model, error);
        }
    }];
}
// MARK:- Order History
- (void)getOrderHistory:(DDHistoryRequestM *)historyRequestModel withCompletion:(void (^)(DDBaseHistoryAPIModel * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion{
    
    [DDNetworkManager.shared post:DDApisType_Cashless_Order_History showHUD:YES withParam:historyRequestModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDBaseHistoryAPIModel *apiData = (DDBaseHistoryAPIModel*)model;
        if (completion != nil)
            completion(apiData,response,error);
    }];
}

-(void)orderStatus:(DDOrderStatusRequestM *)orderReqeust showHUD:(BOOL)showHUD andOrderDetail:(DDOrderDetailApiM *)detail  withCompletion:(void(^ _Nullable)(DDOrderDetailApiM * _Nullable model, NSError * _Nullable error))completion {
    orderReqeust.is_new_order_status_flow = @(YES);
    orderReqeust.is_last_mile_enabled = @(YES);
    [DDNetworkManager.shared post:(DDApisType_Cashless_Current_Order_Status)
                           showHUD:showHUD
                         withParam:orderReqeust
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDOrderStatusAPIM *apiModel = (DDOrderStatusAPIM *)model;
        if (apiModel.data != nil) {
            NSMutableArray <DDOrderDetailSectionM, Optional>*newSections = apiModel.data.orderDetailSections.mutableCopy;
            NSMutableArray <DDOrderDetailSectionM, Optional>*oldSectionArray = detail.data.sections.mutableCopy;
            NSMutableArray <DDOrderDetailSectionM, Optional>*oldSection = detail.data.sections.mutableCopy;
            for (DDOrderDetailSectionM *oldSect in oldSection) {
                if (oldSect.isLocalSections) {
                    [oldSectionArray removeObject:oldSect];
                }
            }
            [newSections addObjectsFromArray:oldSectionArray];
            detail.data.sections = newSections;
        }
        if (completion)
            completion(detail , error);
    }];
}
-(void)completeOrderStatusApi:(DDOrderStatusRequestM *)orderReqeust showHUD:(BOOL)showHUD withCompletion:(void(^)(DDOrderDetailApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    [self orderDetail:orderReqeust showHUD:showHUD withCompletion:^(DDOrderDetailApiM * _Nullable detail, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self orderStatus:orderReqeust showHUD:showHUD andOrderDetail:detail withCompletion:^(DDOrderDetailApiM * _Nullable model, NSError * _Nullable error) {
            if (completion) {
                completion(model, response, error);
            }
        }];
    }];
}
-(void)orderDetail:(DDOrderStatusRequestM *)orderReqeust showHUD:(BOOL)showHUD withCompletion:(void(^)(DDOrderDetailApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    orderReqeust.is_new_order_status_flow = @(YES);
    orderReqeust.is_last_mile_enabled = @(YES);
    [DDNetworkManager.shared post:(DDApisType_Cashless_Order_Detail) showHUD:showHUD withParam:orderReqeust andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDOrderDetailApiM *apiModel = (DDOrderDetailApiM *)model;
        completion(apiModel, response, error);
    }];
}


-(void)cancelOrder:(DDOrderStatusRequestM *)orderReqeust withCompletion:(void(^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    [DDNetworkManager.shared post:(DDApisType_Cashless_Current_Cancel_Order) showHUD:YES withParam:orderReqeust andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(model, response, error);
    }];
}
-(void)editOrder:(DDOrderStatusRequestM *)orderReqeust withCompletion:(void(^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    [DDNetworkManager.shared post:(DDApisType_Cashless_Current_Edit_Order) showHUD:YES withParam:orderReqeust andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(model, response, error);
    }];
}
-(void)checkEditOrder:(DDOrderStatusRequestM *)orderReqeust withCompletion:(void(^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    [DDNetworkManager.shared post:(DDApisType_Cashless_Current_Check_Edit_Order) showHUD:YES withParam:orderReqeust andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(model, response, error);
    }];
}
-(void)orderPickedup:(DDOrderStatusRequestM *)orderReqeust withCompletion:(void(^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    [DDNetworkManager.shared post:(DDApisType_Cashless_Current_Order_Picked_Up) showHUD:YES withParam:orderReqeust andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(model, response, error);
    }];
}


@end
