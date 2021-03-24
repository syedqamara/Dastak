//
//  DDProductsApiManager.m
//  DDProducts
//
//  Created by Syed Qamar Abbas on 30/01/2020.
//

#import "DDProductsApiManager.h"
#import "DDModels.h"

#define K_PRODUCT_PROFILE_SECTION @"user/products"
#define K_PRODUCT_MERCHANT_PRODUCTS @"user/products/merchant"
#define K_PRODUCT_PURCHASED_PRODUCTS @"user/products/history"

@implementation DDProductsApiManager
-(void)loadProfileSectionProducts {
    self.isEncrypted = NO;
    self.logoutOnAPIDefinedStatuses = NO;
    self.method = DDApiMethodPOST;
}
-(void)loadMerchantDetailSectionProducts {
    self.isEncrypted = NO;
     self.logoutOnAPIDefinedStatuses = NO;
    self.method = DDApiMethodPOST;
}
-(void)loadPurchasedProducts {
//    self.base_url = DDCAppConfigManager.shared.api_config.MS_USER_API_URL;
    self.isEncrypted = NO;
     self.logoutOnAPIDefinedStatuses = NO;
    self.method = DDApiMethodPOST;
}
+(void)registerApiConfiguration {
    [DDApisConfiguration registerConfigurations:DDApisType_Products_Profile_Section classObj:self responseClassObj:DDProfileApiM.class selector:@selector(loadProfileSectionProducts) endPoint:K_PRODUCT_PROFILE_SECTION isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Products_Merchant_Detail classObj:self responseClassObj:DDProfileApiM.class selector:@selector(loadMerchantDetailSectionProducts) endPoint:K_PRODUCT_MERCHANT_PRODUCTS isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Products_Purchase_History classObj:self responseClassObj:DDProductPurchaseApiM.class selector:@selector(loadPurchasedProducts) endPoint:K_PRODUCT_PURCHASED_PRODUCTS isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
}
@end



