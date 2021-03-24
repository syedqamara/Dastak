//
//  DDPingsManager.m
//  DDPings
//
//  Created by Hafiz Aziz on 27/01/2020.
//

#import "DDPingsManager.h"

@implementation DDPingsManager

static DDPingsManager  *_sharedObject;

+(DDPingsManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDPingsManager alloc]init];
    });
    return _sharedObject;
}

//MARK: - API Request Methods
-(void)sendPingRequest:(DDPingRequestM *)pingRequestModel  andCompletion:(pingCompletionCallBack) completion{
    
    [self postApiRequest:DDApisType_Pings_Send andParam:pingRequestModel completion:completion];
}
-(void)getPingsReceivedHistory:(DDPingRequestM * )pingRequestModel  andCompletion:(pingCompletionCallBack) completion{
    
    if (!pingRequestModel.isValidRequest) {
        [NSException raise:PING_EXCEPTION format:@"%@", pingRequestModel.validationErrorMessage];
    };
    [self getApiRequest:DDApisType_Pings_ReceivedHistory andParam:pingRequestModel completion:completion];
}
-(void)getPingsSendHistory:(DDPingRequestM *)pingRequestModel  andCompletion:(pingCompletionCallBack) completion{
    if (!pingRequestModel.isValidRequest) {
        [NSException raise:PING_EXCEPTION format:@"%@", pingRequestModel.validationErrorMessage];
    };
    [self postApiRequest:DDApisType_Pings_SendHistory andParam:pingRequestModel completion:completion];
}

// MARK: - Accept Reject PING

-(void)acceptPingsRequest:(DDPingRequestM *)pingRequestModel  andCompletion:(pingCompletionCallBack) completion{
    [self postApiRequest:DDApisType_Pings_AcceptPings andParam:pingRequestModel completion:completion];
}

// MARK: - Recall Pings
-(void)recallPingRequest:(DDPingRequestM *)pingRequestModel  andCompletion:(pingCompletionCallBack) completion{
    [self postApiRequest:DDApisType_Pings_RecallPing andParam:pingRequestModel completion:completion];
}

// MARK: - General Ping API Call
-(void)getApiRequest:(DDApisType)request andParam:(DDBaseRequestModel *)model completion:(pingCompletionCallBack)completion{
    
    __weak typeof(self) weakSelf = self;
    [DDNetworkManager.shared get:request showHUD:YES withParam:model andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDPingApiModel *ping = (DDPingApiModel*)model;
        if (model) {
            weakSelf.ping = ping;
        }
        if (completion != nil)
            completion(ping,response,error);
    }];
}
-(void)postApiRequest:(DDApisType)type andParam:(DDBaseRequestModel *)model completion:(pingCompletionCallBack)completion {
    __weak typeof(self) weakSelf = self;
   
    [DDNetworkManager.shared post:type showHUD:YES withParam:model andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDPingApiModel *ping = (DDPingApiModel*)model;
        if (model) {
            weakSelf.ping = ping;
        }
        if (completion != nil)
            completion(ping,response,error);
    }];
}

- (void)offerSectionsWithAvailabeOffers:(NSMutableArray <DDMerchantOfferM*> *)offerSection andCompletion:(void (^)(id filterdOffers, BOOL hasPingableOffers))completion {
    NSMutableArray <DDMerchantOfferM*> *filteredOffers = [[NSMutableArray alloc] init];
    BOOL hasAnyPingableOffer = NO;
    for (DDMerchantOfferM *section in offerSection){
        
        NSMutableArray <DDMerchantOfferToDisplay*> *offers_to_display_pingable = [[NSMutableArray alloc] init];
        
        for (int i=0; i<section.offers_to_display.count;  i++) {
            DDMerchantOfferToDisplay *offer = section.offers_to_display[i];
            if ([offer isPingable]){
                [offers_to_display_pingable addObject:offer];
                hasAnyPingableOffer = YES;
            }
            [offer setSelectedForPing:NO];
        }
        section.offers_to_display = offers_to_display_pingable.mutableCopy;
        [filteredOffers addObject:section];
    }
    completion(filteredOffers,hasAnyPingableOffer);
}

//MARK: - Get Pings Array
-(NSMutableArray *)getAllPingsAcceptableIDArray:(NSArray<DDPingModel *>*) pingsArray{
    NSMutableArray *pingsIdArray = [[NSMutableArray alloc] init];
    for (DDPingModel *obj in pingsArray) {
        if (!obj.isAccepted){
            [pingsIdArray addObject:[NSString stringWithFormat:@"%@",obj.ping_id]];
        }
    }
    return pingsIdArray;
}

@end
