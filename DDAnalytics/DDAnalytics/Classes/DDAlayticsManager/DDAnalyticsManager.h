//
//  DDAnalyticsManager.h
//  DDAnalytics
//
//  Created by Syed Qamar Abbas on 19/05/2020.
//

#import <Foundation/Foundation.h>
#import "DDEventTracker.h"
#import "DDCommons.h"
NS_ASSUME_NONNULL_BEGIN

#define APP_ANALYTICS [DDAnalyticsManager.shared eventForCompany:DDCCommonParamManager.shared.default_api_parameters.company]

@interface DDAnalyticsManager : NSObject
+(DDAnalyticsManager *)shared;
@property (strong, nonatomic) NSMutableArray <DDEventTracker *> *eventTrackers;
-(DDEventTracker *)addEventWithCompany:(NSString *)company;
-(DDEventTracker *)eventForCompany:(NSString *)company;
-(void)postAnalytics:(DDBaseRequestModel *)requestModel withEventTracker:(DDEventTracker *)eventTracker;
@end

NS_ASSUME_NONNULL_END
