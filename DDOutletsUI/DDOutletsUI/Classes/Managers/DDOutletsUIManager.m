//
//  DDOutletsUIManager.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 06/02/2020.
//

#import "DDOutletsUIManager.h"
#import "DDAuth.h"

@implementation DDOutletsUIManager


static DDOutletsUIManager *_sharedObject;

+(DDOutletsUIManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [DDOutletsUIManager.alloc init];
    });
    return _sharedObject;
}

-(void)showMerchantDetailsFrom:(UIViewController*)controller withOutlet:(DDOutletM*)outlet andControllerCallBack:(ControllerCallBack)controllerCallBack
{
    DDMerchantDetailRequestM *model = [[DDMerchantDetailRequestM alloc] init];
    [model getReqParams];
    model.outlet_id = outlet.outlet_id;
    model.merchant_id = outlet.merchant.merchant_id;
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = DD_Nav_Outlets_Detail;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.data = model;
    route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void)showSearchScreenFrom:(UIViewController*)controller withControllerCallBack:(ControllerCallBack)controllerCallBack {
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Search_Search;
    route.transition = DDUITransitionPresent;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void)openFiltersWithFilters:(DDFiltersScreenRequestM *)filters onController:(UIViewController *)controller onCompletion:(ControllerCallBack)completion {
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Filter_Listing;
    route.transition = DDUITransitionPresent;
    route.is_animated = YES;
    route.data = filters;
    route.should_embed_in_nav = NO;
    route.callback = completion;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
-(void)openAmenitiesDetail:(UIViewController *)controller withAmenitiesArray :(NSArray*)amenitiesArray onCompletion: (void (^)(void))completion {
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Outlets_Detail_Amenities;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.data = amenitiesArray;
    route.callback = ^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:YES completion:nil];
        completion();
    };
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void)openMerchantTopMenuOptions:(UIViewController *)controller withMerchnatData :(DDMerchantDetailM*)merchantData onCompletion: (void (^)(void))completion {
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Outlets_Detail_TopMENU;
    route.transition = DDUITransitionPresentWithPan2;
    route.panModelHeight  =  250;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.data = merchantData;
    route.panDraggableInFullScreen = YES;
    route.callback = ^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:YES completion:nil];
        completion();
    };
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void)openMerchantOnMap:(UIViewController *)controller withSelectedOutlet :(DDMerchantOffersLocalDataM*)selectedOutlet onCompletion: (void (^)(void))completion {
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Outlets_Detail_Map;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.data = selectedOutlet;
    route.callback = ^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:YES completion:nil];
        completion();
    };
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void)openMerchantOutlets:(UIViewController *)controller withViewModel:(DDMerchantOutletLocationViewM*) viewModel onCompletion:(ControllerCallBack)completion {
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Outlets_Locations_List;
    route.transition = DDUITransitionPresentWithPan2;
    route.panModelHeight  =  455;
    route.panDraggableInFullScreen = YES;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.data = viewModel;
    route.callback = completion;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void)openMerchantLockeOffersView:(UIViewController *)controller withLockOffersSectionAndModel:(DDMerchantOffersLocalDataM*)vModel onCompletion: (void (^)(void))completion {
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Outlets_Locked_Offers;
    route.transition = DDUITransitionPresent;
    route.is_animated = YES;
    route.should_embed_in_nav = NO;
    route.data = vModel;
    route.callback = ^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:YES completion:nil];
        completion();
    };
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void)openMerchantBaseOnlineOffersHistory:(UIViewController *)controller withLockOffersSectionAndModel:(NSString*)merchantID onCompletion: (void (^)(void))completion {
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Outlets_Online_Offers_History;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.data = merchantID;
    route.callback = ^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:YES completion:nil];
        completion();
    };
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void) openRedemptionVCFrom:(UIViewController*)controller withOfferViewModel : (DDMerchantOffersLocalDataM*) viewModel andControllerCallBack:(ControllerCallBack)controllerCallBack {
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Redemption_Redemption;
    route.transition = DDUITransitionPresent;
    route.is_animated = YES;
    route.should_embed_in_nav = NO;
    route.data = viewModel;
    route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void) openPingShareVCFrom:(UIViewController*)controller withOfferViewModel : (DDMerchantOffersLocalDataM*) viewModel andControllerCallBack:(ControllerCallBack)controllerCallBack {
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Pings_Share;
    route.transition = DDUITransitionPresentWithPan2;
    route.panModelHeight = 500;
    route.panDraggableInFullScreen = YES;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.data = viewModel;
    route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(DDEmptyViewModel*)checkAndGetEmptyViewModelForOnlineOfferHistory:(DDBaseHistoryAPIModel* _Nullable)apiData {
    DDEmptyViewModel *emptyVM = [DDEmptyViewModel new];;
    
    if (apiData.message.length > 0) {
        emptyVM.title = @"You have not make any promo code(s) yet.".localized;
        emptyVM.sub_title = @"Your promo codes will appear here as soon as you make them.".localized;
        emptyVM.image = @"noBookingsPromo.png";
    }else {
    }
    return emptyVM;
}

-(DDEmptyViewModel*)getEmptyViewModelForOutletsListing {
    DDEmptyViewModel *emptyVM = [DDEmptyViewModel new];;
    
    emptyVM.title = @"There aren't any available merchants".localized;
    emptyVM.image = @"noBookingsPromo.png";
    return emptyVM;
}

-(void)showCashlessMerchantDetailsFrom:(UIViewController*)controller withOutlet:(DDCashlessRequestM*)model andControllerCallBack:(ControllerCallBack)controllerCallBack {
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = DD_Nav_Cashless_Merchant_Detail;
    route.transition = DDUITransitionPush;
    route.should_embed_in_nav = YES;
    route.is_animated = YES;
    route.data = model;
    if (controllerCallBack) route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void)showDemographicsOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)completion {
    DDUIRouterM *route = [DDUIRouterM new];
    route.route_link = DD_Nav_Auth_Demographics;
    route.transition = DDUITransitionPresent;
    route.callback = completion;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

@end
