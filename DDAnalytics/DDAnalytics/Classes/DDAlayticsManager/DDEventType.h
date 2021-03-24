//
//  DDEventType.h
//  DDAnalytics
//
//  Created by Syed Qamar Abbas on 19/05/2020.
//

#import "DDAnalyticsM.h"

#ifndef DDEventType_h
#define DDEventType_h

typedef void(^ _Nullable AnalyticsCompletionCallBack)(DDAnalyticsM * _Nullable analytics);
typedef void(^ _Nullable CustomAnalyticsCompletionCallBack)(DDAnalyticsCollectionM * _Nullable collection);



typedef NSString * DDEventType NS_STRING_ENUM;
static DDEventType const _Nullable DDEventTypeBranch = @"DDEventTypeBranch";
static DDEventType const _Nullable DDEventTypeCustom = @"DDEventTypeCustom";
static DDEventType const _Nullable DDEventTypeFB = @"DDEventTypeFB";
static DDEventType const _Nullable DDEventTypeBraze = @"DDEventTypeBraze";
static DDEventType const _Nullable DDEventTypeFirebase = @"DDEventTypeFirebase";

#endif /* DDEventType_h */
