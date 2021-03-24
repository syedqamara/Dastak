//
//  DDLocationsM.h
//  DDModels
//
//  Created by Zubair Ahmad on 04/02/2020.
//

#import "DDBaseApiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDLocationsM : DDBaseApiModel

@property (nonatomic, strong) NSNumber<Optional> * location_id;
@property (nonatomic, strong) NSString<Optional> * currency;
@property (nonatomic, strong) NSString<Optional> * name;
@property (nonatomic, strong) NSNumber<Optional> * active;
@property (nonatomic, strong) NSNumber<Optional> * lat;
@property (nonatomic, strong) NSNumber<Optional> * lng;
@property (nonatomic, strong) NSString<Optional> * language;
@property (nonatomic, strong) NSString<Optional> * flag;
@property (nonatomic, strong) NSString<Optional> * background;
@property (nonatomic, strong) NSString<Optional> * savings_image_url;
@property (nonatomic, strong) NSString<Optional> * savings_small_image_url;
@property (nonatomic, strong) NSNumber<Optional> * reload_background;
@property (nonatomic, strong) NSNumber<Optional> * is_show_category;
@property (nonatomic, strong) NSNumber<Optional> * is_careem_enabled;
@property (nonatomic, strong) NSNumber<Optional> * is_show_delivery_tab;

@property (nonatomic, strong) NSString<Optional> * snack_bar_title;
@property (nonatomic, strong) NSString<Optional> * snack_bar_des;
@property (nonatomic, strong) NSNumber<Optional> * snack_bar_duration;
+(DDLocationsM*)defaultLocation;

@end

NS_ASSUME_NONNULL_END
