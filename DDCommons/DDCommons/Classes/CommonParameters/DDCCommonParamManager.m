//
//  DDCCommonParamManager.m
//  DDCommons
//
//  Created by Syed Qamar Abbas on 31/12/2019.
//

#import "DDCCommonParamManager.h"
#import "DDCAppConfigManager.h"
#import "JWT.h"

#define JWT_HS256 @"HS256"

@implementation DDCCommonParamManager
static DDCCommonParamManager *_sharedObject;
+(DDCCommonParamManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDCCommonParamManager alloc]init];
    });
    return _sharedObject;
}
-(instancetype)init {
    self = [super init];
    [self reset];
    return self;
}
-(void)reset{
    NSString *device = self.default_api_parameters.device_id;
    self.default_api_parameters = [[DDCCommonApiParam alloc]init];
    self.default_api_parameters.device_id = device;
    self.default_api_parameters.device_key = device;
    self.default_web_parameters = [[DDCCommonWebParam alloc]init];
}
-(NSString*)getDefaultWebParametersUrl:(NSString*)url{
    NSString *paramStarter = @"";
    if ([url containsString:@"?"]){
        paramStarter = @"&";
    } else {
        paramStarter = @"?";
    }
    NSDictionary *dic = [self.default_web_parameters toDictionary];
    for (NSString *key in dic.allKeys) {
        paramStarter = [paramStarter  stringByAppendingString:[NSString stringWithFormat:@"%@&",[dic valueForKey:key]]];
    }
    return [NSString stringWithFormat:@"%@%@",url,paramStarter];
}
-(void)setLocationID:(NSString *)locationId {
    self.default_web_parameters.location_id = locationId;
    self.default_api_parameters.location_id = locationId;
}
-(void)setUserId:(NSString *)userId {
    self.default_web_parameters.cid = userId;
    self.default_api_parameters.__i = userId;
}
-(void)setSession:(NSString *)sessionToken {
    self.default_web_parameters.__t = sessionToken;
    self.default_api_parameters.api_token = sessionToken;
}
-(NSString *)JWTToken {
    NSMutableDictionary *jwt = [NSMutableDictionary new];
    if (self.default_api_parameters.api_token.length > 0) {
        [jwt setValue:self.default_api_parameters.api_token forKey:@"session_token"];
    }else {
        [jwt setValue:@"" forKey:@"session_token"];
    }
    [jwt setValue:self.default_api_parameters.company forKey:@"company"];
    [jwt setValue:self.default_api_parameters.company forKey:@"company"];
    [jwt setValue:DDCAppConfigManager.shared.api_config.JWT_API_KEY forKey:@"api_token"];
    id <JWTAlgorithm> algorithm = [JWTAlgorithmFactory algorithmByName:JWT_HS256];
    NSString *result = [JWTBuilder encodePayload:jwt].secret(DDCAppConfigManager.shared.api_config.JWT_SECRET_KEY).algorithm(algorithm).encode;
    if (result != nil) {
        return [NSString stringWithFormat:@"Bearer %@",result];// result;
    }
    return @"Bearer ";
}
@end

