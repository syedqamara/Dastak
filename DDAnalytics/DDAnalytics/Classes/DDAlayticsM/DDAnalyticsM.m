//
//  DDAnalyticsM.m
//  DDAnalytics
//
//  Created by Syed Qamar Abbas on 19/05/2020.
//

#import "DDAnalyticsM.h"
#import "DDCommons.h"
@implementation DDAnalyticsM
-(NSDictionary *)toDictionary {
    NSMutableDictionary *dict = self.event_content.mutableCopy;
    dict = [dict mapDictionaryWithKeyChangeRules:self.event_key_mapper_rules];
    return dict;
}
-(NSString *)eventName {
    if ([self.event_name_mapper_rules.allKeys containsObject:self.event_name]) {
        return self.event_name_mapper_rules[self.event_name];
    }
    return self.event_name;
}
@end


@implementation DDAnalyticsCollectionM
-(instancetype)init {
    self = [super init];
    self.events = [NSMutableArray new];
    return self;
}
-(NSDictionary *)toDictionary {
    NSMutableArray *arr = [NSMutableArray new];
    for (DDAnalyticsM *analytics in self.events) {
        [arr addObject:[[analytics toDictionary] bv_jsonStringWithPrettyPrint:YES]];
    }
    self.body = arr;
    return [super toDictionary];
}
@end
