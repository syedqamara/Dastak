//
//  DDBaseAppConfiguration.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDHomeUIAppUIConfiguration.h"
#import "DDHomeUI.h"

@implementation DDHomeUIAppUIConfiguration

+(void)loadUIConfiguration {
    [DDHomeVC setRouteConfiguration];
    [DDMerchantDetailVC setRouteConfiguration];
    [DDAddCustomisationVC setRouteConfiguration];
    [DDOrderStatusVC setRouteConfiguration];
    [DDOrderHistoryVC setRouteConfiguration];
    [DDOutletListingVC setRouteConfiguration];
    [DDFavouritesOutletsVC setRouteConfiguration];
    [DDCashlessCartWebVC setRouteConfiguration];
    [DDRemoveCustomizationVC setRouteConfiguration];
    [DDMerchantInfoRatingVC setRouteConfiguration];
    [DDStarRatingVC setRouteConfiguration];
    [DDSendParcelVC setRouteConfiguration];
}

@end
