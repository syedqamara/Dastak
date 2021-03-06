//
//  DDApiRouteConfig.m
//  dynamicdelivery_Example
//
//  Created by Syed Qamar Abbas on 31/12/2019.
//  Copyright © 2019 etDev24. All rights reserved.
//

#import "DDApiRouteConfig.h"
#import <DDCommons.h>
#import <DDAuth/DDAuthApiManager.h>
#import <DDStorage/DDStorage.h>
#import "DDEditConfig.h"
#import <DDAnalytics.h>
#import <DDLocations.h>
#import <DDHome.h>
#import <DDSearch.h>
@implementation DDApiRouteConfig
+(void)loadApiConfiguration {
    //Outlet Module Api Configuration
    
    [DDAuthApiManager registerApiConfiguration];
    [DDLocationsAPIManager registerApiConfiguration];
    [DDAnalyticsApiManager registerApiConfiguration];
    [DDLocationsAPIManager registerApiConfiguration];
    [DDHomeApiManager registerApiConfiguration];
    [DDSearchApiManager registerApiConfiguration];
    //Use bellow approach to override any configuration setting for specific api
//    [DDNetworkManager.shared configurationForType:DDApisType_Auth_Login].end_point = @"";
    
    [self loadDatabase];
    [self loadAppConfigurationsFromAPI];
    [self saveAllApisToBreakPoint];
    [self observerForBreakPoint];
}
+(DDEditConfigBreakPointM *)allApisForBreakPoint {
    DDEditConfigBreakPointM *breaks = [DDEditConfigBreakPointM new];
    breaks.break_points = [NSMutableArray<DDBreakPointM, Optional> new];
    for (NSString *apiKey in DDNetworkManager.shared.api_dictionary.allKeys) {
        DDApisConfiguration *config = DDNetworkManager.shared.api_dictionary[apiKey];
        DDBreakPointM *br = [DDBreakPointM new];
        br.title = config.identifier;
        br.api_identifier = config.identifier;
        br.sub_title = config.end_point;
        [breaks.break_points addObject:br];
    }
    return breaks;
}
+(void)saveAllApisToBreakPoint {
    if (DDEditConfigBreakPointM.apiBreakPoints == nil) {
        DDEditConfigBreakPointM.apiBreakPoints = [self allApisForBreakPoint];
    }
}
+(void)observerForBreakPoint {
    DDNetworkManager.shared.editApiBreakPoint = ^(NSData * _Nullable param, BOOL isRequest) {
        NSString *titleStr = @"Edit Response";
        if (isRequest) {
            titleStr = @"Edit Request";
        }
        [DDEditConfigManager openJSONEditor:param withTitle:titleStr onController:UIApplication.topMostController andCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
            NSData *editedData = data;
            NSDictionary *returningObject = [editedData decodeTo:NSDictionary.class];
            if (isRequest) {
                [NSNotificationCenter.defaultCenter postNotificationName:DD_EDIT_BREAK_POINT_REQUEST_COMPLETION object:nil userInfo:returningObject];
            }else {
                [NSNotificationCenter.defaultCenter postNotificationName:DD_EDIT_BREAK_POINT_RESPONSE_COMPLETION object:nil userInfo:returningObject];
            }
        }];
    };
}
+(void)loadDatabase {
    [DDDatabaseManager.shared loadDatabase];
}

+(void)loadAppConfigurationsFromAPI {
    
}

@end
