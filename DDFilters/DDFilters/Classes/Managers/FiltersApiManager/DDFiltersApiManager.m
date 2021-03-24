//
//  DDFiltersApiManager.m
//  DDFilters
//
//  Created by Syed Qamar Abbas on 16/01/2020.
//

#import "DDFiltersApiManager.h"
#import "DDCommons.h"
#import "DDFiltersApiModel.h"
#import "DDUI.h"


@implementation DDFiltersApiManager

-(void)loadFilters {
    
}

-(void)loadDeliveryFilters {
    
}

-(void)outletCount {
    
}


+(void)registerApiConfiguration {
    [DDApisConfiguration registerConfigurations:DDApisType_Filter_Get_Filters classObj:self responseClassObj:DDFiltersApiModel.class selector:@selector(loadFilters) endPoint:K_FILTER_EP_FILTERS isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Filter_Get_Delivery_Filters classObj:self responseClassObj:DDFiltersApiModel.class selector:@selector(loadDeliveryFilters) endPoint:K_FILTER_EP_DELIVERY_FILTERS isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Filter_Get_Count classObj:self responseClassObj:DDFiltersApiModel.class selector:@selector(outletCount) endPoint:K_FILTER_EP_OUTLET_COUNT isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
}
@end
