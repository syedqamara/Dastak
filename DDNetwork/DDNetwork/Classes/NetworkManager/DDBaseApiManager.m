//
//  DDBaseApiM.m
//  ApiRouter
//
//  Created by mac on 26/12/2019.
//

#import "DDBaseApiManager.h"
#import "DDCommons/DDCommons.h"
#import "DDCAppConfigManager.h"
#import "DDEditConfig.h"
#import "DDNetworkManager.h"

@interface DDURLResponse : NSURLResponse
@property (strong, nonatomic) NSString *response_string;

@end

@implementation DDURLResponse


-(NSString *)description {
    if (self.response_string.length > 0) {
        return self.response_string;
    }
    return [super description];
}
-(NSString *)debugDescription  {
    return [self description];
}
@end

@interface DDBaseApiManager ()
@property (nonatomic, copy) void (^didCompleteRequest)(DDBaseApiModel * _Nullable api_model, NSURLResponse * _Nullable response, NSError * _Nullable error);
@end

@implementation DDBaseApiManager


-(instancetype)init {
    self = [super init];
    self.logoutOnAPIDefinedStatuses = YES;
    
    return self;
}

-(void)apiDidCompleteRequest:(void (^)(DDBaseApiModel * _Nullable api_model, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    self.didCompleteRequest = completion;
}

#pragma URLSESSION_DELEGATE_FOR_SSL_PINNING

-(void)returnResponseToUI:(NSData * _Nullable)data andResponse:(NSURLResponse * _Nullable)response andError:(NSError * _Nullable)error {
    DDBaseApiModel *model;
    NSData *responseData = data;
    if (error == nil) {
        if (self.isEncrypted) {
            if (self.e_iv.length > 0 && self.e_key.length > 0) {
                DDEncryptionManager.shared.key = self.e_key;
                DDEncryptionManager.shared.iv = self.e_iv;
            }
            responseData = [DDEncryptionManager.shared decryptData:responseData];
            if (responseData == nil) {
                responseData = data;
            }
        }
        if (error == nil) {
            model = [responseData decodeTo:self.response_class_object];
        }
    }
    if (self.show_local_response) {
        NSString *split = [self.api_end_point componentsSeparatedByString:@"/"].lastObject;
        if ([self.api_end_point containsString:@"merchants/"]){
            split = [self.api_end_point componentsSeparatedByString:@"/"].firstObject;
        }
        if (split.length > 0) {
            NSURL *url = [NSBundle.mainBundle URLForResource:split withExtension:@"json"];
            if (url != nil) {
                error = nil;
                NSData *localData = [NSData dataWithContentsOfURL:url];
                model = [localData decodeTo:self.response_class_object];
            }
        }
    }
    model.api_response = [data decodeTo: NSDictionary.class];
    DDURLResponse *urlResponse = [DDURLResponse.alloc init];
    urlResponse.response_string = [data stringValue];
    if (self.didCompleteRequest !=  nil) {
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf printApiLogsWith:responseData error:error];
            weakSelf.didCompleteRequest(model, urlResponse, error);
        });
    }
}
-(void)sendLocalResponse {
    DDBaseApiModel *model;
    if (self.show_local_response) {
        NSString *split = [self.api_end_point componentsSeparatedByString:@"/"].lastObject;
        if ([self.api_end_point containsString:@"merchants/"]){
            split = [self.api_end_point componentsSeparatedByString:@"/"].firstObject;
        }
        if (split.length > 0) {
            NSURL *url = [NSBundle.mainBundle URLForResource:split withExtension:@"json"];
            if (url != nil) {
                NSData *localData = [NSData dataWithContentsOfURL:url];
                model = [localData decodeTo:self.response_class_object];
            }
        }
    }
    if (self.didCompleteRequest !=  nil) {
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.didCompleteRequest(model, nil, nil);
        });
    }
}
-(NSMutableURLRequest *)createRequestWithForceSendNetworkCall:(BOOL)forceSend {
    
    if (self.base_url.length == 0) {
        self.base_url = DDCAppConfigManager.shared.api_config.API_URL;
    }
    NSString *finalURL = [NSString stringWithFormat:@"%@%@",self.base_url, self.api_end_point];
    NSMutableURLRequest *request;
    DDCCommonApiParam *config = [DDCCommonParamManager.shared.default_api_parameters.toDictionary decodeTo:DDCCommonApiParam.class];
    config.temp = @(self.isStaticApi);
    NSMutableDictionary *default_params = config.toDictionary.mutableCopy;
    if (default_params != nil) {
        [default_params addEntriesFromDictionary:self.params];
        self.params = default_params;
    }
    NSString *url_param = [self.api_end_point componentsSeparatedByString:@":"].lastObject;
    if (url_param.length > 0 && [self.api_end_point componentsSeparatedByString:@":"].count > 1) {
        id v = self.params[url_param];
        if (v == nil){
            v = @"-1";
        }
        NSString *param = v;
        if ([v isKindOfClass:NSNumber.class]) {
            param = ((NSNumber *)v).stringValue;
        }
        NSString *newKeyName = [NSString stringWithFormat:@":%@",url_param];
        self.api_end_point = [self.api_end_point stringByReplacingOccurrencesOfString:newKeyName withString:param];
        finalURL = [finalURL stringByReplacingOccurrencesOfString:newKeyName withString:param];
    }
    NSURL *url = [[NSURL alloc]initWithString:finalURL];
    request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.timeoutInterval  = 30;
    NSMutableDictionary *images = [self.params removeImagesAndGiveInNewDictionary];
    if (DDCAppConfigManager.shared.isEditConfigAllowed && [DDEditConfigBreakPointM isRequestBreakPointEnabledForApi:self.identifier] && !forceSend) {
        id data = [self.params bv_jsonDataWithPrettyPrint:YES];
        if ([data isKindOfClass:NSData.class]) {
            [self addRequestChangeObserver];
            DDNetworkManager.shared.editApiBreakPoint(data, YES);
            return nil;
        }
    }
    if (self.isEncrypted && self.params.count > 0 && images.count == 0) {
        self.non_encrypted_param = self.params;
        if (self.e_iv.length > 0 && self.e_key.length > 0) {
            DDEncryptionManager.shared.key = self.e_key;
            DDEncryptionManager.shared.iv = self.e_iv;
        }
        self.params = [DDEncryptionManager.shared encryptDictionary:self.non_encrypted_param];
    }
//    [request setValue:DDCCommonParamManager.shared.default_api_parameters.language forHTTPHeaderField:@"language"];
    if (self.method == DDApiMethodGET) {
        request.HTTPMethod = @"GET";
        [request setGETParameters:self.params options:URLQueryOptionDefault];
    }else {
        request.HTTPMethod = @"POST";
        if (images.count > 0) {
            NSString *boundary = [self multiparStringBoundary];
            request.HTTPBody = [self.params createBodyWithBoundary:boundary images:images];
            [request setMultipartHeadersWithBoundary:boundary];
        }else {
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:[self.params bv_jsonDataWithPrettyPrint:YES]];
//            [request entSetPOSTParameters:self.params];
        }
    }
    if (self.show_local_response) {
        [self sendLocalResponse];
        return nil;
    }else {
        if (self.auth_type == DDApiAuthorizationTypeBearerToken) {
            [request setBearerToken:DDCCommonParamManager.shared.default_api_parameters.api_token withPrefix:@"" withKey:@"api-token"];
        }else if(self.auth_type == DDApiAuthorizationTypeJWT){
            [request setJWTToken:DDCCommonParamManager.shared.JWTToken];
        }else {
            [request setHTTPBasicAuthUser:DDCAppConfigManager.shared.api_config.API_USER password:DDCAppConfigManager.shared.api_config.API_PASSWORD];
        }
    }
    
    return request;
}
-(void)createAndSendRequest {
    NSMutableURLRequest *req = [self createRequestWithForceSendNetworkCall:NO];
    if (req != nil) {
        [self loadWithRequest:req];
    }
}

-(NSString *)multiparStringBoundary {
    return [NSString stringWithFormat:@"Boundary-%@", NSUUID.UUID.UUIDString];
}
-(void)sendCallWithSelectorName:(NSString *)selectorName {
    SEL selector = NSSelectorFromString(selectorName);
    ((void (*)(id, SEL))[self methodForSelector:selector])(self, selector);
    [self createAndSendRequest];
}

+(void)registerApiConfiguration {
}
@end

