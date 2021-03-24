//
//  DDGoogleApiManager.h
//  DDLocations
//
//  Created by Awais Shahid on 17/02/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>
#import "DDLocationsManager.h"

@import GooglePlaces;
@import GoogleMaps;
@import CoreLocation;
NS_ASSUME_NONNULL_BEGIN


@interface GMSReverseGeocodeResponse (DDGMSReverseGeocodeResponse)
-(NSString* _Nullable)formattedAddress;
-(NSString* _Nullable)area;
-(NSString* _Nullable)street;
@end




@interface DDGoogleApiManager : NSObject
+(DDGoogleApiManager *)shared;
-(void)searchLocationsFromText:(NSString*)text withCompletion:(void (^ _Nullable)(NSArray*))completion;
-(void)searchLocationsFromText:(NSString*)text inBounds:(GMSCoordinateBounds* _Nullable)bounds withCompletion:(void (^ _Nullable)(NSArray* _Nullable))completion;

-(void)reverseGeoLocation:(CLLocation*)location withCompletionCallBack:(StringCompletionCallBack)callback;
-(void)reverseGeoLocation:(CLLocation*)location withDetailCompletionCallBack:(void (^_Nullable) (GMSReverseGeocodeResponse* _Nullable))callback;

-(void)lookUpPlaceById:(NSString* _Nullable)placeID completionCallBack:(void (^_Nullable)(GMSPlace* _Nullable))callback;
-(void)findDirection:(CLLocationCoordinate2D)start andDestination:(CLLocationCoordinate2D)dest completionCallBack:(void (^_Nullable)(NSArray<NSString *>* _Nullable))callback;
@end


NS_ASSUME_NONNULL_END
