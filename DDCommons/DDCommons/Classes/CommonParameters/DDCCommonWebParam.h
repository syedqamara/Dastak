//
//  DDCCommonWebParam.h
//  DDCommons
//
//  Created by Syed Qamar Abbas on 30/01/2020.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCCommonWebParam : JSONModel

@property (strong, nonatomic) NSString <Optional> *altoken;
@property (strong, nonatomic) NSString <Optional> *language;
@property (strong, nonatomic) NSString <Optional> *appsflyerId;
@property (strong, nonatomic) NSString <Optional> *idfa;
@property (strong, nonatomic) NSString <Optional> *bundleId;
@property (strong, nonatomic) NSString <Optional> *app_version;
@property (strong, nonatomic) NSString <Optional> *device_platform;
@property (strong, nonatomic) NSString <Optional> *os_version;
@property (strong, nonatomic) NSString <Optional> *show_close_button;
@property (strong, nonatomic) NSString <Optional> *theme;

@property (strong, nonatomic) NSString <Optional> *__t;
@property (strong, nonatomic) NSString <Optional> *location_id;
@property (strong, nonatomic) NSString <Optional> *cid;
@end

NS_ASSUME_NONNULL_END

