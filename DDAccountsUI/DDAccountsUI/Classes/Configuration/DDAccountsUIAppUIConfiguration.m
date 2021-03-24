//
//  DDAccountsUIAppUIConfiguration.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDAccountsUIAppUIConfiguration.h"
#import "DDAccountsUI.h"


@implementation DDAccountsUIAppUIConfiguration
+(void)loadUIConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Accounts_Profile andModuleName:@"DDAccountsUI" withClassRef:DDProfileViewController.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Accounts_Settings andModuleName:@"DDAccountsUI" withClassRef:DDSettingsViewController.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Accounts_Feedback andModuleName:@"DDAccountsUI" withClassRef:FeedbackViewController.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Accounts_My_Account andModuleName:@"DDAccountsUI" withClassRef:DDAccountViewController.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Accounts_Smiles_Detail andModuleName:@"DDAccountsUI" withClassRef:DDSmilesViewController.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Accounts_Savings_Detail andModuleName:@"DDAccountsUI" withClassRef:DDSavingsViewController.class];
}
@end
