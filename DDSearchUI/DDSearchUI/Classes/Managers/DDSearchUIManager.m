//
//  DDSearchUIManager.m
//  DDSearchUI
//
//  Created by Syed Qamar Abbas on 10/02/2020.
//

#import "DDSearchUIManager.h"

@implementation DDSearchUIManager

+(void)openSearchScreenOnController:(UIViewController *)controller {
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Search_Search;
    route.transition = DDUITransitionPresent;
    route.is_animated = NO;
    route.should_embed_in_nav = YES;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
+(DDEmptyViewModel*)deeplinkSearchEmptyViewSearchText:(NSString *)searchText {
    DDEmptyViewModel *emptyVM = [DDEmptyViewModel new];;
    [emptyVM setDefaultTextAlignment:NSTextAlignmentCenter];
    emptyVM.title = @"Uh Oh!".localized;
    NSString *messagge = @"No results found for %@.\nPlease try changing your search criteria.".localized;
    emptyVM.sub_title = [messagge stringByReplacingOccurrencesOfString:@"%@" withString:searchText];
    emptyVM.image = @"icNoResultsFound.png";
    return emptyVM;
}
@end
