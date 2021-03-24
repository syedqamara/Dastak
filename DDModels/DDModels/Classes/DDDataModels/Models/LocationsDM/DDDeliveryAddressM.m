//
//  DDDeliveryAddressM.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 13/02/2020.
//

#define CURRDD_LOCATION_TXT @"Current Location".localized
#define SELECT_A_LOCATION @"Select a Location"

#import "DDDeliveryAddressM.h"
#import <DDCommons.h>
@interface DDDeliveryAddressM()


@end
@implementation DDDeliveryAddressM
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"delivery_location_id"}];
}
-(DDDeliveryAddressM *) getCopiedObject{
    NSError *err;
    DDDeliveryAddressM *model = [[DDDeliveryAddressM alloc] initWithDictionary:self.toDictionary error:&err];
    return model;
}

-(BOOL) isTemporaryLocation{
    if (self.is_temporary_location && self.is_temporary_location.boolValue){
        return true;
    }
    return false;
}

-(NSString *) getTitle{
    if (self.latitude.length == 0 || self.longitude.length == 0) {
        return SELECT_A_LOCATION.localized;
    }else if (self.title.length > 0) {
        return self.title;
    }
    else if (self.tag && self.tag.tag_name) {
        return self.tag.tag_name;
    }
    else if (self.is_temporary_location && self.is_temporary_location.boolValue) {
        return self.building;
    }
    else if (self.is_current_location && self.is_current_location.boolValue){
        return NSLocalizedString(CURRDD_LOCATION_TXT, nil);
    } else
    return self.title;
}

-(BOOL) isAddNewLocation {
    return self.is_new_location && self.is_new_location.boolValue;
}

-(BOOL) isCurrentLocation {
    if (self.is_current_location && self.is_current_location.boolValue){
        return true;
    }
    return false;
}

-(void) setIsAddNewLocation:(BOOL) isNewLocation {
    self.is_new_location = [NSNumber numberWithBool:isNewLocation];
}
//
//+(void) checkAndSetCurrentLocation:(NSMutableArray *) locations oldLocations:(NSArray *) oldLocations{
//    
//    DDDeliveryAddressM *selectedLocation = [[DDLocationManager sharedManager] getCurrentDeliveryLocation];
//    
//    BOOL isfound = NO;
//    
//    for (DDDeliveryAddressModel *model in locations){
//        if (model.is_current_location && model.is_current_location.boolValue){
//            isfound = YES;
//            
//            if (model.is_updated && model.is_updated.boolValue){
//            } else {
//                model.is_temporary_location = selectedLocation.is_temporary_location;
//                model.title = selectedLocation.title;
//                model.latitude = selectedLocation.latitude;
//                model.longitude = selectedLocation.longitude;
//                model.is_current_location = selectedLocation.is_current_location;
//            }
//        }
//    }
//    
//    
//    if (!isfound && selectedLocation != nil){
//        [locations insertObject:selectedLocation atIndex:0];
//    }
//    
//    
//    
//    for (DDDeliveryAddressModel *oldModel in oldLocations){
//        if (oldModel.is_temporary_location && oldModel.is_temporary_location.boolValue && ![locations containsObject:oldModel]){
//            [locations addObject:oldModel];
//        }
//    }
//}


-(void) resetDeliveryCurrentLocation{
//    if (self.is_current_location && self.is_current_location.boolValue){
//        self.is_updated = nil;
//        self.home_office_address = nil;
//        self.building = nil;
//        self.getCompleteAddress = nil;
//        self.is_temporary_location = nil;
//        DDDeliveryAddressModel *selectedLocation = [[DDLocationManager sharedManager] getCurrentDeliveryLocation];
//        self.title = selectedLocation.title;
//        self.latitude = selectedLocation.latitude;
//        self.longitude = selectedLocation.longitude;
//        self.is_current_location = selectedLocation.is_current_location;
//
//        if (DDBasket.shared.selectedLocations != nil){
//            for (DDDeliveryAddressM *model in DDBasket.shared.selectedLocations) {
//                if (model.is_current_location && model.is_current_location.boolValue){
//                    model.is_updated = nil;
//                    model.home_office_address = nil;
//                    model.building = nil;
//                    model.getCompleteAddress = nil;
//                    model.is_temporary_location = nil;
//                    DDDeliveryAddressModel *selectedLocation = [[DDLocationManager sharedManager] getCurrentDeliveryLocation];
//                    model.title = selectedLocation.title;
//                    model.latitude = selectedLocation.latitude;
//                    model.longitude = selectedLocation.longitude;
//                    model.is_current_location = selectedLocation.is_current_location;
//                    model.isNewLocation = nil;
//                    break;
//                }
//            }
//        }
//    }
}

- (NSDictionary *)getLocationParams {
    double lat = self.latitude.doubleValue;
    double lng = self.longitude.doubleValue;
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(lat, lng);
    if (CLLocationCoordinate2DIsValid(coords)) {
        return @{
            @"lat" : self.latitude,
            @"lng" : self.longitude
        };
    }
    return nil;
}

-(CLLocationCoordinate2D)toCoreLocationCoordinate {
    return CLLocationCoordinate2DMake(self.latitude.doubleValue, self.longitude.doubleValue);
}

-(void)setCoordinate:(CLLocationCoordinate2D)coordinate {
    self.latitude = [[NSNumber numberWithDouble:coordinate.latitude] stringValue];
    self.longitude = [[NSNumber numberWithDouble:coordinate.longitude] stringValue];
}

+(NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)fileLocation{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileLocation stringByDeletingPathExtension] ofType:[fileLocation pathExtension]];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    // Be careful here. You add this as a category to NSDictionary
    // but you get an id back, which means that result
    // might be an NSArray as well!
    if (error != nil) return nil;
    return result;
}

- (NSString<Optional> *)getCompleteAddress
{
    
    return [NSString stringWithFormat:@"%@\n%@\n%@",self.flat,self.building, self.area];
}

- (NSString<Optional> *)getAddress
{
    if ([self isTemporaryLocation]){
        return [NSString stringWithFormat:@"%@", self.area];
    } else if ([self isCurrentLocation]) {
        return CURRDD_LOCATION_TXT.localized;
    }else {
        return [self getCompleteAddress];
    }
    
}
-(NSDictionary *)toApiCoordinates {
    if (self.latitude.length > 0 && self.longitude.length > 0) {
        return @{@"selected_delivery_lat":self.latitude, @"selected_delivery_lng":self.longitude};
    }
    return @{@"selected_delivery_lat":@"0", @"selected_delivery_lng":@"0"};
}
-(NSDictionary *)toDictionaryValue {
    NSMutableDictionary *dict = [[self toDictionary] mutableCopy];
    if(self.tag) {
        [dict setObject:self.tag.tag_id forKey:@"tag_id"];
    }
    return dict;
}
- (BOOL)isSelected {
    return (self.is_selected != nil && self.is_selected.boolValue);
}
@end


@implementation DDLocationTagsM

- (BOOL)isSelected {
    return (self.is_selected != nil && self.is_selected.boolValue);
}

- (BOOL)isCustom {
    return (self.allow_custom_name != nil && self.allow_custom_name.boolValue);
}

@end
