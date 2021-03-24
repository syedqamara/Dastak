//
//  DDCCommonApiParam.m
//  DDCommons
//
//  Created by Syed Qamar Abbas on 30/01/2020.
//

#import "DDCCommonApiParam.h"
#import "NSString+DDString.h"
#import "DeviceUtil.h"
#import "DDCAppConfigManager.h"
NS_INLINE SEL _Nonnull ISKeyAvailable(NSString*_Nonnull propertyName)
{

    NSString* firstLetter = [propertyName substringToIndex:1];
    propertyName = [propertyName substringFromIndex:1];

    propertyName = [[NSString alloc] initWithFormat:@"set%@%@:",firstLetter.capitalizedString,propertyName];

    return NSSelectorFromString(propertyName);
}

@implementation DDCCommonApiParam

-(instancetype)init {
    self = [super init];
    [self loadInitialValues];
    return self;
}
-(void)loadInitialValues {
    self.temp = @(NO);
    self.device_id = @"";
    self.__i = @"0";
    self.__lat = @"25.095395";
    self.__lng = @"55.154117";
    self.__platform = @"ios";
    self.app_version = [NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    self.company = @"delivery";
    self.device_key = @"";
    [self setDeviceModel];
    self.device_os = @"ios";
    self.language = NSString.deviceLanguage;
    self.os_version = [[UIDevice currentDevice] systemVersion];
    self.api_token = @"";
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    if (timeZone && timeZone.name){
        self.time_zone = timeZone.name;
    }
    self.location_id = @"1";
    self.user_id = @"0";
    self.extra_params = [NSMutableDictionary new];
}
- (void)setDeviceModel{
    DeviceUtil *deviceUtil = [[DeviceUtil alloc] init];
    NSString *string = [deviceUtil hardwareDescription];
    self.device_model = string;
}
-(NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [super toDictionary].mutableCopy;
    if (self.extra_params.allKeys.count > 0) {
        [dict addEntriesFromDictionary:self.extra_params];
    }
    return dict;
}
-(void)insertDictionaryWithKVO:(NSDictionary *)dict {
    for (NSInteger i = 0; i < dict.allKeys.count; i++) {
        if ([self respondsToSelector:ISKeyAvailable(dict.allKeys[i])]) {
            [self setValue:dict[dict.allKeys[i]] forKey:dict.allKeys[i]];
        }
    }
}
-(void)insertDictionary:(NSDictionary *)dict {
    if (self.extra_params == nil) {
        self.extra_params = [NSMutableDictionary new];
    }
    [self.extra_params addEntriesFromDictionary:dict];
}
@end
