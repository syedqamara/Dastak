//
//  DDBaseAppConfiguration.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDFavouritesUIAppUIConfiguration.h"
#import "DDFavouritesUI.h"
@implementation DDFavouritesUIAppUIConfiguration

+(void)loadUIConfiguration{
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Favourites_Main andModuleName:@"DDFavouritesUI" withClassRef:DDFavouritesViewController.class];
}

@end
