//
//  DDBaseAppConfiguration.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDFiltersUIAppUIConfiguration.h"
#import "DDFiltersUI.h"
@implementation DDFiltersUIAppUIConfiguration
+(void)loadUIConfiguration {
    NSString *moduleName = @"DDFiltersUI";
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Filter_Listing andModuleName:moduleName withClassRef:DDFiltersListingVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Filter_Options andModuleName:moduleName withClassRef:DDFiltersOptionsVC.class];
}

@end
