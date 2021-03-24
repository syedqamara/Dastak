//
//  DDOutletsUIManager.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 06/02/2020.
//

#import "DDFavouritesUIManager.h"

@implementation DDFavouritesUIManager


static DDFavouritesUIManager *_sharedObject;

+(DDFavouritesUIManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [DDFavouritesUIManager.alloc init];
    });
    return _sharedObject;
}

-(void)showMerchantDetailsFrom:(UIViewController*)controller withModel:(DDMerchantDetailRequestM*)model andControllerCallBack:(ControllerCallBack)controllerCallBack {
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = DD_Nav_Outlets_Detail;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.data = model;
    route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(DDEmptyViewModel*)getEmptyViewModelForNoFavData{
    DDEmptyViewModel *emptyVM = [DDEmptyViewModel new];;
    emptyVM.title = @"You have not set any favourites yet.".localized;
    emptyVM.image = @"noBookingsPromo.png";
    return emptyVM;
}

@end
