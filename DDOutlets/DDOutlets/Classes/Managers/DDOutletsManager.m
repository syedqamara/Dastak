//
//  DDOutletsManager.m
//  DDOutlets
//
//  Created by Zubair Ahmad on 21/01/2020..
//  Copyright © 2020 The Entertainer. All rights reserved.
//

#import "DDOutletsManager.h"
#import <DDFavourites/DDFavourites.h>

@implementation DDOutletsManager

static DDOutletsManager *_sharedObject;

+(DDOutletsManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDOutletsManager alloc]init];
    });
    return _sharedObject;
}

-(id)init{
    if (self=[super init]) {
        [self sendPendingFavouritesToServer];
    }
    return self;
}

-(void)checkAndShowRedemption:(DDMerchantOffersLocalDataM*)viewModel completion:(void (^)(DDMOfferRedemptionType responseType, NSString * _Nullable alertTitle, NSString * _Nullable alertMsg))completion{
    [DDRedemptionsManager.shared checkAndShowOfferDetails:viewModel completion:completion];
}

-(void)fetchListOfOutlets:(DDOutletsRequestM *)outletsReqModel showLoader: (BOOL)showLoader  andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    if ([outletsReqModel.lat isEqualToString:@"0"] || [outletsReqModel.lng isEqualToString:@"0"]){
        if ([[DDLocationsManager shared] isLocationServicesEnable]) {
            CLLocation *loc = [[DDLocationsManager shared] userCurrentLocation];
            if (loc){
                outletsReqModel.lat = @(loc.coordinate.latitude).stringValue;
                outletsReqModel.lng = @(loc.coordinate.longitude).stringValue;
            }
        }else {
            outletsReqModel.lat = nil;
            outletsReqModel.lng = nil;
        }
    }
    if (outletsReqModel.m_ids != nil){
        outletsReqModel.only_distinct_outlets = @(0);
    }
    [DDNetworkManager.shared post:DDApisType_Outlet_Listing showHUD:showLoader withParam:outletsReqModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDOutletApiM *outletsModel = (DDOutletApiM *)model;
        completion(outletsModel, response, error);
    }];
}

-(void)fetchMerchantDetail:(DDMerchantDetailRequestM *)reqModel showLoader: (BOOL)showLoader  andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    CLLocation *loc = [[DDLocationsManager shared] userCurrentLocation];
    if (!IS_CINEMA_SOCIETY_ENABLED){
        reqModel.is_cinema_society_enabled = nil;
    }
    if (!IS_LIVE_OFFER_ENABLED){
        reqModel.is_live_offers_enabled = nil;
    }
    if (loc){
        reqModel.lat = @(loc.coordinate.latitude);
        reqModel.lng = @(loc.coordinate.longitude);
    }
    [DDNetworkManager.shared post:DDApisType_Outlet_Detail showHUD:showLoader withParam:reqModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDMerchantDetailApiM *merchantModel = (DDMerchantDetailApiM *)model;
        completion(merchantModel, response, error);
    }];
    
}

-(void)fetchMerchantBaseOnlineOfferHistory:(DDBaseRequestModel *)reqModel showLoader: (BOOL)showLoader  andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    [DDNetworkManager.shared post:DDApisType_Outlet_Online_Offer_History showHUD:showLoader withParam:reqModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(model, response, error);
    }];
}

-(void)fetchProductsList:(DDBaseRequestModel *)reqModel showLoader: (BOOL)showLoader  andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    [DDProductManager  loadMerchantDetailSectionProducts:reqModel showLoader:showLoader withCompletion:completion];
}

- (void)sendPendingFavouritesToServer {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[DDFavouritesManager shared] sendPendingFavouritesToServer];
    });
}
@end
