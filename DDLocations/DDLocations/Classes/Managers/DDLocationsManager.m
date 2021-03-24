//
//  DDLocationsManager.m
//  DDLocation
//
//  Created by Zubair Ahmad on 04/02/2020.
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

#import "DDLocationsManager.h"
#import "DDCoreLocation.h"
#import "DDLocationsConstants.h"
#import "DDGoogleApiManager.h"
#import <MapKit/MapKit.h>
#import <DDUI/DDUI.h>

@implementation DDLocationsManager

static DDLocationsManager *_sharedObject;

+(DDLocationsManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDLocationsManager alloc]init];
    });
    return _sharedObject;
}
-(instancetype)init{
    self = [super init];
    [self getAppLocation];
    return self;
}
-(void)setSelectedCashlessDeliveryLocation:(DDDeliveryAddressM *)selectedCashlessDeliveryLocation {
    _selectedCashlessDeliveryLocation = selectedCashlessDeliveryLocation;
}
-(void) setAppLocation:(DDLocationsM *)appLocation {
    _appLocation = appLocation;
    if (self.onAppLocationChange != nil){
        self.onAppLocationChange();
    }
}

-(void)setupAppLocations {
    NSString *previousVersion = [DDSharedPreferences.shared objectforKeyDF:LOCATION_VERSION_KEY];
    if (previousVersion.length) {
        [self fetchdynamicdeliveryAppLocations:previousVersion];
    }
}

-(void)setupAppLocationsForVersion:(NSString *)version {
    NSString *newVersion = [NSString stringWithFormat:@"%@_%@",version,NSString.deviceLanguage];
    NSString *previousVersion = [DDSharedPreferences.shared objectforKeyDF:LOCATION_VERSION_KEY];
    if([newVersion isEqualToString:previousVersion]) {
        [[DDLocationsManager shared] fetchdynamicdeliveryAppLocations:previousVersion];
    }else{
        [[DDLocationsManager shared] fetchdynamicdeliveryAppLocationsFromAPI:newVersion];
    }
}

-(void)fetchdynamicdeliveryAppLocationsFromAPI:(NSString *)newVersion {
    [DDNetworkManager.shared post:DDApisType_Locations_Locations showHUD:NO withParam:DDBaseRequestModel.new andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDLocationsAPIM* locations = (DDLocationsAPIM*) model;
        if (locations != nil && locations.data != nil && locations.data.locations != nil && locations.data.locations.count > 0){
            self.appSupportedLocations = locations.data.locations.mutableCopy;
            [self savedynamicdeliveryAppLocations:newVersion locations:locations.data.toDictionary.mutableCopy];
        }
    }];
}
-(void)fetchdynamicdeliveryAppLocations:(NSString *)existingVersion {
    NSMutableDictionary* locations = [[DDSharedPreferences.shared objectforKeyDF:DD_LOCATION_STORED_INFO] mutableCopy];
    if (locations != nil) {
        DDLocationsData* data = [[DDLocationsData alloc] initWithDictionary:locations error:nil];
        self.appSupportedLocations = data.locations.mutableCopy;
    }else{
        [DDSharedPreferences.shared setObjectDF:nil forKey:DD_LOCATION_STORED_INFO];
        [self fetchdynamicdeliveryAppLocationsFromAPI:existingVersion];
    }
}

- (void)savedynamicdeliveryAppLocations : (NSString*)version locations: (NSMutableDictionary*)locations{
    [DDSharedPreferences.shared setObjectDF:locations forKey:DD_LOCATION_STORED_INFO];
    [DDSharedPreferences.shared setObjectDF:version forKey:LOCATION_VERSION_KEY];
}

-(void)setIsLocationPermissionScreenOpened:(BOOL)isLocationPermissionScreenOpened {
    [DDSharedPreferences.shared setBoolDF:isLocationPermissionScreenOpened forKey:K_LOCATION_PERMISSION_ASKED_ONCE];
}

-(BOOL)isLocationPermissionScreenOpened {
    return [DDSharedPreferences.shared boolforKeyDF:K_LOCATION_PERMISSION_ASKED_ONCE];
}

- (BOOL) shouldAskPermission {
    if ([[DDCoreLocation shared] isLocationServicesEnable] || [[DDCoreLocation shared] isLocationServicesDenied])
        return NO;
    else {
        return !self.isLocationPermissionScreenOpened;
    }
}

- (CLLocation*) userCurrentLocation {
    if (self.isLocationServicesEnable) {
        return [DDCoreLocation shared].currentLocation;
    }
    else {
        return [self userLocationWhenNoLocationServiceEnabled];
    }
}

- (BOOL) isLocationServicesEnable {
    return  [[DDCoreLocation shared] isLocationServicesEnable];
}

