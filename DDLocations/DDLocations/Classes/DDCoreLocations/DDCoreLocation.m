//
//  DDCoreLocation.m
//  DDLocations
//
//  Created by Zubair Ahmad on 20/01/2020.
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

#import "DDCoreLocation.h"
#import "DDLocationsManager.h"


@interface DDCoreLocation ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocation *currentLocation;
@end

@implementation DDCoreLocation

static DDCoreLocation *_sharedLocationManagerInstance;

+ (DDCoreLocation *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLocationManagerInstance = [[DDCoreLocation alloc] init];
    });
    return _sharedLocationManagerInstance;
}

- (id) init {
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    return self;
}

- (void)startUpdatingLocation {
    [self.locationManager startUpdatingLocation];
}

- (void)stopUpdatingLocation {
    [self.locationManager stopUpdatingLocation];
}

-(BOOL) isLocationServicesEnable {
    return [self didPhoneAllowedUseLocationServices];
}

-(BOOL) isLocationServicesDenied {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    return status == kCLAuthorizationStatusDenied;
}

- (BOOL)didPhoneAllowedUseLocationServices {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    return status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse;
}

- (CLLocation *)currentLocation {
    if(!self->_currentLocation) {
        [self startUpdatingLocation];
    }
    if (self->_currentLocation && CLLocationCoordinate2DIsValid(self->_currentLocation.coordinate)) {
//        [self setLocationValues];
    } else {
        [DDSharedPreferences.shared setObjectDF:@"0.00" forKey:@"latitude"];
        [DDSharedPreferences.shared setObjectDF:@"0.00" forKey:@"longitude"];
    }
    return self->_currentLocation;
}

//-(void) setLocationValues{
//    [DDDEFAULTSsetValue:[NSString stringWithFormat:@"%f", self->_currentLocation.coordinate.latitude] forKey:@"latitude"];
//    [DDDEFAULTSsetValue:[NSString stringWithFormat:@"%f", self->_currentLocation.coordinate.longitude] forKey:@"longitude"];
//}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    if (location) {
        self.currentLocation = location;
//        [DDLocationsManager shared].userCurrentLocation = location;
        [self userLocationDidFetched];
        DDCCommonParamManager.shared.default_api_parameters.__lat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
        DDCCommonParamManager.shared.default_api_parameters.__lng = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    }
//    [self setLocationValues];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusNotDetermined) {
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(locationPermissionDidChanged)]) {
            [self.delegate locationPermissionDidChanged];
        }
    }else{
        [self startUpdatingLocation];
    }
}

- (void) userLocationDidFetched {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(locationDidFetched)]) {
        [self.delegate locationDidFetched];
    }
}

- (void)  requestUserLocation {
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
        [self startUpdatingLocation];
    }
}
@end
