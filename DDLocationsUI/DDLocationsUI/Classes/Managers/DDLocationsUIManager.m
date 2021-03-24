//
//  DDLocationsUIManager.m
//  DDLocationsUI
//
//  Created by Zubair Ahmad on 06/02/2020.
//

#import "DDLocationsUIManager.h"

@implementation DDLocationsUIManager

static DDLocationsUIManager *_sharedObject;
+(DDLocationsUIManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [DDLocationsUIManager.alloc init];
    });
    return _sharedObject;
}



-(void)showDeliveryLocationsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    [self showControllerFrom:controller
                  route_link:DD_Nav_Cashless_Locations
                  transition:DDUITransitionPresentWithPan2
                   animation:YES
         should_embed_in_nav:YES
                        data:data
          controllerCallBack:controllerCallBack];
}

-(void)showAddNewLocationsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    [self showControllerFrom:controller
                  route_link:DD_Nav_Cashless_Add_New_Location
                  transition:DDUITransitionPush
                   animation:YES
         should_embed_in_nav:YES
                        data:data
          controllerCallBack:controllerCallBack];
}

-(void)showSearchLocationsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    [self showControllerFrom:controller
                  route_link:DD_Nav_Cashless_Search_Location
                  transition:DDUITransitionPresent
                   animation:YES
         should_embed_in_nav:NO
                        data:data
          controllerCallBack:controllerCallBack];
}

-(void)showCashlessLocationDetailsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    [self showControllerFrom:controller
                  route_link:DD_Nav_Cashless_Location_Details
                  transition:DDUITransitionPresentWithPan2
                   animation:YES
         should_embed_in_nav:YES
                        data:data
          controllerCallBack:controllerCallBack];
}

-(void)showAppLocationsVCFrom:(UIViewController*)controller withData:(id _Nullable)data
        andControllerCallBack:(ControllerCallBack)controllerCallBack {
    [self showControllerFrom:controller
                  route_link:DD_Nav_App_Location
                  transition:DDUITransitionPresentWithPan2
                   animation:YES
         should_embed_in_nav:YES
                        data:data
          controllerCallBack:controllerCallBack];
}


-(void)showControllerFrom:(UIViewController*)controller
               route_link:(NSString* _Nonnull)route_link
               transition:(DDUITransition)transition
                animation:(BOOL)animation
      should_embed_in_nav:(BOOL)should_embed_in_nav
                     data:(id _Nullable)data
       controllerCallBack:(ControllerCallBack)controllerCallBack {
    
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = route_link;
    route.transition = transition;
    route.should_embed_in_nav = should_embed_in_nav;
    route.is_animated = animation;
    if ([route_link isEqualToString:DD_Nav_App_Location]){
        route.panDraggableInFullScreen = YES;
    }else {
        route.disableUpwardPan = YES;
    }
    if (data) route.data = data;
    if (controllerCallBack) route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];

}
  

@end
