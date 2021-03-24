//
//  DDWebManager.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 23/01/2020.
//

#import "DDWebManager.h"
#import "NSString+DDString.h"
#import "DDUIRouterM.h"
#import "DDUIRouterManager.h"
#import "DDConstants.h"
#import "Branch.h"

#define IS_EXTERNAL_WEB @"is_external"

@implementation DDWebManager
static DDWebManager *_sharedObject;
+(DDWebManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDWebManager alloc]init];
    });
    return _sharedObject;
}
-(void)openURL:(NSString *)url title:(NSString*)title shouldRefreshApp:(BOOL)shouldRefresh onController:(UIViewController *)controller __attribute__((deprecated("Please use openURL:title:onController")));{
    BOOL isExternal = url.isDeeplink;
    if ([url.params.allKeys containsObject:IS_EXTERNAL_WEB]) {
        NSString *temp = url.params[IS_EXTERNAL_WEB];
        if ([temp.lowercaseString isEqualToString:@"true"]) {
            isExternal = YES;
        }
        else if ([temp.lowercaseString isEqualToString:@"1"]) {
            isExternal = YES;
        }
    }
    if (isExternal) {
        NSURL *urlObj = url.urlValue;
        if ([url containsString:@"http"]) {
            urlObj = url.urlValue;
        }
        if (shouldRefresh) {
            urlObj = url.requireRefreshGlobally.urlValue;
        }else {
            urlObj = url.noRequireRefreshGlobally.urlValue;
        }
        [UIApplication.sharedApplication openURL:urlObj options:@{} completionHandler:nil];
    }else {
        [self openGeneralWeb: title ?: @"Web" andURL:url onController:controller onURLChange:nil onComplete:nil onClose:nil];
    }
}
-(void)openURL:(NSString *)url title:(NSString*)title onController:(UIViewController *)controller {
    BOOL isExternal = url.isDeeplink;
    if ([url.params.allKeys containsObject:IS_EXTERNAL_WEB]) {
        NSString *temp = url.params[IS_EXTERNAL_WEB];
        if ([temp.lowercaseString isEqualToString:@"true"]) {
            isExternal = YES;
        }
        else if ([temp.lowercaseString isEqualToString:@"1"]) {
            isExternal = YES;
        }
    }
    if (isExternal) {
        NSURL *urlObj = url.urlValue;
        [UIApplication.sharedApplication openURL:urlObj options:@{} completionHandler:nil];
    }else {
        [self openGeneralWeb: title ?: @"Web" andURL:url onController:controller onURLChange:nil onComplete:nil onClose:nil];
    }
}
-(void)openGeneralWeb:(NSString *)screenTitle andURL:(NSString *)webUrl onController:(UIViewController *)controller onURLChange:(WebControllerURLChange)urlChange onComplete:(WebControllerCompletion)completion onClose:(WebControllerClose)close {
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = DD_Nav_UI_Web_View_General;
    route.transition = DDUITransitionPresent;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;

    DDUIWebViewVM *webViewModel = [[DDUIWebViewVM alloc] init];
    webViewModel.title = screenTitle;
    webViewModel.webNavType = DDTRNavWithWhiteBG;
    webViewModel.webCompletion = completion;
    webViewModel.urlChange = urlChange;
    
    webViewModel.webViewCloseCompletion = close;
    webViewModel.request = [NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]];
    route.data = webViewModel;
    
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
-(void)openWeb:(DDUIWebViewVM *)webModel onController:(UIViewController *)controller {
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = [self routeLinkForType:webModel.webType];
    if (route.route_link.length == 0) {
        NSAssert1(false, @"DDWebManager", @"No Route Is Registered For This Web Type");
        return;
    }
    route.transition = DDUITransitionPresent;
    route.is_animated = webModel.is_animated;
    route.should_embed_in_nav = YES;
    
    route.data = webModel;
    route.callback = ^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        webModel.webCompletion(data, controller);
    };
    
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
-(NSString *)routeLinkForType:(DDUIWebViewType)type {
    NSString *routeLink = @"";
    switch (type) {
        case DDUIWebViewTypeGeneral: {
            routeLink = DD_Nav_UI_Web_View_General;
            break;
        }
        case DDUIWebViewTypeProductCart: {
            routeLink = DD_Nav_UI_Web_View_Product;
            break;
        }
        case DDUIWebViewTypeCashlessCart: {
            routeLink = DD_Nav_Cashless_Cart_Web;
            break;
        }
        case DDUIWebViewTypeBookATable: {
            routeLink = DD_Nav_Outlets_Book_A_Table_Web;
            break;
        }
        case DDUIWebViewTypeCinema: {
            routeLink = DD_Nav_Outlets_Cinema_Web;
            break;
        }
        default:
            break;
    }
    return routeLink;
}

@end
