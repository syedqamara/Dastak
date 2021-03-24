//
//  DDApiRouterM.h
//  ApiRouter
//
//  Created by mac on 26/12/2019.
//

#import <Foundation/Foundation.h>
#import <DDConstants/DDConstants.h>
#import "DDNetworkEnums.h"
NS_ASSUME_NONNULL_BEGIN


@interface DDApisConfiguration: NSObject
@property (assign, nonatomic) DDApisType identifier;
@property (strong, nonatomic) NSString *end_point;
@property (strong, nonatomic) NSString *selector_name;
@property (strong, nonatomic) Class class_object;
@property (strong, nonatomic) Class response_class_object;
@property (assign, nonatomic) BOOL is_encrypted;
@property (assign, nonatomic) BOOL is_ssl_pinning;
@property (assign, nonatomic) BOOL is_static_api;
@property (assign, nonatomic) DDApiAuthorizationType api_auth_type;

+(void)registerConfigurations:(DDApisType)identifier classObj:(Class)cls responseClassObj:(Class)rspCls selector:(SEL)selector endPoint:(NSString *)endPoint isEncryptedEnabled:(BOOL)isEncrypted isSSLPinningEnabled:(BOOL)isSSLEnabled authorizationType:(DDApiAuthorizationType)authType;
-(NSDictionary *)cacheDict;
@end

@interface DDApiRequest: NSObject
@property (assign, nonatomic) DDApisType identifier;
@property (assign, nonatomic) BOOL show_hud;
@property (assign, nonatomic) BOOL show_local_response;
@property (strong, nonatomic) NSString *e_key;
@property (strong, nonatomic) NSString *e_iv;
@property (assign, nonatomic) DDApiMethod method;

@property (strong, nonatomic) NSMutableDictionary *params;
@end


NS_ASSUME_NONNULL_END
