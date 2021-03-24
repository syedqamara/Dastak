//
//  DDLocationsAPIManager.m
//  DDLocation
//
//  Created by Zubair Ahmad on 04/02/2020.
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

#import "DDLocationsAPIManager.h"


@implementation DDLocationsAPIManager

-(void)getAppLocations {
    self.method = DDApiMethodPOST;
    self.isEncrypted = NO;
}
-(void)getCashlessDeliveryLocations {
//    self.show_local_response = YES;
}
-(void)addCashlessDeliveryLocation {}
-(void)updateCashlessDeliveryLocation {}
-(void)deleteCashlessDeliveryLocation {}

+(void)registerApiConfiguration {
    [DDApisConfiguration registerConfigurations:DDApisType_Locations_Locations classObj:self responseClassObj:DDLocationsAPIM.class selector:@selector(getAppLocations) endPoint:K_APP_LOCATIONS_EP isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Cashless_Locations classObj:self responseClassObj:DDDeliveryLocationsAPI.class selector:@selector(getCashlessDeliveryLocations) endPoint:K_APP_CD_LOCATIONS_EP isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Cashless_Add_Location classObj:self responseClassObj:DDDeliveryLocationsAPI.class selector:@selector(addCashlessDeliveryLocation) endPoint:K_APP_CD_ADD_LOCATION_EP isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Cashless_Update_Location classObj:self responseClassObj:DDDeliveryLocationsAPI.class selector:@selector(updateCashlessDeliveryLocation) endPoint:K_APP_CD_UPDATE_LOCATION_EP isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Cashless_Delete_Location classObj:self responseClassObj:DDDeliveryLocationsAPI.class selector:@selector(deleteCashlessDeliveryLocation) endPoint:K_APP_CD_DELETE_LOCATION_EP isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
}
@end
