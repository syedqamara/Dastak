//
//  DDOutletsApiManager.m
//  DDOutlets
//
//  Created by Zubair Ahmad on 21/01/2020..
//  Copyright © 2020 The Entertainer. All rights reserved.
//

#import "DDOutletsApiManager.h"

@implementation DDOutletsApiManager

-(void)getOutlets {
}
-(void)getMerchantDetail {
}

-(void)getOnlineOfferHistory {
}


+(void)registerApiConfiguration {
    [DDApisConfiguration registerConfigurations:DDApisType_Outlet_Listing classObj:self responseClassObj:DDOutletApiM.class selector:@selector(getOutlets) endPoint:K_OUTLETS_EP_LISTING isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    [DDApisConfiguration registerConfigurations:DDApisType_Outlet_Detail classObj:self responseClassObj:DDMerchantDetailApiM.class selector:@selector(getMerchantDetail) endPoint:K_OUTLETS_EP_MERCHANT_DETAIL isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    [DDApisConfiguration registerConfigurations:DDApisType_Outlet_Online_Offer_History classObj:self responseClassObj:DDBaseHistoryAPIModel.class selector:@selector(getOnlineOfferHistory) endPoint:K_OUTLETS_EP_ONLINE_OFFERS_HISTORY isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
}
@end
