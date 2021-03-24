//
//  DDDeliveryLocationsData.h
//  Pods
//
//  Created by Awais Shahid on 24/02/2020.
//

#import "JSONModel.h"
#import "DDDeliveryAddressM.h"
#import "DDBaseApiModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDDeliveryLocationsData <NSObject> @end
@protocol DDDeliveryLocationsAPI <NSObject> @end

@interface DDDeliveryLocationsData : JSONModel
@property (nonatomic, strong) NSArray<DDDeliveryAddressM,Optional> *delivery_locations;
@property (nonatomic, strong) NSArray<DDLocationTagsM,Optional> *location_tags;
@end


@interface DDDeliveryLocationsAPI : DDBaseApiModel
@property (nonatomic, strong) DDDeliveryLocationsData<Optional> *data;
+(DDDeliveryLocationsAPI*)init;
@end

NS_ASSUME_NONNULL_END
