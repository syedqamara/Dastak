//
//  DDEventTracker.m
//  DDAnalytics
//
//  Created by Syed Qamar Abbas on 19/05/2020.
//
#import "DDModels.h"
#import "DDEventTracker.h"
#import "DDAnalyticsCDM.h"
#import "DDStorage.h"
#import <MagicalRecord/MagicalRecord.h>

@interface DDEventTracker()


@property (strong, nonatomic) NSMutableDictionary *key_rules;
@property (strong, nonatomic) NSMutableDictionary *event_name_rules;
@end

@implementation DDEventTracker
-(instancetype)initWithCompanyKey:(NSString *)company {
    if (company.length == 0) {
        NSAssert(false, @"Cannot Add Analytics Manager without Company Key");
    }
    self = [super init];
    self.key_rules = [NSMutableDictionary new];
    self.event_name_rules = [NSMutableDictionary new];
    self.session = NSUUID.UUID.UUIDString;
    self.company = company;
    return self;
}
-(void)replaceKey:(NSString *)forKey withNewKey:(NSString *)key forEventType:(DDEventType)eventType {
    NSMutableDictionary *eventTypeKeys;
    if ([self.key_rules.allKeys containsObject:eventType]) {
        NSDictionary *dict = self.key_rules[eventType];
        eventTypeKeys = dict.mutableCopy;
    }else {
        eventTypeKeys = [NSMutableDictionary new];
    }
    
    [eventTypeKeys setValue:key forKey:forKey];
    [self.key_rules setValue:eventTypeKeys forKey:eventType];
}
-(void)replaceEventName:(NSString *)eventName withNewEventName:(NSString *)newEventName forEventType:(DDEventType)eventType {
    NSMutableDictionary *eventTypeKeys;
    if ([self.event_name_rules.allKeys containsObject:eventType]) {
        NSDictionary *dict = self.event_name_rules[eventType];
        eventTypeKeys = dict.mutableCopy;
    }else {
        eventTypeKeys = [NSMutableDictionary new];
    }
    
    [eventTypeKeys setValue:newEventName forKey:eventName];
    [self.event_name_rules setValue:eventTypeKeys forKey:eventType];
}
-(void)trackEvent:(NSString *)eventName withType:(DDEventType)type andParam:(NSDictionary *)param andEventDescription:(NSString *)eventDescription {
    if ([type isEqualToString:DDEventTypeCustom]) {
//        NSMutableDictionary *analyticsParams = param.mutableCopy;
//        [self addCommonAnalyticsParams:analyticsParams];
//        DDAnalyticsCDM *analytics = [DDAnalyticsCDM MR_createEntity];
//        analytics.session_id = self.session;
//        analytics.company_key = self.company;
//        analytics.event_name = eventName;
//        analytics.event_description = eventDescription;
//        analytics.identifier = NSUUID.UUID.UUIDString;
//        analytics.event_content = analyticsParams;
//        [DDDatabaseManager.shared saveData];
    }else {
        DDAnalyticsM *analytics = [DDAnalyticsM new];
        analytics.company_key = self.company;
        analytics.event_type = type;
        analytics.event_name = eventName;
        analytics.event_description = eventDescription;
        analytics.event_content = param;
        analytics.event_key_mapper_rules = [self keyRulesForEventType:type];
        analytics.event_name_mapper_rules = [self eventNameRulesForEventType:type];
        if (self.onThirdPartyEventTrigger != nil) {
            self.onThirdPartyEventTrigger(analytics);
        }
    }
}
-(NSDictionary *)keyRulesForEventType:(DDEventType)type {
    NSMutableDictionary *eventTypeKeys;
    if ([self.key_rules.allKeys containsObject:type]) {
        NSDictionary *dict = self.key_rules[type];
        eventTypeKeys = dict.mutableCopy;
    }else {
        eventTypeKeys = [NSMutableDictionary new];
    }
    return eventTypeKeys;
}
-(NSDictionary *)eventNameRulesForEventType:(DDEventType)type {
    NSMutableDictionary *eventTypeKeys;
    if ([self.event_name_rules.allKeys containsObject:type]) {
        NSDictionary *dict = self.event_name_rules[type];
        eventTypeKeys = dict.mutableCopy;
    }else {
        eventTypeKeys = [NSMutableDictionary new];
    }
    return eventTypeKeys;
}
-(void)addCustomAnalyticsPostingListener:(NSNotificationName)observerName {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(postAllCustomAnalytics) name:observerName object:nil];
}
-(void)postAllCustomAnalytics {
    self.session = NSUUID.UUID.UUIDString;
    [self postAnalytics];
}
-(void)postAnalytics {
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"company_key = %@ && session_id != %@",self.company, self.session];
//    NSArray *allAnalytics = [DDAnalyticsCDM MR_findAllWithPredicate:predicate];
//    DDAnalyticsCollectionM *analyticCollection = [DDAnalyticsCollectionM.alloc init];
//    for (DDAnalyticsCDM *analytics in allAnalytics) {
//        DDAnalyticsM *analyticObj = [DDAnalyticsM new];
//        analyticObj.company_key = analytics.company_key;
//        analyticObj.event_name = analytics.event_name;
//        analyticObj.event_description = analytics.event_description;
//        analyticObj.event_content = analytics.event_content;
//        analyticObj.event_key_mapper_rules = [self keyRulesForEventType:(DDEventTypeCustom)];
//        analyticObj.event_name_mapper_rules = [self eventNameRulesForEventType:(DDEventTypeCustom)];
//        [analyticCollection.events addObject:analyticObj];
//        
//    }
//    if (self.onCustomAnalyticsPosting != nil) {
//        self.onCustomAnalyticsPosting(analyticCollection);
//    }
}
-(void)addCommonAnalyticsParams:(NSMutableDictionary *)dict {
    [dict setValue:DDCCommonParamManager.shared.default_api_parameters.__lat forKey:@"lat"];
    [dict setValue:DDCCommonParamManager.shared.default_api_parameters.__lng forKey:@"lon"];
    [dict setValue:DDCCommonParamManager.shared.default_api_parameters.location_id forKey:@"location_id"];
    [dict setValue:DDCCommonParamManager.shared.default_api_parameters.location_id forKey:@"location_id"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *date = [dateFormatter stringFromDate:[NSDate date]];
    [dict setValue:date forKey:@"current_date"];
}
-(void)removeAllPreviousAnalytics {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"company_key = %@ && session_id != %@",self.company, self.session];
    [DDAnalyticsCDM MR_deleteAllMatchingPredicate:predicate];
}
@end
