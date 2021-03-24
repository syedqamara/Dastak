//
//  DDDeliveryLocationsData.m
//  Pods
//
//  Created by Awais Shahid on 24/02/2020.
//

#import "DDDeliveryLocationsData.h"

@implementation DDDeliveryLocationsData
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"deliveryAddress": @"selectedLocations",@"locationTags": @"locationTags"}];
}
@end

@implementation DDDeliveryLocationsAPI

+(DDDeliveryLocationsAPI*)init {
    DDDeliveryLocationsAPI *temp = [DDDeliveryLocationsAPI new];
    temp.data = [DDDeliveryLocationsData new];
    temp.status = @(1);
    return temp;
}

@end
