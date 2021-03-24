//
//  DDBaseApiBreakPointManager.h
//  DDNetwork
//
//  Created by Syed Qamar Abbas on 26/04/2020.
//

#import "DDCommons.h"
#import <Foundation/Foundation.h>
#import <DDEncryption/DDEncryption.h>
#import "DDBaseApiModel.h"
#import "DDNetworkEnums.h"
#import "DDConstants.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDBaseApiBreakPointManager : NSObject
@property (assign, nonatomic) DDApisType identifier;
@property (assign, nonatomic) DDApiMethod method;
@property (assign, nonatomic) DDApiParamType param_type;
@property (assign, nonatomic) DDApiAuthorizationType auth_type;
@property (strong, nonatomic) NSString *api_end_point;
@property (strong, nonatomic) NSString *base_url;
@property (strong, nonatomic) NSMutableDictionary *params;
@property (strong, nonatomic) NSString *e_key;
@property (strong, nonatomic) NSString *e_iv;
@property (assign, nonatomic) BOOL isEncrypted;
@property (assign, nonatomic) BOOL isSSLPinningEnabled;
@property (assign, nonatomic) BOOL isStaticApi;
@property (assign, nonatomic) BOOL show_local_response;
@property (assign, nonatomic) BOOL showHUD;
@property (assign, nonatomic) BOOL logoutOnAPIDefinedStatuses;
@property (strong, nonatomic) NSURLResponse *response;
@property (strong, nonatomic) Class response_class_object;
@property (strong, nonatomic) NSMutableDictionary *non_encrypted_param;
-(void)showProgressHUD;
-(void)hideProgressHUD;
-(void)addRequestChangeObserver;
-(void)printApiLogsWith:(NSData*)data error:(NSError*)error;
-(void)returnResponseToUI:(NSData * _Nullable)data andResponse:(NSURLResponse * _Nullable)response andError:(NSError * _Nullable)error;
-(void)didRecieveResponse:(NSData * _Nullable)data andResponse:(NSURLResponse * _Nullable)response andError:(NSError * _Nullable)error;
-(NSMutableURLRequest *)createRequestWithForceSendNetworkCall:(BOOL)forceSend;
-(void)loadWithRequest:(NSMutableURLRequest *)request;
@end

NS_ASSUME_NONNULL_END
