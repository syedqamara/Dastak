//
//  DDProductManager.m
//  DDProducts
//
//  Created by Syed Qamar Abbas on 30/01/2020.
//

#import "DDProductManager.h"
#import "DDNetwork.h"
#import "DDModels.h"
@implementation DDProductManager

static DDProductManager *_sharedObject;

//+(DDProductManager *)shared {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedObject = [[DDProductManager alloc]init];
//    });
//    return _sharedObject;
//}

+(void)loadProfileSectionWithModel:(DDBaseRequestModel *)model showLoader: (BOOL)showLoader withCompletion:(void (^)(DDProfileApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    
    [DDNetworkManager.shared get:DDApisType_Products_Profile_Section showHUD:showLoader withParam:model andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion((DDProfileApiM*)model,response,error);
    }];
    
}

+(void)loadMerchantDetailSectionProducts:(DDBaseRequestModel *)model showLoader: (BOOL)showLoader withCompletion:(void (^)(DDProfileApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    [DDNetworkManager.shared get:DDApisType_Products_Merchant_Detail showHUD:showLoader withParam:model andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion((DDProfileApiM*)model,response,error);
    }];
    
}

+(void)loadProductsWithModel:(DDBaseRequestModel *)model withCompletion:(void (^)(DDProductPurchaseApiDataM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    
    [DDNetworkManager.shared get:DDApisType_Products_Purchase_History showHUD:YES withParam:model andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDProductPurchaseApiM * data = (DDProductPurchaseApiM*)model;
        
        completion(data.data,response,error);
    }];
    
}
@end
