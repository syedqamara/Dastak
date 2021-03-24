//
//  DDNetworkManager.m
//  DDCommons
//
//  Created by Syed Qamar Abbas on 30/12/2019.
//

#import "DDNetworkManager.h"



@interface DDNetworkManager()
@property (strong, nonatomic) NSMutableArray <DDBaseApiManager *>*api_calls;
@end

@implementation DDNetworkManager
static DDNetworkManager *_sharedObject;
+(DDNetworkManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDNetworkManager alloc]init];
    });
    return _sharedObject;
}
-(instancetype)init {
    self = [super init];
    self.api_dictionary = [[NSMutableDictionary alloc]init];
    self.api_calls = [NSMutableArray new];
    return self;
}
-(void)setConfigurations:(NSMutableDictionary <NSString *,DDApisConfiguration *>*)configurations {
    self.api_dictionary = configurations;
}
-(void)loadApiWithRequest:(DDApiRequest *)request andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    if ([self.api_dictionary.allKeys containsObject:request.identifier]) {
        DDApisConfiguration *config = self.api_dictionary[request.identifier];
        __block DDBaseApiManager *apiManager = [[config.class_object alloc]init];
//        [self.api_calls addObject:apiManager];
        apiManager.api_end_point = config.end_point;
        apiManager.identifier = config.identifier;
        apiManager.response_class_object = config.response_class_object;
        apiManager.params = request.params;
        apiManager.method = request.method;
        apiManager.showHUD = request.show_hud;
        apiManager.isEncrypted = config.is_encrypted;
        apiManager.isSSLPinningEnabled = config.is_ssl_pinning;
        apiManager.isStaticApi = config.is_static_api;
        apiManager.show_local_response = request.show_local_response;
        apiManager.e_iv = request.e_iv;
        apiManager.e_key = request.e_key;
        apiManager.auth_type = config.api_auth_type;
        __weak __typeof(self) weakSElf = self;
        
        [apiManager apiDidCompleteRequest:^(DDBaseApiModel * _Nullable api_model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (api_model.http_code.intValue == 403 || api_model.http_code.intValue == 801) {
                    if (apiManager.logoutOnAPIDefinedStatuses){
                        [weakSElf postLogoutNotifications];
                    }
                }
                apiManager =  nil;
                completion(api_model, response, error);
//                [weakSElf.api_calls removeObject:apiManager];
            });
        }];
        [apiManager sendCallWithSelectorName:config.selector_name];
    }else {
        NSAssert(false, @"DD Crash: Api is not registered in configuration");
    }
}
-(void)get:(DDApisType)identifier showHUD:(BOOL)showHUD withParam:(DDBaseRequestModel * _Nullable)param andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    DDApiRequest *req = [[DDApiRequest alloc]init];
    req.method = DDApiMethodGET;
    if (param != nil) {
        req.params = param.toDictionary.mutableCopy;
        req.e_key = param.encryption_key;
        req.e_iv = param.encryption_iv;
    }
    req.show_hud = showHUD;
    req.identifier = identifier;
    [self loadApiWithRequest:req andCompletion:completion];
}
-(void)post:(DDApisType)identifier showHUD:(BOOL)showHUD withParam:(DDBaseRequestModel * _Nullable)param andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    DDApiRequest *req = [[DDApiRequest alloc]init];
    req.method = DDApiMethodPOST;
    if (param != nil) {
        req.params = param.toDictionary.mutableCopy;
        req.e_key = param.encryption_key;
        req.e_iv = param.encryption_iv;
    }
    req.show_hud = showHUD;
    req.identifier = identifier;
    [self loadApiWithRequest:req andCompletion:completion];
}
-(void)addConfiguration:(DDApisConfiguration *)config forApi:(DDApisType)apiType {
    if (self.api_dictionary == nil) {
        self.api_dictionary = [NSMutableDictionary new];
    }
    [self.api_dictionary setObject:config forKey:apiType];
}
-(DDApisConfiguration *)configurationForType:(DDApisType)apiType {
    if ([self.api_dictionary.allKeys containsObject:apiType]) {
        return self.api_dictionary[apiType];
    }
    return nil;
}
-(void)postLogoutNotifications{
    [[NSNotificationCenter defaultCenter] postNotificationName:DD_NETWORK_USER_LOGOUT object:nil];
}
-(NSDictionary *)copyApiConfig {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (NSString *str in self.api_dictionary.allKeys) {
        [dict setObject:self.api_dictionary[str].copy forKey:str];
    }
    return dict;
}
-(void)resetCache {
    for (NSString *str in self.api_dictionary.allKeys) {
        [NSUserDefaults.standardUserDefaults setObject:nil forKey:str];
    }
}
-(void)saveCache {
    for (NSString *str in self.api_dictionary.allKeys) {
        [NSUserDefaults.standardUserDefaults setObject:self.api_dictionary[str].cacheDict forKey:str];
    }
}
@end
