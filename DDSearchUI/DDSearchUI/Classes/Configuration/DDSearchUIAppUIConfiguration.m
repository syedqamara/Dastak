//
//  DDBaseAppConfiguration.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDSearchUIAppUIConfiguration.h"
#import "DDSearchUI.h"
@implementation DDSearchUIAppUIConfiguration
//DDUIRouterConfigurationM configureWithRouteName
+(void)loadUIConfiguration {
    [DDSearchViewController setRouteConfiguration];
    [DDFiltersViewController setRouteConfiguration];
}

@end
