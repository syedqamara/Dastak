//
//  DDMapClusterItem.m
//  DDMaps
//
//  Created by Zubair Ahmad on 04/02/2020.
//

#import "DDMapClusterItem.h"

@implementation DDMapClusterItem

- (instancetype)initWithPosition:(CLLocationCoordinate2D)position marker:(nonnull DDMapMarker *)marker{
    if ((self = [super init])) {
        _position = position;
        _marker = marker;
    }
    return self;
}
@end
