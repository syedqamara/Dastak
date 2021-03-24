//
//  DDBaseAppConfiguration.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDLocationsUIAppUIConfiguration.h"
#import "DDLocationsUI.h"
@implementation DDLocationsUIAppUIConfiguration


+(void)loadUIConfiguration {
    NSString *moduleName = @"DDLocations";
    [DDLocationPermissionVC setRouteConfiguration];
    [DDCashlessDeliveryLocationsVC setRouteConfiguration];
    [DDCashlessAddNewLocationVC setRouteConfiguration];
    [DDCashlessLocationDetailsVC setRouteConfiguration];
    [DDCashlessSearchLocationsVC setRouteConfiguration];
    [DDAppLocationsVC setRouteConfiguration];
}

@end
