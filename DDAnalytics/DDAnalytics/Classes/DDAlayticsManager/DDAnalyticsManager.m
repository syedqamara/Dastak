//
//  DDAnalyticsManager.m
//  DDAnalytics
//
//  Created by Syed Qamar Abbas on 19/05/2020.
//

#import "DDAnalyticsManager.h"
#import "DDModels.h"
#import "DDNetwork.h"

@interface DDAnalyticsManager ()

@end

@implementation DDAnalyticsManager
static DDAnalyticsManager *_sharedObject;
+(DDAnalyticsManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [DDAnalyticsManager.alloc init];
    });
    return _sharedObject;
}
-(instancetype)init {
    self = [super init];
    self.eventTrackers = [NSMutableArray new];
    return self;
}
-(DDEventTracker *)addEventWithCompany:(NSString *)company {
    DDEventTracker *event = [DDEventTracker.alloc initWithCompanyKey:company];
    [self.eventTrackers addObject:event];
    return event;
}
-(DDEventTracker *)eventForCompany:(NSString *)company {
    for (DDEventTracker *event in self.eventTrackers) {
        if ([event.company isEqualToString:company]) {
            return event;
        }
    }
    return nil;
}
-(void)postAnalytics:(DDBaseRequestModel *)requestModel withEventTracker:(DDEventTracker *)eventTracker {
    [DDNetworkManager.shared post:eventTracker.apiType showHUD:NO withParam:requestModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [eventTracker removeAllPreviousAnalytics];
    }];
}
@end
