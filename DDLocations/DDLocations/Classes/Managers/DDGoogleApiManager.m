//
//  DDGoogleApiManager.m
//  DDLocations
//
//  Created by Awais Shahid on 17/02/2020.
//

#import "DDGoogleApiManager.h"

@implementation GMSReverseGeocodeResponse (DDGMSReverseGeocodeResponse)

-(NSString* _Nullable)formattedAddress {
    if (self.firstResult.lines.count) {
        return self.firstResult.lines.firstObject;
    }
    return @"";
}

- (NSString *_Nullable)area {
    return self.formattedAddress;
}

- (NSString *)street {
    if (self.firstResult) {
        return self.firstResult.thoroughfare;
    }
    return @"";
}

@end


@implementation DDGoogleApiManager

static DDGoogleApiManager *_sharedObject;

+(DDGoogleApiManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDGoogleApiManager alloc]init];
    });
    return _sharedObject;
}

-(void)reverseGeoLocation:(CLLocation*)location withDetailCompletionCallBack:(void (^_Nullable) (GMSReverseGeocodeResponse* _Nullable))callback {
    [[GMSGeocoder geocoder] reverseGeocodeCoordinate:location.coordinate completionHandler:^(GMSReverseGeocodeResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            [DDLogs log:@"DDGoogle Geo Reverse Error %@", error.localizedDescription];
        }
        if (callback != nil) {
            callback(response);
        }
    }];
}

-(void)reverseGeoLocation:(CLLocation*)location withCompletionCallBack:(StringCompletionCallBack)callback {
    [self reverseGeoLocation:location withDetailCompletionCallBack:^(GMSReverseGeocodeResponse * _Nonnull response) {
        if (callback!=nil) {
            callback(response.formattedAddress);
        }
    }];
    
}

- (void)searchLocationsFromText:(NSString *)text withCompletion:(void (^ _Nullable)(NSArray*))completion {
    [self searchLocationsFromText:text inBounds:nil withCompletion:completion];
}

- (void)searchLocationsFromText:(NSString *)text inBounds:(GMSCoordinateBounds *_Nullable)bounds withCompletion:(void (^)(NSArray * _Nullable))completion {
    if (text.trimmedString.length == 0) {
        if (completion != nil) { completion(@[]); }
        return;
    }
    
    if (bounds == nil && DDLocationsManager.shared.userCurrentLocation != nil) {
        bounds = [[GMSCoordinateBounds alloc] includingCoordinate:DDLocationsManager.shared.userCurrentLocation.coordinate];
    }
    
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterNoFilter;
    
    [GMSPlacesClient.sharedClient autocompleteQuery:text bounds:bounds filter:filter callback:^(NSArray<GMSAutocompletePrediction *> * _Nullable results, NSError * _Nullable error) {
        
        if (error!=nil) {
            [DDLogs log:@"DDGoogle AutoComplete Error %@", error.localizedDescription];
        }
        if (completion != nil) {
            completion(results);
        }
    }];
}

-(void)lookUpPlaceById:(NSString* _Nullable)placeID completionCallBack:(void (^_Nullable)(GMSPlace* _Nullable))callback {
    if (placeID.length == 0) return;
    [GMSPlacesClient.sharedClient lookUpPlaceID:placeID callback:^(GMSPlace * _Nullable result, NSError * _Nullable error) {
        if (error!=nil) {
            [DDLogs log:@"DDGoogle place detail Error %@", error.localizedDescription];
        }
        if (callback != nil) {
            callback(result);
        }
    }];
}
-(void)findDirection:(CLLocationCoordinate2D)start andDestination:(CLLocationCoordinate2D)dest completionCallBack:(void (^_Nullable)(NSArray<NSString *>* _Nullable))callback{
//    DDApisType_Google_Direction
    DDBaseRequestModel *req = [DDBaseRequestModel new];
    [req addCustomParams:@{
        @"origin": [NSString stringWithFormat:@"%f,%f",start.latitude,start.longitude],
        @"destination": [NSString stringWithFormat:@"%f,%f",dest.latitude,dest.longitude],
        @"sensor":@"false",
        @"mode": @"driving",
        @"alternatives": @"true",
        @"key": DDCAppConfigManager.shared.api_config.GOOGLE_API_KEY,
    }];
    [DDNetworkManager.shared get:DDApisType_Google_Direction showHUD:YES withParam:req andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSArray <NSDictionary *>*routes = model.api_response[@"routes"];
        NSArray <NSDictionary *> *legs = routes.firstObject[@"legs"];
        NSArray <NSDictionary *> *steps = legs.firstObject[@"steps"];
        NSMutableArray *arr = [NSMutableArray new];
        for (NSDictionary *step in steps) {
            NSDictionary *polyline = step[@"polyline"];
            NSString *polylineStr = polyline[@"points"];
            [arr addObject:polylineStr];
        }
        if (callback != nil) {
            callback(arr);
        }
    }];
}
@end
