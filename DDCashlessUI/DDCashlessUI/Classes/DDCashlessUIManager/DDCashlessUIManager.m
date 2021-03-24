//
//  DDCashlessUIManager.m
//  DDCashlessUI
//
//  Created by Syed Qamar Abbas on 21/01/2020.
//

#import "DDCashlessUIManager.h"
#import "DDCashlessBaseVC.h"

@interface DDCashlessUIManager () {
    BOOL isFabDisplaying;
}

@end


@implementation DDCashlessUIManager
static DDCashlessUIManager * _sharedObject;
+(DDCashlessUIManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDCashlessUIManager alloc]init];
    });
    return _sharedObject;
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
-(void)openMerchantTopMenuOptions:(UIViewController *)controller withTopMenuArray :(DDMerchantDetailM*)merchantData onCompletion: (void (^)(void))completion {
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

+(void)showHorizontalSelectedFiltersIn:(UIView*)conatiner withDataSource:(id)dataSource crossedAt:(IntCompletionCallBack)callBack {
    
}

+(void)showDeliveryLocationsVCFrom:(UIViewController*)from withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)callBack {
    DDUIRouterM *route = [[DDUIRouterM alloc] init];
    route.route_link = DD_Nav_Cashless_Locations;
    route.transition = DDUITransitionPresentWithPan2;
    route.should_embed_in_nav = YES;
    route.is_animated = YES;
    route.data = data;
    route.callback = callBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:from];
}

+(void)openFilterOptionsFrom:(UIViewController *)from withData:(id)data andControllerCallBack:(ControllerCallBack)callBack {
    DDUIRouterM *route = [[DDUIRouterM alloc] init];
    route.route_link = DD_Nav_Filter_Options;
    route.transition = DDUITransitionPresent;
    route.should_embed_in_nav = NO;
    route.is_animated = YES;
    route.data = data;
    route.callback = callBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:from];
}

-(void)showCashlessItemCustomization:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    [self showControllerFrom:controller
                  route_link:DD_Nav_Cashless_Item_Customization
                  transition:(DDUITransitionPresent)
                   animation:YES
         should_embed_in_nav:NO
                        data:data
          controllerCallBack:controllerCallBack];
}


-(void)showCashlessOutletSelectionVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = DD_Nav_Cashless_Outlet_Selection;
    route.transition = DDUITransitionPresentWithPan2;
    route.should_embed_in_nav = YES;
    route.is_animated = YES;
    route.data = data;
    route.panDraggableInFullScreen = YES;
    route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}


-(void)showCashlessMerchantDetailVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    [self showControllerFrom:controller
                  route_link:DD_Nav_Cashless_Merchant_Detail
                  transition:(DDUITransitionPush)
                   animation:YES
         should_embed_in_nav:NO
                        data:data
          controllerCallBack:controllerCallBack];
}

-(void)showCashlessOutletListingVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    [self showControllerFrom:controller
                  route_link:DD_Nav_Cashless_Outlet_Listing_Continer
                  transition:DDUITransitionPush
                   animation:YES
         should_embed_in_nav:NO
                        data:data
          controllerCallBack:controllerCallBack];
}

-(void)showCashlessRemoveItemsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    [self showControllerFrom:controller
                  route_link:DD_Nav_Cashless_Remove_Items
                  transition:DDUITransitionPresent
                   animation:YES
         should_embed_in_nav:YES
                        data:data
          controllerCallBack:controllerCallBack];

}

-(void)showCashlessCart:(DDCashlessCart *)cart onController:(UIViewController *)controller controllerCallBack:(ControllerCallBack)controllerCallBack {
    DDUIWebViewVM *web = [DDUIWebViewVM new];
    web.is_animated = NO;
    web.params = cart.toDictionary.mutableCopy;
    web.title = CASHLESS_CART_SCREEN_TITLE.localized;
    web.webType = DDUIWebViewTypeCashlessCart;
    web.webCompletion = ^(NSMutableDictionary * _Nullable params, UIViewController * _Nullable controller) {
        controllerCallBack(@"",params,controller);
    };
    [DDWebManager.shared openWeb:web onController:controller];
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
    if (data) route.data = data;
    if (controllerCallBack) route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];

}
-(void)showOrderStatus:(DDOrderStatusRequestM *)screenRequest onController:(UIViewController *)controller andControllerCallBack:(ControllerCallBack)controllerCallBack {
    [self showControllerFrom:controller
                  route_link:DD_Nav_Cashless_Order_Status
                  transition:(DDUITransitionPresent)
                   animation:NO
         should_embed_in_nav:YES
                        data:screenRequest
          controllerCallBack:controllerCallBack];
}

-(void)showOrderStatusMapViewController:(DDOrderDetailSectionM *)viewModel onController:(UIViewController *)controller andControllerCallBack:(ControllerCallBack)controllerCallBack {
    [self showControllerFrom:controller
                  route_link:DD_Nav_Cashless_Order_Status_Map
                  transition:(DDUITransitionPresent)
                   animation:NO
         should_embed_in_nav:YES
                        data:viewModel
          controllerCallBack:controllerCallBack];
}

@end
