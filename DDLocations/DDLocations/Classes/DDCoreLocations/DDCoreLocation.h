//
//  DDCoreLocation.h
//  DDLocations
//
//  Created by Zubair Ahmad on 20/01/2020.
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

@import CoreLocation;

@protocol DDCoreLocationDelegate <NSObject>
@optional
- (void)locationDidFetched;
- (void)locationPermissionDidChanged;
@end


@interface DDCoreLocation : NSObject

+ (DDCoreLocation *) shared;

@property(nonatomic, weak) id<DDCoreLocationDelegate> delegate;
@property (nonatomic, strong, readonly) CLLocation *currentLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;

- (void) requestUserLocation;
- (BOOL) isLocationServicesEnable;
- (BOOL) isLocationServicesDenied;


@end
