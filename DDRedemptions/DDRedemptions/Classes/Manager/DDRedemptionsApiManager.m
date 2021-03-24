//
//  DDRedemptionsApiManager.m
//  DDRedemptions
//
//  Created by Hafiz Aziz on 11/02/2020.
//

#import "DDRedemptionsApiManager.h"
#import "DDRedemptionsConstant.h"
#import <DDModels/DDModels.h>


@implementation DDRedemptionsApiManager
-(void)redemptionHistory {
    self.method = DDApiMethodPOST;
    self.base_url = DDCAppConfigManager.shared.api_config.ANALYTICS_BASE_URL;
}
-(void)reservationHistory {
    self.method = DDApiMethodPOST;
    self.isEncrypted = NO;
}

-(void)buybackOffer {
}

-(void)redemptions {
}

-(void)checkInternetConeection {
    self.method = DDApiMethodGET;
}

+(void)registerApiConfiguration {
    [DDApisConfiguration registerConfigurations:DDApisType_Redemption_History classObj:self responseClassObj:DDBaseHistoryAPIModel.class selector:@selector(redemptionHistory) endPoint:K_EP_REDEMPTION_HISTORY isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Redemption_BuyBack classObj:self responseClassObj:DDRedemptionBuyBackApiM.class selector:@selector(buybackOffer) endPoint:K_EP_REDEMPTION_BUYBACK isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Reservations_History classObj:self responseClassObj:DDBaseHistoryAPIModel.class selector:@selector(reservationHistory) endPoint:K_EP_RESERVATION_HISTORY isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Redemption_Redemptions classObj:self responseClassObj:DDRedemptionAPIModel.class selector:@selector(redemptions) endPoint:K_EP_REDEMPTIONS isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Redemption_NETWORK_CHECK classObj:self responseClassObj:DDRedemptionAPIModel.class selector:@selector(checkInternetConeection) endPoint:K_EP_REDEMPTIONS_NETWORK_CHECK isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
}
@end
