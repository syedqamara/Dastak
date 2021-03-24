//
//  DDBaseAppConfiguration.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDPingsUIAppUIConfiguration.h"
#import "DDPingsUI.h"
@implementation DDPingsUIAppUIConfiguration
//DDUIRouterConfigurationM configureWithRouteName
+(void)loadUIConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Pings_Share andModuleName:@"" withClassRef:DDSharePingsVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Pings_History andModuleName:@"" withClassRef:DDPingsHistoryVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Pings_Leaderboard andModuleName:@"" withClassRef:DDSharePingsLeaderboardVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Pings_LB_FRIENDS andModuleName:@"" withClassRef:DDSharePingsFriendsVC.class];
    
}

@end
