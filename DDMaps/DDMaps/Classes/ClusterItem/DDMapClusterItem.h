//
//  DDMapClusterItem.h
//  DDMaps
//
//  Created by Zubair Ahmad on 04/02/2020.
//

#import <Foundation/Foundation.h>
#import <Google-Maps-iOS-Utils/GMUClusterItem.h>
#import <DDCommons/DDCommons.h>
#import "DDMapMarker.h"

NS_ASSUME_NONNULL_BEGIN


// Cluster items class Point of interest items

@interface DDMapClusterItem : NSObject <GMUClusterItem>

// marker position
@property(nonatomic, readonly) CLLocationCoordinate2D position;
// marker object
@property(nonatomic, readonly) DDMapMarker *marker;

- (instancetype)initWithPosition:(CLLocationCoordinate2D)position marker:(DDMapMarker *)marker;

@end

NS_ASSUME_NONNULL_END