- (void) setLocationsCommonParamValue {
    DDCCommonParamManager.shared.default_api_parameters.location_id = self.appLocation.location_id.stringValue;
    DDCCommonParamManager.shared.default_web_parameters.location_id = self.appLocation.location_id.stringValue;
}

- (void) saveAppLocationInDefaults {
    [DDSharedPreferences.shared setObjectDF:self.appLocation.toJSONString forKey:DD_LOCATION_SELECTED_OBJECT];
    [self setLocationsCommonParamValue];
}

-(DDLocationsM*)getAppLocation {
    if (self.appLocation != nil){
        return self.appLocation;
    }
    DDLocationsM *location;
    NSString *jsonString = [DDSharedPreferences.shared objectforKeyDF:DD_LOCATION_SELECTED_OBJECT];
    if (jsonString){
        location = [[DDLocationsM alloc] initWithString:jsonString error:nil];
    }
    if (!location) {
        location = [DDLocationsM defaultLocation];
    }
    self.appLocation = location;
    [self saveAppLocationInDefaults];
    return self.appLocation;
}

-(CLLocation*)userLocationWhenNoLocationServiceEnabled {
    DDLocationsM *loc = [self getAppLocation];
    CLLocation *location =  [[CLLocation alloc] initWithLatitude:loc.lat.doubleValue longitude:loc.lng.doubleValue];
    return location;
}

- (CLLocation*) getLocationObjectFromLatitude : (NSNumber*)lat longitude:(NSNumber*)lng {
    CLLocation *location =  [[CLLocation alloc] initWithLatitude:lat.doubleValue longitude:lng.doubleValue];
    return location;
}

- (CLLocationDistance)distanceFromLatidute:(NSNumber*)latidute lng:(NSNumber*)longitude {
    // in meters
    if (latidute == nil || longitude == nil){
        return 0;
    }
    
    if (![self isLocationServicesEnable])
        return 0;
    
    CLLocation *currentLocation = self.userCurrentLocation;
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latidute doubleValue] longitude: [longitude doubleValue]];
    return [currentLocation distanceFromLocation:loc];
}
-(NSString*)distanceFromLatidute:(NSNumber*)latidute longitude:(NSNumber*)longitude{
    if (latidute == nil || longitude == nil){
        return @"";
    }
    
    if (![self isLocationServicesEnable])
        return @"";
    
    CLLocationDistance distance = [self distanceFromLatidute:latidute lng:longitude];
    NSString *unit = @"m";
    if (distance > 1000) {
        distance /= 1000;
        unit = @"km".localized;
    }
    return [NSString stringWithFormat:@"%ld%@", (long)distance, unit];
}

#pragma mark - Cashless Locations

-(BOOL)checkPoint:(CLLocationCoordinate2D)coordinate existInCoordinates:(NSMutableArray <CLLocation *>*)coordinatesArray {
    CLLocationCoordinate2D coordinates[coordinatesArray.count];
    for (int i=0; i <coordinatesArray.count; i++) {
        CLLocation *location = coordinatesArray[i];
        CLLocationCoordinate2D cordinates = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        coordinates[i] = cordinates;
    }
    MKPolygon *polygon = [MKPolygon polygonWithCoordinates:coordinates count:coordinatesArray.count];
    MKPolygonRenderer *polygonRenderer = [[MKPolygonRenderer alloc] initWithPolygon:polygon];
    MKMapPoint mapPoint = MKMapPointForCoordinate(coordinate);
    CGPoint point = [polygonRenderer pointForMapPoint:mapPoint];
    return CGPathContainsPoint(polygonRenderer.path, NULL, point, NO);
}

-(BOOL)checkPoint:(CLLocationCoordinate2D)coordinate existInCircle:(CLLocationCoordinate2D)center withRadius:(double)radius  {
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:center radius:radius];
    MKCircleRenderer *render = [[MKCircleRenderer alloc] initWithCircle:circle];
    MKMapPoint mapPoint = MKMapPointForCoordinate(coordinate);
    CGPoint point = [render pointForMapPoint:mapPoint];
    return CGPathContainsPoint(render.path, NULL, point, NO);
}

- (void)getCurrentDeliveryLocationWithGeoAdress:(void(^ _Nullable)(DDDeliveryAddressM * _Nullable))callBack {
    DDDeliveryAddressM *adress = [self getCurrentDeliveryLocation];
    [DDGoogleApiManager.shared reverseGeoLocation:self.userCurrentLocation withDetailCompletionCallBack:^(GMSReverseGeocodeResponse * _Nullable response) {
        if (response!=nil) {
            adress.area = response.area;
            adress.street = response.street;
        }
        if (callBack!=nil) {
            callBack(adress);
        }
    }];
}


