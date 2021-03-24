//
//  DDDeliveryAddressM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 13/02/2020.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@class DDLocationTagsM;
@protocol DDDeliveryAddressM
@end

@protocol DDLocationTagsM
@end

@interface DDDeliveryAddressM : JSONModel

@property (nonatomic, strong) NSNumber <Optional> *isNewLocationTap;
@property (nonatomic, strong) NSString <Optional> *title;
@property (nonatomic, strong) DDLocationTagsM <Optional> *tag;
@property (nonatomic, strong) NSString<Optional> * flat;
@property (nonatomic, strong) NSString<Optional> * building;
@property (nonatomic, strong) NSString<Optional> * street;
@property (nonatomic, strong) NSString<Optional> * area;
@property (nonatomic, strong) NSString<Optional> * special_instructions;
@property (nonatomic, strong) NSString<Optional> * latitude;
@property (nonatomic, strong) NSString<Optional> * longitude;
@property (nonatomic, strong) NSString<Optional> * getCompleteAddress;
@property (nonatomic, strong) NSNumber<Optional> * delivery_location_id;

@property (nonatomic, strong) NSNumber<Optional> * is_updated;
@property (nonatomic, strong) NSNumber<Optional> * is_current_location;
@property (nonatomic, strong) NSNumber<Optional> * is_temporary_location;

@property (nonatomic, strong) NSNumber<Optional> * is_new_location;
@property (nonatomic, strong) NSNumber<Optional> * selectedIndex;
@property (nonatomic, strong) NSNumber<Optional> * is_selected;
-(BOOL)isSelected;

-(DDDeliveryAddressM *) getCopiedObject;
-(CLLocationCoordinate2D)toCoreLocationCoordinate;
-(void)setCoordinate:(CLLocationCoordinate2D)coordinate;
-(NSDictionary *)toApiCoordinates;
-(NSDictionary *)toDictionaryValue;
-(NSString *) getTitle;
-(void) resetDeliveryCurrentLocation;
- (NSString<Optional> *)getAddress;
-(NSDictionary *)getLocationParams;


-(BOOL) isAddNewLocation;
-(void) setIsAddNewLocation:(BOOL) isNewLocation;
-(BOOL) isTemporaryLocation;
-(BOOL) isCurrentLocation;


@end


@interface DDLocationTagsM : JSONModel
@property (nonatomic, strong) NSString<Optional> * tag_name;
@property (nonatomic, strong) NSString<Optional> * image_url;
@property (nonatomic, strong) NSNumber<Optional> * tag_id;
@property (nonatomic, strong) NSNumber<Optional> * allow_custom_name;
@property (nonatomic, strong) NSNumber<Optional> * is_selected;
-(BOOL)isSelected;
-(BOOL)isCustom;
@end


NS_ASSUME_NONNULL_END
