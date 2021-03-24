//
//  DDMapsUIManager.m
//  DDMapsUI
//
//  Created by Zubair Ahmad on 06/02/2020.
//

#import "DDMapsUIManager.h"

@implementation DDMapsUIManager


static DDMapsUIManager *_sharedObject;

+(DDMapsUIManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [DDMapsUIManager.alloc init];
    });
    return _sharedObject;
}

-(void)showOutletsListingFrom:(UIViewController*)controller withReqModel:(DDBaseRequestModel*)reqM andControllerCallBack:(ControllerCallBack)controllerCallBack
{
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.data = reqM;
    route.route_link = DD_Nav_Outlets_Listing;
    route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void)showMerchantDetailsFrom:(UIViewController*)controller withOutlet:(id)outlet andControllerCallBack:(ControllerCallBack)controllerCallBack {
    DDBaseRequestModel *model = [[DDBaseRequestModel alloc] init];
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = DD_Nav_Outlets_Detail;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.data = model;
    route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
@end
