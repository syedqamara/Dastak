//
//  DDCashlessManager.h
//  DDCashless
//
//  Created by Syed Qamar Abbas on 17/03/2020.
//

#import <Foundation/Foundation.h>
#import "DDModels.h"
#import <DDNetwork/DDNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDCashlessManager : NSObject
+(DDCashlessManager *)shared;

-(void)merchantDetail:(DDCashlessRequestM * _Nullable)requestM withCompletion:(void (^)(DDCashlessMerchantApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)fetchOuteltsWithRequest:(DDOutletsRequestM * _Nullable)requestM showLoader:(BOOL)showLoader completion:(void (^)(DDOutletApiM * _Nullable model, NSError * _Nullable error))completion;
-(void)allMerchantDetailApis:(DDCashlessRequestM * _Nullable)requestM withCompletion:(void (^)(DDCashlessMerchantApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)validateReorder:(DDCashlessRequestM * _Nullable)requestM withCompletion:(void (^)(DDCashlessReorderApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)checkLastMileRegion:(DDCashlessRequestM * _Nullable)requestM withCompletion:(void (^)(DDLastMileRegionCheckApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)fetchCashlessFiltersWithCompletion:(void (^ _Nullable)(DDFiltersApiModel * _Nullable model, NSError * _Nullable error))completion;

-(void)getOrderHistory:(DDHistoryRequestM * )historyRequestModel  withCompletion:(void (^)(DDBaseHistoryAPIModel * _Nullable model,NSURLResponse * _Nullable response, NSError * _Nullable error)) completion;
-(void)orderStatus:(DDOrderStatusRequestM *)orderReqeust showHUD:(BOOL)showHUD andOrderDetail:(DDOrderDetailApiM *)detail  withCompletion:(void(^ _Nullable)(DDOrderDetailApiM * _Nullable model, NSError * _Nullable error))completion;
-(void)completeOrderStatusApi:(DDOrderStatusRequestM *)orderReqeust showHUD:(BOOL)showHUD withCompletion:(void(^)(DDOrderDetailApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)cancelOrder:(DDOrderStatusRequestM *)orderReqeust withCompletion:(void(^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)editOrder:(DDOrderStatusRequestM *)orderReqeust withCompletion:(void(^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)orderPickedup:(DDOrderStatusRequestM *)orderReqeust withCompletion:(void(^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
@end

NS_ASSUME_NONNULL_END
