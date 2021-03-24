//
//  DDBaseAppConfiguration.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDRedemptionsUIAppUIConfiguration.h"
#import "DDRedemptionsUI.h"
@implementation DDRedemptionsUIAppUIConfiguration
//DDUIRouterConfigurationM configureWithRouteName
+(void)loadUIConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Redemption_History andModuleName:@"" withClassRef:DDRedemptionHistoryVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Redemption_Redemption andModuleName:@"" withClassRef:DDRedemptionViewController.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Reservation_History andModuleName:@"" withClassRef:DDReservationHistoryVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Redemption_Completed andModuleName:@"" withClassRef:DDRedemptionCompletedVC.class];
}

@end
