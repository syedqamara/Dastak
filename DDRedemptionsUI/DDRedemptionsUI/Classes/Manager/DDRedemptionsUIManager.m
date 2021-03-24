//
//  DDRedemptionsUIManager.m
//  DDRedemptionsUI
//
//  Created by Hafiz Aziz on 12/02/2020.
//

#import "DDRedemptionsUIManager.h"
#import "DDUI.h"

@implementation DDRedemptionsUIManager

static DDRedemptionsUIManager *_sharedObj;

+(DDRedemptionsUIManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObj = [[DDRedemptionsUIManager alloc] init];
    });
    return _sharedObj;
}

-(void)goToAnotherViewController:(UIViewController *)controller routeLink :(NSString*)routeLink onCompletion:(void (^)(void))completion{
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = routeLink;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.callback = ^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:YES completion:nil];
        completion();
    };
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void) openRedemptionCompletedVCFrom:(UIViewController*)controller withOfferViewModel : (DDMerchantOffersLocalDataM*) viewModel andControllerCallBack:(ControllerCallBack)controllerCallBack {
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Redemption_Completed;
    route.transition = DDUITransitionPresent;
    route.is_animated = NO;
    route.should_embed_in_nav = NO;
    route.data = viewModel;
    route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

@end
