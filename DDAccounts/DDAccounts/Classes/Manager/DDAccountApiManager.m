//
//  DDAccountApiManager.m
//  DDAccounts
//
//  Created by M.Jabbar on 30/01/2020.
//

#import "DDAccountApiManager.h"

#define K_EP_SETTINGS @"profile/settings"
#define K_EP_FEEDBACK @"app/feedback"
#define K_EP_PURCHASE_SMILES @"smiles/purchase"
#define K_EP_PURCHASE_SAVINGS_M @"savingmonthly"
#define K_EP_PURCHASE_SAVINGS_M_F @"user/savings/detail"

@implementation DDAccountApiManager
-(void)settings {}
-(void)feedback {}
-(void)purchaseSmilesPack {}
-(void)savings {
    self.base_url = DDCAppConfigManager.shared.api_config.ANALYTICS_BASE_URL;
    self.api_end_point = K_EP_PURCHASE_SAVINGS_M_F;
    self.method = DDApiMethodPOST;
    self.isEncrypted = YES;
}

+(void)registerApiConfiguration {
    [DDApisConfiguration registerConfigurations:DDApisType_Account_Settings classObj:self responseClassObj:DDSettingsApiM.class selector:@selector(settings) endPoint:K_EP_SETTINGS isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    
    [DDApisConfiguration registerConfigurations:DDApisType_Account_Submit_Feed_Back classObj:self responseClassObj:DDResponseMessageApiM.class selector:@selector(feedback) endPoint:K_EP_FEEDBACK isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
   
    [DDApisConfiguration registerConfigurations:DDApisType_Account_Buy_Smiles_Pack classObj:self responseClassObj:DDBuyPingsApiM.class selector:@selector(purchaseSmilesPack) endPoint:K_EP_PURCHASE_SMILES isEncryptedEnabled:NO isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
     [DDApisConfiguration registerConfigurations:DDApisType_Account_Savings classObj:self responseClassObj:DDSavingsDetailAPI.class selector:@selector(savings) endPoint:K_EP_PURCHASE_SAVINGS_M_F isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];

    
}
@end
