//
//  DDEventTracker.h
//  DDAnalytics
//
//  Created by Syed Qamar Abbas on 19/05/2020.
//

#import <Foundation/Foundation.h>
#import "DDEventType.h"
#import "DDNetwork.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDEventTracker : NSObject

@property (strong, nonatomic) NSString *session;
@property (strong, nonatomic) NSString *company;
@property (nonatomic, strong) AnalyticsCompletionCallBack onThirdPartyEventTrigger;
@property (nonatomic, strong) CustomAnalyticsCompletionCallBack onCustomAnalyticsPosting;
@property (strong, nonatomic) Class custom_analytics_request_model_class;
@property (strong, nonatomic) DDApisType apiType;

-(instancetype)init __attribute__((unavailable));
-(instancetype)initWithCompanyKey:(NSString *)company;

-(void)replaceKey:(NSString *)forKey withNewKey:(NSString *)key forEventType:(DDEventType)eventType;
-(void)replaceEventName:(NSString *)eventName withNewEventName:(NSString *)newEventName forEventType:(DDEventType)eventType;
-(void)trackEvent:(NSString *)eventName withType:(DDEventType)type andParam:(NSDictionary *)param andEventDescription:(NSString *)description;
-(void)addCustomAnalyticsPostingListener:(NSNotificationName)observerName;
-(void)postAllCustomAnalytics;
-(void)removeAllPreviousAnalytics;
@end

NS_ASSUME_NONNULL_END
