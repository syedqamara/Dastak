//
//  DDHomeApiManager.m
//  dynamicdelivery_Example
//
//  Created by Syed Qamar Abbas on 08/01/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import "DDHomeApiManager.h"
#import "DDUI.h"
#import "DDCommons.h"
#import "DDModels.h"
#import "DDOutletApiM.h"

#define K_HOME_HOME_INFO @"home"
#define K_HOME_MERCHANT_DETAIL @"merchant_detail"
#define K_HOME_ORDER_DETAIL @"order_detail"
#define K_HOME_ORDER_CANCEL @"order/cancel"
#define K_HOME_ORDER_HISTORY @"orders"
#define K_HOME_OUTLET_LISTING @"outlets"
#define K_HOME_FAV_OUTLET_LISTING @"favorites"
#define K_GOOGLE_DIRECTION @"json"
#define K_C2C_FAIRS @"c2c/fairs"



@implementation DDHomeApiManager
-(void)directionApi {
    self.base_url = @"https://maps.googleapis.com/maps/api/directions/";
}
-(void)homeApi {
    self.show_local_response = YES;
}
-(void)merchantDetail {}
-(void)orderDetail {}
-(void)orderHistory {}
-(void)outletListing {}
-(void)favOutletListing {}
-(void)submitRating {}
-(void)c2cFairs {}

+(void)registerApiConfiguration {
    
    [DDApisConfiguration registerConfigurations:DDApisType_C2C_FAIRS classObj:self responseClassObj:DDC2CFairsApiM.class selector:@selector(c2cFairs) endPoint:K_C2C_FAIRS isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:(DDApiAuthorizationTypeBearerToken)];
    [DDApisConfiguration registerConfigurations:DDApisType_Google_Direction classObj:self responseClassObj:DDBaseApiModel.class selector:@selector(directionApi) endPoint:K_GOOGLE_DIRECTION isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:(DDApiAuthorizationTypeBasicAuth)];
    [DDApisConfiguration registerConfigurations:DDApisType_Home_Home classObj:self responseClassObj:DDHomeApiM.class selector:@selector(homeApi) endPoint:K_HOME_HOME_INFO isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Cashless_Merchant_Detail classObj:self responseClassObj:DDMerchantApiM.class selector:@selector(merchantDetail) endPoint:K_HOME_MERCHANT_DETAIL isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Cashless_Order_Detail classObj:self responseClassObj:DDOrderStatusApiM.class selector:@selector(orderDetail) endPoint:K_HOME_ORDER_DETAIL isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Cashless_Order_History classObj:self responseClassObj:DDOrderHistoryApiM.class selector:@selector(orderHistory) endPoint:K_HOME_ORDER_HISTORY isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Outlet_Listing classObj:self responseClassObj:DDOutletApiM.class selector:@selector(outletListing) endPoint:K_HOME_OUTLET_LISTING isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Favourites_Favourites classObj:self responseClassObj:DDOutletApiM.class selector:@selector(favOutletListing) endPoint:K_HOME_FAV_OUTLET_LISTING isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Favourites_Mark_Favourites classObj:self responseClassObj:DDBaseApiModel.class selector:@selector(favOutletListing) endPoint:K_HOME_FAV_OUTLET_LISTING isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Cashless_Current_Cancel_Order classObj:self responseClassObj:DDBaseApiModel.class selector:@selector(favOutletListing) endPoint:K_HOME_ORDER_CANCEL isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Submit_Rating classObj:self responseClassObj:DDBaseApiModel.class selector:@selector(submitRating) endPoint:@"order/rating" isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:(DDApiAuthorizationTypeBearerToken)];
}
@end
