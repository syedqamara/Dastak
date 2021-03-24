//
//  DDBaseAppConfiguration.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDBaseAppUIConfiguration.h"
#import <DDUI.h>
#import "DDPopupOptionTVC.h"
#import "DDFormViewController.h"

@implementation DDBaseAppUIConfiguration
+(void)loadUIConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Dragable_View andModuleName:@"" withClassRef:DDDraggableVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_UI_Web_View_General andModuleName:@"" withClassRef:DDUIWebViewController.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_UI_Popup_Option andModuleName:@"" withClassRef:DDPopupOptionVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_UI_Popup_Form andModuleName:@"" withClassRef:DDFormViewController.class];
    
    
}

@end