-(DDDeliveryAddressM *)getCurrentDeliveryLocation{
    DDDeliveryAddressM *model = [DDDeliveryAddressM new];
    if (DDLocationsManager.shared.isLocationServicesEnable) {
        [model setCoordinate:self.userCurrentLocation.coordinate];
        model.is_current_location = @(1);
    }
    return model;
}


- (void)fetchCashlessDeliveryLocationsWithCompletion:(cashlessDeliveryLocationsAPICallBack)completion {
    if (self.cashlessDeliveryLocations.count) {
        DDDeliveryLocationsAPI * response = [DDDeliveryLocationsAPI init];
        response.data.delivery_locations = self.cashlessDeliveryLocations;
        response.data.location_tags = self.cashlessDeliveryLocationTags;
        if (completion != nil) {
            completion(response, nil);
        }
        return;
    }
    [self fetchCashlessDeliveryLocationWithRequest:nil callBack:completion];
}

- (void)fetchCashlessDeliveryLocationWithRequest:(DDCashlessLocationsRequestM* _Nullable)requestM callBack:(cashlessDeliveryLocationsAPICallBack)callBack {
    
    __weak typeof (self) weakSelf = self;
    [DDNetworkManager.shared post:DDApisType_Cashless_Locations
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        DDDeliveryLocationsAPI *responseM = (DDDeliveryLocationsAPI*)model;
        
        if (responseM != nil && responseM.status.boolValue) {
            weakSelf.cashlessDeliveryLocations = responseM.data.delivery_locations.mutableCopy;
            weakSelf.cashlessDeliveryLocationTags = responseM.data.location_tags.mutableCopy;
        }
        
        if (callBack != nil) {
            callBack(responseM, error);
        }
    }];
}

- (void)deleteCashlessDeliveryLocationWithRequest:(DDCashlessLocationsRequestM* _Nullable)requestM callBack:(cashlessDeliveryLocationsAPICallBack)callBack {
    
    if (!requestM.isValidRequestForDeleteLocation) {
        [NSException raise:LOCATION_EXCEPTION format:@"%@", requestM.validationErrorForDeleteLocation];
    };
    
    [DDNetworkManager.shared post:DDApisType_Cashless_Delete_Location
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDDeliveryLocationsAPI *responseM = (DDDeliveryLocationsAPI*)model;
        if (responseM.successfulApi) {
            [self fetchCashlessDeliveryLocationWithRequest:nil callBack:callBack];
        }
        else if (callBack != nil) {
            callBack((DDDeliveryLocationsAPI*)model, error);
        }
    }];
}

- (void)updateCashlessDeliveryLocationWithRequest:(DDCashlessLocationsRequestM* _Nullable)requestM callBack:(cashlessDeliveryLocationsAPICallBack)callBack {
    if (!requestM.isValidRequestForAddLocation) {
        [NSException raise:LOCATION_EXCEPTION format:@"%@", requestM.validationErrorForAddLocation];
    }
    [DDNetworkManager.shared post:DDApisType_Cashless_Update_Location
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        DDDeliveryLocationsAPI *responseM = (DDDeliveryLocationsAPI*)model;
        if (responseM.successfulApi) {
            [self fetchCashlessDeliveryLocationWithRequest:nil callBack:callBack];
        }
        else if (callBack != nil) {
            callBack((DDDeliveryLocationsAPI*)model, error);
        }
    }];
}

- (void)addCashlessDeliveryLocationWithRequest:(DDCashlessLocationsRequestM* _Nullable)requestM callBack:(cashlessDeliveryLocationsAPICallBack)callBack {
    if (!requestM.isValidRequestForAddLocation) {
        [NSException raise:LOCATION_EXCEPTION format:@"%@", requestM.validationErrorForAddLocation];
    }
    [DDNetworkManager.shared post:DDApisType_Cashless_Add_Location
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDDeliveryLocationsAPI *responseM = (DDDeliveryLocationsAPI*)model;
        if (responseM.successfulApi) {
            [self fetchCashlessDeliveryLocationWithRequest:nil callBack:callBack];
        }
        else if (callBack != nil) {
            callBack((DDDeliveryLocationsAPI*)model, error);
        }
    }];
    
}

-(void)showSettingAlert: (void (^)(bool isSuccess))completion {
    if (![self isLocationServicesEnable]){
        [DDAlertUtils showAlertWithTitle:@"" subtitle:@"To use these offer please enable your location services." buttonNames:@[@"GO TO LOCATION SETTING",@"Cancel"] onClick:^(int index) {
            if (index == 0){
                [UIApplication.sharedApplication openURL:UIApplicationOpenSettingsURLString.URLValue options:@{} completionHandler:nil];
                completion(YES);
            }
        }];
    }
}
-(void)setCashlessDeliveryLocationTags:(NSMutableArray<DDLocationTagsM,Optional> *)cashlessDeliveryLocationTags {
    _cashlessDeliveryLocationTags = cashlessDeliveryLocationTags;
}
@end
