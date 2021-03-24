//
//  DDBaseAppConfiguration.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDProductsUIAppUIConfiguration.h"
#import "DDProductsUI.h"
@implementation DDProductsUIAppUIConfiguration
//DDUIRouterConfigurationM configureWithRouteName
+(void)loadUIConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_DDPurchase_Products_HistoryVC andModuleName:@"" withClassRef:DDPurchaseProductsHistoryVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_UI_Web_View_Product andModuleName:@"" withClassRef:DDProductPurachesWebViewController.class];
}


@end
