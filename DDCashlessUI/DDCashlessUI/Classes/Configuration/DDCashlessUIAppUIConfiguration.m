//
//  DDBaseAppConfiguration.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDCashlessUIAppUIConfiguration.h"
#import "DDCashlessUI.h"
@implementation DDCashlessUIAppUIConfiguration
+(void)loadUIConfiguration {
    NSString *moduleName = @"Cashless";
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Merchant_Detail andModuleName:moduleName withClassRef:DDCashlessMerchantDetailVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Order_Status andModuleName:moduleName withClassRef:DDOrderStatusVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Outlet_Listing_Continer andModuleName:moduleName withClassRef:DDCashlessOutletListingContainerVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Item_Customization andModuleName:moduleName withClassRef:DDCashlessCustomizationAdditionVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Cart_Web andModuleName:moduleName withClassRef:DDCashlessCartWebVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Remove_Items andModuleName:moduleName withClassRef:DDCashlessRemoveItemsVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Order_History andModuleName:moduleName withClassRef:DDOrderHistoryVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Outlet_Selection andModuleName:moduleName withClassRef:DDCashlessOutletSelectionVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Order_Status_Map andModuleName:moduleName withClassRef:DDOrderStautsMapVC.class];
    
}

@end
