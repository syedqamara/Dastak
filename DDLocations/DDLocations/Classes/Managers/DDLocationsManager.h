//
//  DDLocationsManager.h
//  DDLocation
//
//  Created by Zubair Ahmad on 04/02/2020.
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

@import CoreLocation;
#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDConstants/DDConstants.h>
#import <DDModels/DDModels.h>
#import <DDCommons/DDCommons.h>
#import <DDNetwork/DDNetwork.h>
#import <DDStorage/DDStorage.h>

#import "DDLocationsUIConstants.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, DDDeliveryLocationPickerPermission) {
    DDDeliveryLocationPickerPermissionSave,
    DDDeliveryLocationPickerPermissionSetButNotSave,
    DDDeliveryLocationPickerPermissionNotSetNotSave,
};
typedef void(^ _Nullable cashlessDeliveryLocationsAPICallBack)(DDDeliveryLocationsAPI * _Nullable model, NSError * _Nullable error);

typedef void(^ _Nullable AppLocationChangeCallBack)(void);


@interface DDLocationsManager : NSObject

+(DDLocationsManager *)shared;

-(void)setupAppLocations;
-(void)setupAppLocationsForVersion:(NSString *)version;

@property (nonatomic, strong) NSMutableArray <DDLocationsM,Optional> *appSupportedLocations;
@property (nonatomic, strong) DDLocationsM *appLocation;
@property (nonatomic, strong) CLLocation *userCurrentLocation;
@property (nonatomic, assign) BOOL isLocationPermissionScreenOpened;
@property (nonatomic, assign) DDDeliveryLocationPickerPermission locationPickerPermission;
@property (nonatomic, copy) AppLocationChangeCallBack onAppLocationChange;

-(BOOL)shouldAskPermission;
-(BOOL)isLocationServicesEnable;
- (void) saveAppLocationInDefaults;
- (CLLocation*) getLocationObjectFromLatitude : (NSNumber*)lat longitude:(NSNumber*)lng;
- (CLLocationDistance)distanceFromLatidute:(NSNumber*)latidute lng:(NSNumber*)longitude;
- (NSString*)distanceFromLatidute:(NSNumber*)latidute longitude:(NSNumber*)longitude;

#pragma mark - Cashless Locations

-(BOOL)checkPoint:(CLLocationCoordinate2D)coordinate existInCoordinates:(NSMutableArray <CLLocation *>*)coordinatesArray;
-(BOOL)checkPoint:(CLLocationCoordinate2D)coordinate existInCircle:(CLLocationCoordinate2D)center withRadius:(double)radius;

@property (nonatomic, strong) DDDeliveryAddressM *selectedCashlessDeliveryLocation;
@property (nonatomic, strong) NSMutableArray <DDLocationTagsM, Optional> *cashlessDeliveryLocationTags;
@property (nonatomic, strong) NSMutableArray <DDDeliveryAddressM, Optional> *cashlessDeliveryLocations;

- (void)getCurrentDeliveryLocationWithGeoAdress:(void(^ _Nullable)(DDDeliveryAddressM * _Nullable))callBack;
- (void)addCashlessDeliveryLocationWithRequest:(DDCashlessLocationsRequestM* _Nullable)requestM callBack:(cashlessDeliveryLocationsAPICallBack)callBack;
- (void)updateCashlessDeliveryLocationWithRequest:(DDCashlessLocationsRequestM* _Nullable)requestM callBack:(cashlessDeliveryLocationsAPICallBack)callBack;
- (void)fetchCashlessDeliveryLocationsWithCompletion:(cashlessDeliveryLocationsAPICallBack)callBack;
- (void)deleteCashlessDeliveryLocationWithRequest:(DDCashlessLocationsRequestM* _Nullable)requestM callBack:(cashlessDeliveryLocationsAPICallBack)callBack;
- (void) showSettingAlert: (void (^)(bool isSuccess))completion;
@end

NS_ASSUME_NONNULL_END
