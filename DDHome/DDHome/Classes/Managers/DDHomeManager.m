//
//  DDHomeManager.m
//  DDHome
//
//  Created by Zubair Ahmad on 21/01/2020.
//

#import "DDHomeManager.h"
#import "DDNetwork.h"
#import <DDStorage/DDStorage.h>
#import "DDUserManager.h"

@implementation DDHomeManager
static DDHomeManager *_sharedObject;
+(DDHomeManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [DDHomeManager.alloc init];
    });
    return _sharedObject;
}

-(void)fetchHomeDataWithReq:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(HomeCompletionCallback)completion {
    [DDNetworkManager.shared post:DDApisType_Home_Home showHUD:showHUD withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDHomeApiM *home = (DDHomeApiM *)model;
        if (completion!=nil) {
            completion(home, error);
        }
    }];
}
-(void)fetchMerchantDetailWithReq:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(MerchantDetailCompletionCallback)completion {
    [DDNetworkManager.shared post:DDApisType_Cashless_Merchant_Detail showHUD:showHUD withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDMerchantApiM *merchant = (DDMerchantApiM *)model;
        if (completion != nil) {
            completion(merchant, error);
        }
    }];
}

-(void)fetchOrderHistoryWithReq:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(OrderHistoryCompletionCallback)completion {
    [DDNetworkManager.shared post:DDApisType_Cashless_Order_History showHUD:showHUD withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDOrderHistoryApiM *castedModel = (DDOrderHistoryApiM *)model;
        if (completion != nil) {
            completion(castedModel, error);
        }
    }];
}

-(void)fetchOutletListingWithReq:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(OuletListingCompletion)completion {
    [DDNetworkManager.shared post:DDApisType_Outlet_Listing showHUD:showHUD withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDOutletApiM *castedModel = (DDOutletApiM *)model;
        if (completion != nil) {
            completion(castedModel, error);
        }
    }];
}

-(void)fetchFavOutletListingWithReq:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(OuletListingCompletion)completion {
    [DDNetworkManager.shared get:DDApisType_Favourites_Favourites showHUD:showHUD withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDOutletApiM *castedModel = (DDOutletApiM *)model;
        if (completion != nil) {
            completion(castedModel, error);
        }
    }];
}

-(void)fetchOrderDetailWithReq:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(OrderDetailCompletionCallback)completion {
    [DDNetworkManager.shared post:DDApisType_Cashless_Order_Detail showHUD:showHUD withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDOrderStatusApiM *order = (DDOrderStatusApiM *)model;
        if (completion != nil) {
            completion(order, error);
        }
    }];
}
-(void)markFavourite:(DDMerchantRM * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(DefaultApiCompletionCallback)completion {
    [DDNetworkManager.shared post:DDApisType_Favourites_Mark_Favourites showHUD:showHUD withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion(model, error);
        }
    }];
}
-(void)cancelOrder:(DDOrderRM * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(DefaultApiCompletionCallback)completion {
    [DDNetworkManager.shared post:DDApisType_Cashless_Current_Cancel_Order showHUD:showHUD withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion(model, error);
        }
    }];
}

-(void)calculateFair:(DDC2CFairsRM * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(DefaultApiCompletionCallback)completion {
    [DDNetworkManager.shared post:DDApisType_C2C_FAIRS showHUD:showHUD withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion(model, error);
        }
    }];
}

-(void)rating:(DDRatingRM * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(DefaultApiCompletionCallback)completion {
    [DDNetworkManager.shared post:DDApisType_Submit_Rating showHUD:showHUD withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion != nil) {
            completion(model, error);
        }
    }];
}




@end
