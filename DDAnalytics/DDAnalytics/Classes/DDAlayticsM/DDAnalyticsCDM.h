//
//  DDAnalyticsM.h
//  DDAnalytics
//
//  Created by Syed Qamar Abbas on 19/05/2020.
//

#import <CoreData/CoreData.h>
#import "DDAnalyticsM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDAnalyticsCDM : NSManagedObject
@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *company_key;
@property (strong, nonatomic) NSString *session_id;
@property (strong, nonatomic) NSString *event_name;
@property (strong, nonatomic) NSString *event_description;
@property (strong, nonatomic) NSDictionary *event_content;

-(DDAnalyticsM *)model;

@end

NS_ASSUME_NONNULL_END
