//
//  DDSearchManager.m
//  DDSearch
//
//  Created by Syed Qamar Abbas on 14/01/2020.
//

#import "DDSearchManager.h"
#import "DDNetwork.h"
@implementation DDSearchManager
static DDSearchManager * _sharedObject;
+(DDSearchManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDSearchManager alloc]init];
    });
    return _sharedObject;
}
-(void)searchWithRequest:(DDBaseRequestModel *)searchRequestModel showHUD:(BOOL)showHUD completion:(void (^)(DDSearchApiM * _Nullable model, NSError * _Nullable error))completion {
    [DDNetworkManager.shared post:DDApisType_Outlet_Search showHUD:showHUD withParam:searchRequestModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDSearchApiM *apiModel = (DDSearchApiM *)model;
        completion(apiModel, error);
    }];
}
-(void)fetchFiltersWithRequest:(DDBaseRequestModel *)requestModel showHUD:(BOOL)showHUD completion:(void (^)(DDFiltersApiM * _Nullable model, NSError * _Nullable error))completion {
    [DDNetworkManager.shared post:DDApisType_Filter_Get_Filters showHUD:showHUD withParam:requestModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDFiltersApiM *apiModel = (DDFiltersApiM *)model;
        completion(apiModel, error);
    }];
}


@end
