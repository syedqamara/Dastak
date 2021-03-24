//
//  DDPingsApiManager.m
//  DDPings
//
//  Created by Hafiz Aziz on 27/01/2020.
//

#import "DDPingsApiManager.h"
#import "DDModels.h"
#import "DDPingsConstant.h"

@implementation DDPingsApiManager
-(void)sendPingRequest {
    self.method = DDApiMethodPOST;
}
-(void)getReceivedPingsHistory {
    self.method = DDApiMethodPOST;
}
-(void)getSendPingsHistory {
    self.method = DDApiMethodPOST;
}
-(void)acceptPing {}
-(void)rejectPing {}


+(void)registerApiConfiguration {
    [DDApisConfiguration registerConfigurations:DDApisType_Pings_Send classObj:self responseClassObj:DDPingApiModel.class selector:@selector(sendPingRequest) endPoint:K_EP_PING_SHARING_SEND isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Pings_ReceivedHistory classObj:self responseClassObj:DDPingApiModel.class selector:@selector(getReceivedPingsHistory) endPoint:K_EP_PING_RECEIVED_OFFER isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Pings_SendHistory classObj:self responseClassObj:DDPingApiModel.class selector:@selector(getSendPingsHistory) endPoint:K_EP_PING_SEND_OFFER isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Pings_AcceptPings classObj:self responseClassObj:DDPingApiModel.class selector:@selector(acceptPing) endPoint:K_EP_PING_SHARING_ACCEPT isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Pings_RecallPing classObj:self responseClassObj:DDPingApiModel.class selector:@selector(acceptPing) endPoint:K_EP_PING_PINGS_RECALL isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
}
@end
