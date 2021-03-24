//
//  DDNetworkManager.h
//  DDCommons
//
//  Created by Syed Qamar Abbas on 30/12/2019.
//

#import <Foundation/Foundation.h>
#import "DDApiClasses.h"
#import "DDBaseApiManager.h"
#import <DDModels/DDModels.h>
#import "DDEditConfig.h"
NS_ASSUME_NONNULL_BEGIN


#define DD_NETWORK_USER_LOGOUT @"DD_NETWORK_USER_LOGOUT"

@interface DDNetworkManager : NSObject

@property (nonatomic, strong) NSMutableDictionary <NSString *,DDApisConfiguration *>*api_dictionary;

+(DDNetworkManager *)shared;
@property (nonatomic, copy) void (^editApiBreakPoint)(NSData * _Nullable param, BOOL isRequest);
-(DDApisConfiguration *)configurationForType:(DDApisType)apiType;
-(void)addConfiguration:(DDApisConfiguration *)config forApi:(DDApisType)apiType;
-(void)setConfigurations:(NSMutableDictionary <NSNumber *,DDApisConfiguration *>*)configurations;
-(void)get:(DDApisType)identifier showHUD:(BOOL)showHUD withParam:(DDBaseRequestModel * _Nullable)param andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)post:(DDApisType)identifier showHUD:(BOOL)showHUD withParam:(DDBaseRequestModel * _Nullable)param andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(NSDictionary *)copyApiConfig;
-(void)resetCache;
-(void)saveCache;
@end


NS_ASSUME_NONNULL_END
