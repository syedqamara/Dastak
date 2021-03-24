//
//  DDDeeplinkConfig.m
//  dynamicdelivery_Example
//
//  Created by Syed Qamar Abbas on 29/01/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import "DDDeeplinkConfig.h"
#import <DDUI/DDUI.h>
#import "DDDeepLinkUtils.h"
#import "DDTabbarController.h"

@interface DDDeeplinkConfig ()

@end

@implementation DDDeeplinkConfig
+(void)configureDeeplinkToRouteLinkTranslator {
    NSMutableDictionary <NSString *,NSArray <DDUIRouterM *>*> *deeplinks = [[NSMutableDictionary alloc]init];
    deeplinks[ALLOFFERS_SCHEME] = [self youtubeRoute];
    DDDeepLinkUtils.sharedInstance.configurations = deeplinks;
}


+(NSArray <DDUIRouterM *>*)youtubeRoute {
    DDUIRouterM *r1 = [[DDUIRouterM alloc]init];
    r1.route_link = DD_Nav_UI_Youtube_Player;
    r1.transition = DDUITransitionPresent;
    r1.is_animated = YES;
    r1.should_embed_in_nav = NO;
    return @[r1];
}

@end
