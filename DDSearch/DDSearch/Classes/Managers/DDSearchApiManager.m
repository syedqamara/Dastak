//
//  DDSearchApiManager.m
//  DDSearch
//
//  Created by Syed Qamar Abbas on 14/01/2020.
//

#import "DDSearchApiManager.h"
#import "DDModels.h"
#define K_EP_SEARCH_RESULT @"search"
#define K_EP_GET_FILTERS @"filters"


@implementation DDSearchApiManager

-(void)searchResults {
}
-(void)fetchFilters {
    
}
+(void)registerApiConfiguration {
    
    [DDApisConfiguration registerConfigurations:DDApisType_Outlet_Search classObj:self responseClassObj:DDSearchApiM.class selector:@selector(searchResults) endPoint:K_EP_SEARCH_RESULT isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBearerToken];
    [DDApisConfiguration registerConfigurations:DDApisType_Filter_Get_Filters classObj:self responseClassObj:DDFiltersApiM.class selector:@selector(fetchFilters) endPoint:K_EP_GET_FILTERS isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:(DDApiAuthorizationTypeBearerToken)];
}

@end
