//
//  DDCountryM.h
//  DDCommons
//
//  Created by M.Jabbar on 07/01/2020.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "DDJSONModelProtocols.h"
NS_ASSUME_NONNULL_BEGIN



@interface DDCountryM: JSONModel

@property (nonatomic, strong) NSNumber <Optional> *country_id;
@property (nonatomic, strong) NSString <Optional> *shortname;
@property (nonatomic, strong) NSString <Optional> *name;
@property (nonatomic, strong) NSNumber <Optional> *position;
@property (nonatomic, strong) NSString <Optional> *code;
@property (nonatomic, strong) NSString <Optional> *image_url;


@property (nonatomic, strong) NSString <Optional> *region;

-(NSString *)titleWithImage;
-(NSString *)codeWithImage;
+(NSArray<DDCountryM*>*)countriesPhones;
+(NSArray<DDCountryM*>*)countries;
+(NSArray<DDCountryM*>*)getCountriesData:(NSString*)fileLocation;

@end

@interface DDCountrySectionM: JSONModel
@property (nonatomic, strong) NSString <Optional> *country_name;
@property (nonatomic, strong) NSString <Optional> *country_short_name;
@property (nonatomic, strong) NSString <Optional> *flag;
@property (nonatomic, strong) NSString <Optional> *currency;
// below attriburs will be use for travel destinations
@property (nonatomic, strong) NSNumber <Optional> *default_lat;
@property (nonatomic, strong) NSNumber <Optional> *default_lng;
//@property (nonatomic, strong) NSString <Optional> *phone_codes;
@property (nonatomic, strong) NSArray <DDCountryM, Optional> *phone_codes;

@end

NS_ASSUME_NONNULL_END
