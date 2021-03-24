//
//  DDAnalyticsM.h
//  DDAnalytics
//
//  Created by Syed Qamar Abbas on 19/05/2020.
//

#import "JSONModel.h"
#import "DDModels.h"

NS_ASSUME_NONNULL_BEGIN


@protocol DDAnalyticsM <NSObject> @end

@interface DDAnalyticsM : JSONModel

@property (strong, nonatomic) NSString <Ignore>*company_key;
@property (strong, nonatomic) NSString <Ignore>*event_name;
@property (strong, nonatomic) NSString <Ignore>*event_type;
@property (strong, nonatomic) NSString <Ignore>*event_description;
@property (strong, nonatomic) NSDictionary <Ignore>*event_content;
@property (strong, nonatomic) NSDictionary <Ignore>*event_key_mapper_rules;
@property (strong, nonatomic) NSDictionary <Ignore>*event_name_mapper_rules;
-(NSString *)eventName;
@end

@interface DDAnalyticsCollectionM: JSONModel
@property (strong, nonatomic) NSMutableArray <DDAnalyticsM,Ignore> *events;
@property (strong, nonatomic) NSMutableArray <NSString,Optional> *body;
@end

NS_ASSUME_NONNULL_END
