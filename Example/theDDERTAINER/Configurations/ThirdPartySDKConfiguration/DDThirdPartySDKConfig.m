//
//  DDThirdPartySDKConfig.m
//  theDDERTAINER_Example
//
//  Created by Zubair Ahmad on 20/01/2020.
//  Copyright © 2020 The Entertainer. All rights reserved.
//

#import "DDThirdPartySDKConfig.h"
#import <DDCommons.h>
//#import "NewRelicAgent/NewRelic.h"

@implementation DDThirdPartySDKConfig

+(void)loadConfigurations {
    [GMSServices provideAPIKey:DDCAppConfigManager.shared.api_config.GOOGLE_API_KEY];
    [GMSPlacesClient provideAPIKey:DDCAppConfigManager.shared.api_config.GOOGLE_API_KEY];
//    [NewRelic enableCrashReporting:YES];
//    [NewRelicAgent startWithApplicationToken:@"AA2062b53b5b2be384c4cba8035359251648f7d39c"];
}

@end
