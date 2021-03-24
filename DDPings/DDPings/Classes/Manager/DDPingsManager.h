//
//  DDPingsManager.h
//  DDPings
//
//  Created by Hafiz Aziz on 27/01/2020.
//

#import <Foundation/Foundation.h>
#import <DDModels/DDModels.h>
#import <DDCommons/DDCommons.h>
#import <DDNetwork/DDNetwork.h>
#import "DDUserM.h"
#import "DDPingsConstant.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^ _Nullable pingCompletionCallBack)(DDPingApiModel * _Nullable model,NSURLResponse * _Nullable response, NSError * _Nullable error);
@interface DDPingsManager : NSObject

+(DDPingsManager *)shared;
@property(strong, nonatomic) DDPingApiModel *ping;

-(void)sendPingRequest:(DDPingRequestM *)pingRequestModel  andCompletion:(pingCompletionCallBack) completion;
-(void)getPingsReceivedHistory:(DDPingRequestM *)pingRequestModel  andCompletion:(pingCompletionCallBack) completion;
-(void)getPingsSendHistory:(DDPingRequestM *)pingRequestModel  andCompletion:(pingCompletionCallBack) completion;
-(void)acceptPingsRequest:(DDPingRequestM *)pingRequestModel  andCompletion:(pingCompletionCallBack) completion;
-(void)recallPingRequest:(DDPingRequestM *)pingRequestModel  andCompletion:(pingCompletionCallBack) completion;

- (void)offerSectionsWithAvailabeOffers:(NSMutableArray <DDMerchantOfferM*> *)offerSection andCompletion:(void (^)(id filterdOffers, BOOL hasPingableOffers))completion;

-(NSMutableArray *)getAllPingsAcceptableIDArray:(NSArray<DDPingModel *>*) pingsArray;

@end

NS_ASSUME_NONNULL_END
