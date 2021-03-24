//
//  DDAnalyticsM.m
//  DDAnalytics
//
//  Created by Syed Qamar Abbas on 19/05/2020.
//

#import "DDAnalyticsCDM.h"

@implementation DDAnalyticsCDM

@dynamic identifier;
@dynamic company_key;
@dynamic session_id;
@dynamic event_name;
//@dynamic event_type;
@dynamic event_description;
@dynamic event_content;
-(DDAnalyticsM *)model {
    DDAnalyticsM *obj = [DDAnalyticsM new];
    obj.company_key = self.company_key;
    obj.event_name = self.event_name;
    obj.event_description = self.event_description;
    obj.event_content = self.event_content;
    return obj;
}
@end
