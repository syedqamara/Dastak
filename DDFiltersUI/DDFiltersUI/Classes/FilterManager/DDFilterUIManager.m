//
//  DDFilterUIManager.m
//  DDFiltersUI
//
//  Created by Umair on 27/02/2020.
//

#import "DDFilterUIManager.h"

@implementation DDFilterUIManager

static DDFilterUIManager *_sharedObject;
+(DDFilterUIManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [DDFilterUIManager.alloc init];
    });
    return _sharedObject;
}

-(void)showFilterOptionsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    
    [self showControllerFrom:controller
                  route_link:DD_Nav_Filter_Options
                  transition:DDUITransitionPresent
                   animation:YES
                        data:data
          controllerCallBack:controllerCallBack];
}

-(void)showControllerFrom:(UIViewController*)controller
               route_link:(NSString* _Nonnull)route_link
               transition:(DDUITransition)transition
                animation:(BOOL)animation
                     data:(id _Nullable)data
       controllerCallBack:(ControllerCallBack)controllerCallBack {
    
//    if(!DDUserManager.shared.isLoggedIn) {
//        NSLog(@"User must be logged in before family accessing.");
//        //return;
//    }
    
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = route_link;
    route.transition = transition;
    route.is_animated = animation;
    if (data) route.data = data;
    if (controllerCallBack) route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];

}

@end
