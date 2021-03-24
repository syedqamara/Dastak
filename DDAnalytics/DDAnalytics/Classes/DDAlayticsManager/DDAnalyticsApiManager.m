//
//  DDAnalyticsApiManager.m
//  DDAnalytics
//
//  Created by Syed Qamar Abbas on 19/05/2020.
//

#import "DDAnalyticsApiManager.h"

@implementation DDAnalyticsApiManager
-(void)postAppAnalytics {
    
}
+(void)registerApiConfiguration {
    [DDApisConfiguration registerConfigurations:DDApisType_Analytics_Post_App_Analytics classObj:self responseClassObj:DDBaseApiModel.class selector:@selector(postAppAnalytics) endPoint:@"analytics" isEncryptedEnabled:NO isSSLPinningEnabled:YES authorizationType:(DDApiAuthorizationTypeBearerToken)];
}
@end
