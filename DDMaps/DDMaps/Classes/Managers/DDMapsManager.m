//
//  DDMapsManager.m
//  DDMaps
//
//  Created by Zubair Ahmad on 21/01/2020..
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

#import "DDMapsManager.h"
#import <DDLocations.h>

@implementation DDMapsManager

static DDMapsManager *_sharedObject;

+(DDMapsManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDMapsManager alloc]init];
    });
    return _sharedObject;
}

- (void)fetchListOfOutlets:(DDBaseRequestModel *)outletsReqModel showLoader: (BOOL)showLoader  andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSMutableArray <DDMapMarker*> *) setMarkersData : (NSMutableArray *) outlets {
    NSMutableArray <DDMapMarker*> *mapMarkers = [[NSMutableArray alloc] init];
    
    return mapMarkers;
}

- (NSMutableArray <DDMapMarker*> *) setMarkersDataFromLocations  {
    NSMutableArray *locations = [[DDLocationsManager shared] appSupportedLocations];
    
    NSMutableArray <DDMapMarker*> *mapMarkers = [[NSMutableArray alloc] init];
    for (DDLocationsM *location in locations) {
        DDMapMarker *marker = [[DDMapMarker alloc] init];
        marker.lattitude = location.lat;
        marker.longitude = location.lng;
        marker.localPinImage = [NSString  stringWithFormat:@"country_pin"];
        marker.markerData = location;
        [mapMarkers addObject:marker];
    }
    return mapMarkers;
}

@end
