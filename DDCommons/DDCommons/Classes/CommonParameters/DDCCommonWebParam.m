//
//  DDCCommonWebParam.m
//  DDCommons
//
//  Created by Syed Qamar Abbas on 30/01/2020.
//

#import "DDCommons.h"
#import "DDCCommonWebParam.h"
#import "NSString+DDString.h"
@implementation DDCCommonWebParam
-(instancetype)init {
    self = [super init];
    [self initializeInitialData];
    return self;
}
-(void)initializeInitialData {
    self.idfa = NSString.advertisingIdentifier;
    self.app_version = NSString.appVersion;
    self.bundleId = APP_BUNDLE_ID;
    self.altoken = @"xxxx";
    self.os_version = [[UIDevice currentDevice] systemVersion];
    self.device_platform = @"ios";
    self.language = NSString.deviceLanguage;
    self.appsflyerId = @"";
    self.cid = @"0";
    self.__t = @"";
    self.location_id = @"1";
    self.show_close_button = @"true";
    self.theme = @"v7";
}

@end
