//
//  DDAnalyticsConfiguration.m
//  dynamicdelivery_Example
//
//  Created by Syed Qamar Abbas on 19/05/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import "DDAnalyticsConfiguration.h"
#import <DDAnalytics.h>
#import <Appboy.h>

@implementation DDAnalyticsConfiguration
+(void)configure {
    
    [DDAnalyticsManager.shared addEventWithCompany:DDCCommonParamManager.shared.default_api_parameters.company];
    APP_ANALYTICS.apiType = DDApisType_Analytics_Post_App_Analytics;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [APP_ANALYTICS addCustomAnalyticsPostingListener:UIApplicationDidBecomeActiveNotification];
    });
    
    
    APP_ANALYTICS.onCustomAnalyticsPosting = ^(DDAnalyticsCollectionM * _Nullable collection) {
        NSString *header = [DDCCommonParamManager.shared.default_api_parameters.toDictionary bv_jsonStringWithPrettyPrint:YES];
        NSMutableDictionary *dict = collection.toDictionary.mutableCopy;
        [dict setValue:header forKey:@"header"];
        DDBaseRequestModel *requestModel = [dict decodeTo:DDBaseRequestModel.class];
        [DDAnalyticsManager.shared postAnalytics:requestModel withEventTracker:APP_ANALYTICS];
    };
    
    //Observing Third Event Logs
    APP_ANALYTICS.onThirdPartyEventTrigger = ^(DDAnalyticsM * _Nullable analytics) {
        if ([analytics.event_type isEqualToString:DDEventTypeBraze]) {
            [self sendBrazeEvents:analytics];
        }
        
    };
}
+(void)sendBrazeEvents:(DDAnalyticsM *)analytics {
    [Appboy.sharedInstance logCustomEvent:analytics.eventName withProperties:analytics.toDictionary];
}
@end
