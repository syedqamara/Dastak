//
//  DDBaseAppConfiguration.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDEditConfigAppUIConfiguration.h"
#import "DDEditConfigVC.h"
#import "DDApiBreakPointVC.h"
#import "DDChooseEditOptionVC.h"
#import "DDJSONViewController.h"
#import "DDAPIConfigVC.h"
@implementation DDEditConfigAppUIConfiguration

+(void)loadUIConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_App_Edit_Configuration andModuleName:@"DDEditConfig" withClassRef:DDEditConfigVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_App_Edit_Options andModuleName:@"DDEditConfig" withClassRef:DDChooseEditOptionVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_App_Edit_Break_Points andModuleName:@"DDEditConfig" withClassRef:DDApiBreakPointVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_App_Edit_JSON andModuleName:@"DDEditConfig" withClassRef:DDJSONViewController.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_App_Edit_Api_Config andModuleName:@"DDEditConfig" withClassRef:DDAPIConfigVC.class];
    
}
@end
