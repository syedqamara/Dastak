//
//  DDHomeUIManager.m
//  DDHomeUI
//
//  Created by Syed Qamar Abbas on 04/02/2020.
//

#import "DDHomeUIManager.h"
#import "DDHomeThemeManager.h"
#import "DDAuth.h"
#import "DDUI.h"
#import "DDLocations.h"
#import <DDConstants/DDConstants.h>


@implementation DDHomeUIManager
static DDHomeUIManager *_sharedObject;
+(DDHomeUIManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [DDHomeUIManager.alloc init];
    });
    return _sharedObject;
}
-(void)showDeliveryLocationsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    if (DDUserManager.shared.isLoggedIn) {
        DDLocationsManager.shared.locationPickerPermission = DDDeliveryLocationPickerPermissionSave;
    }else {
        DDLocationsManager.shared.locationPickerPermission = DDDeliveryLocationPickerPermissionSetButNotSave;
    }
    [self showControllerFrom:controller
                  route_link:DD_Nav_Cashless_Locations
                  transition:DDUITransitionPresentWithPan2
                   animation:YES
         should_embed_in_nav:YES
                        data:data
          controllerCallBack:controllerCallBack];
}
-(void)showC2CLocationsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    DDLocationsManager.shared.locationPickerPermission = DDDeliveryLocationPickerPermissionNotSetNotSave;
    [self showControllerFrom:controller
                  route_link:DD_Nav_Cashless_Locations
                  transition:DDUITransitionPresentWithPan2
                   animation:YES
         should_embed_in_nav:YES
                        data:data
          controllerCallBack:controllerCallBack];
}
-(void)openSearchScreenOnController:(UIViewController *)controller withData:(DDBaseRequestModel *)req {
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Search_Search;
    route.transition = DDUITransitionPresent;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.data = req;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
-(void)openFilterScreenOnController:(UIViewController *)controller withCallback:(ControllerCallBack)callBack {
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Filter_Listing;
    route.transition = DDUITransitionPresentWithPan2;
    route.is_animated = YES;
    route.panDraggableInFullScreen = YES;
    route.should_embed_in_nav = YES;
    route.callback = callBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void)openCustomoization:(UIViewController *)controller withData:(id)data withCallBack:(ControllerCallBack)callBack {
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Cashless_Item_Customization;
    route.transition = DDUITransitionPresent;
    route.is_animated = YES;
    route.panDraggableInFullScreen = YES;
    route.should_embed_in_nav = YES;
    route.data = data;
    route.callback = callBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void)openRemoveCustomoization:(UIViewController *)controller withData:(id)data withCallBack:(ControllerCallBack)callBack {
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Cashless_Remove_Items;
    route.transition = DDUITransitionPresentWithPan2;
    route.is_animated = YES;
    route.panDraggableInFullScreen = YES;
    route.should_embed_in_nav = YES;
    route.data = data;
    route.callback = callBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
-(void)showMobileNumber:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block{
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Auth_Mobile_Number;
    route.transition = DDUITransitionPresent;
    route.is_animated = NO;
    route.should_embed_in_nav = YES;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void)showOrderRating:(UIViewController*)controller withData:(DDRatingRM *)data WithcallBack:(ControllerCallBack _Nullable)block{
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Order_Rating;
    route.transition = DDUITransitionPresent;
    route.is_animated = NO;
    route.should_embed_in_nav = NO;
    route.data = data;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
-(void)proceedInAppAfterAuthentication:(UIViewController *)controller onCompletion: (void (^)(void))completion {
    if (DDCAppConfigManager.shared.isEditConfigAllowed) {
//        DDUserManager.shared.isSkipped = YES;
    }
    [self checkForAuthentication:controller onCompletion:^{
        if (!DDUserManager.shared.currentUser.isPhoneNumberVerified && DDUserManager.shared.isLoggedIn) {
            [self showMobileNumber:controller WithcallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
                if (DDUserManager.shared.currentUser.isPhoneNumberVerified) {
                    completion();
                }
            }];
        }
        else {
            completion();
        }
    }];
}
-(void)checkForAuthentication:(UIViewController *)controller onCompletion: (void (^)(void))completion {
    if (DDUserManager.shared.shouldProceedInApp) {
        completion();
    }else {
        DDUIRouterM *route = [DDUIRouterM.alloc init];
        route.route_link = DD_Nav_Auth_Welcome;
        route.transition = DDUITransitionPresent;
        route.is_animated = NO;
        route.should_embed_in_nav = YES;
        route.callback = ^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull cont) {
            completion();
        };
        [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
    }
}

-(void)openLoginVC:(UIViewController *)controller onCompletion: (void (^)(void))completion{
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Auth_Options;
    route.transition = DDUITransitionPresentWithPan2;
    route.is_animated = YES;
    route.panDraggableInFullScreen = NO;
    route.panModelHeight = 429;
    route.disableUpwardPan = YES;
    route.should_embed_in_nav = YES;
    route.callback = ^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        if (completion != nil) {
            completion();
        }
    };
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
-(void)checkForLocationPermission:(UIViewController *)controller onCompletion: (void (^)(void))completion {
    if (!DDLocationsManager.shared.shouldAskPermission) {
        completion();
    }else {
        DDUIRouterM *route = [DDUIRouterM.alloc init];
        route.route_link = DD_Nav_Locations_Permission;
        route.transition = DDUITransitionPresent;
        route.is_animated = YES;
        route.should_embed_in_nav = NO;
        route.callback = ^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
            [controller dismissViewControllerAnimated:YES completion:nil];
            completion();
        };
        [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
    }
}

-(void)showOutletsListingOn:(UIViewController*)controller withReqModel:(DDBaseRequestModel*)reqM andControllerCallBack:(ControllerCallBack)controllerCallBack {
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.data = reqM;
    route.route_link = DD_Nav_Outlets_Listing;
    route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
-(void)showMerchantDetail:(UIViewController*)controller withReqModel:(DDBaseRequestModel*)reqM andControllerCallBack:(ControllerCallBack)controllerCallBack {
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.data = reqM;
    route.route_link = DD_Nav_Cashless_Merchant_Detail;
    route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
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
    if ([route_link isEqualToString:DD_Nav_Cashless_Locations]){
        route.panDraggableInFullScreen = YES;
    }else {
        route.disableUpwardPan = YES;
    }
    if (data) route.data = data;
    if (controllerCallBack) route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];

}
-(void)showSettingsOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block {
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Accounts_Settings;
    route.transition = DDUITransitionPresent;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
-(void)showChangeEmailOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block {
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Auth_Change_Email;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = NO;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void)showMerchantInfoRatingOnController:(UIViewController*)controller withData:(id)data withcallBack:(ControllerCallBack _Nullable)block {
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Cashless_Merchant_Info_Container;
    route.transition = DDUITransitionPresentWithPan2;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.data = data;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

-(void)showChangePasswordOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block {
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Auth_Change_Password;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = NO;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
-(void)showOrderStatus:(UIViewController*)controller withData:(id)data WithcallBack:(ControllerCallBack _Nullable)block {
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_Cashless_Order_Status;
    route.transition = DDUITransitionPresent;
    route.is_animated = YES;
    route.data = data;
    route.should_embed_in_nav = YES;
    route.callback = block;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}
-(void)showMenu:(UIViewController*)controller withMenu:(NSArray <DDMerchantDeliveryMenuM *> *)menus withcallBack:(ControllerCallBack _Nullable)block{
    DDPopupVM *popup = [DDPopupVM new];
    popup.title = @"Menu Categories".localized;
    popup.search_placeholder = @"Search Menu".localized;
    for (DDMerchantDeliveryMenuM *menu in menus) {
        DDPopupOptionVM *option = [DDPopupOptionVM new];
        option.titleLabelLeft = menu.name;
        option.titleLabelColorNormalLeft = HOME_THEME.text_black_40.colorValue;
        option.titleLabelColorSelectedLeft = HOME_THEME.text_black_40.colorValue;
        option.titleFontNormalLeft = [UIFont DDRegularFont:15];
        option.titleFontSelectedLeft = [UIFont DDRegularFont:15];
        option.object = menu;
        [popup.options addObject:option];
    }
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_UI_Popup_Option;
    route.transition = DDUITransitionPresentWithPan2;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.panDraggableInFullScreen = YES;
    route.panModelHeight = popup.panHeight;
//    route.callback = block;
    route.data = popup;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
    route.callback = ^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:YES completion:nil];
        if (block != nil && data != nil) {
            block(identifier, data, controller);
        }
    };
}

-(void)showPaymentMethod:(UIViewController*)controller withSelectedMethod:(DDPaymentMethod *)selectedMethod withcallBack:(ControllerCallBack _Nullable)block{
    DDPopupVM *popup = [DDPopupVM new];
    popup.title = @"Select payment method".localized;
    for (DDPaymentMethod *opt in DDAuthManager.shared.config.data.c_2_c_payment_method) {
        DDPopupOptionVM *option = [DDPopupOptionVM new];
        option.titleLabelLeft = opt.title;
        option.titleLabelColorNormalLeft = HOME_THEME.text_black_40.colorValue;
        option.titleLabelColorSelectedLeft = HOME_THEME.text_black_40.colorValue;
        option.titleFontNormalLeft = [UIFont DDRegularFont:15];
        option.titleFontSelectedLeft = [UIFont DDBoldFont:15];
        option.leftImageNormal = opt.image_url;
        option.leftImageSelected = option.leftImageNormal;
        option.object = opt;
        option.isSelected = [opt.identifier isEqualToString:selectedMethod.identifier];
        [popup.options addObject:option];
    }
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_UI_Popup_Option;
    route.transition = DDUITransitionPresentWithPan2;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.panDraggableInFullScreen = YES;
    route.panModelHeight = popup.panHeight;
//    route.callback = block;
    route.data = popup;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
    route.callback = ^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:YES completion:nil];
        if (block != nil) {
            block(identifier, data, controller);
        }
    };
}
-(void)showGoodsType:(UIViewController*)controller withSelected:(DDParcelInfoRM *)selected withcallBack:(ControllerCallBack _Nullable)block{
    DDPopupVM *popup = [DDPopupVM new];
    popup.title = @"What are you sending?".localized;
    for (DDHomeSectionListM *cat in self.categories) {
        DDPopupOptionVM *option = [DDPopupOptionVM new];
        option.titleLabelLeft = cat.title;
        option.titleLabelColorNormalLeft = HOME_THEME.text_black_40.colorValue;
        option.titleLabelColorSelectedLeft = HOME_THEME.text_black_40.colorValue;
        option.titleFontNormalLeft = [UIFont DDRegularFont:15];
        option.titleFontSelectedLeft = [UIFont DDRegularFont:15];
        option.object = cat;
        option.isSelected = [cat.title isEqualToString:selected.category_title];
        [popup.options addObject:option];
    }
    
    DDPopupOptionVM *option = [DDPopupOptionVM new];
    option.titleLabelLeft = @"Add specific description".localized;
    option.titleLabelColorNormalLeft = HOME_THEME.app_theme.colorValue;
    option.titleLabelColorSelectedLeft = HOME_THEME.app_theme.colorValue;
    option.titleFontNormalLeft = [UIFont DDRegularFont:15];
    option.titleFontSelectedLeft = [UIFont DDRegularFont:15];
    option.leftImageNormal = @"icContentAdd.png";
    [popup.options addObject:option];
    
    
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_UI_Popup_Option;
    route.transition = DDUITransitionPresentWithPan2;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.panDraggableInFullScreen = YES;
    route.panModelHeight = popup.panHeight;
//    route.callback = block;
    route.data = popup;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
    route.callback = ^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        if (block != nil) {
            block(identifier, data, controller);
        }
        [controller dismissViewControllerAnimated:YES completion:nil];
    };
}
-(void)showForm:(DDFormCollectionM *)form onController:(UIViewController *)controller controllerCallBack:(ControllerCallBack)controllerCallBack {
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = DD_Nav_UI_Popup_Form;
    route.transition = DDUITransitionPresentWithPan2;
    route.is_animated = YES;
    route.should_embed_in_nav = YES;
    route.panDraggableInFullScreen = YES;
    route.data = form;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
    route.callback = ^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:YES completion:nil];
        if (controllerCallBack != nil) {
            controllerCallBack(identifier, data, controller);
        }
    };
}
-(void)showCashlessCart:(DDBaseRequestModel *)cart onController:(UIViewController *)controller controllerCallBack:(ControllerCallBack)controllerCallBack {
    DDUIWebViewVM *web = [DDUIWebViewVM new];
    web.is_animated = NO;
    web.params = cart.toDictionary.mutableCopy;
    web.title = @"Checkout".localized;
    web.webType = DDUIWebViewTypeCashlessCart;
    web.webCompletion = ^(NSMutableDictionary * _Nullable params, UIViewController * _Nullable controller) {
        controllerCallBack(@"",params,controller);
    };
    [DDWebManager.shared openWeb:web onController:controller];
}
-(void)showC2CCart:(DDBaseRequestModel *)cart onController:(UIViewController *)controller controllerCallBack:(ControllerCallBack)controllerCallBack {
    DDUIWebViewVM *web = [DDUIWebViewVM new];
    web.url = DDCAppConfigManager.shared.api_config.C2C_CART_URL;
    web.is_animated = NO;
    web.params = cart.toDictionary.mutableCopy;
    web.title = @"Checkout".localized;
    web.webType = DDUIWebViewTypeCashlessCart;
    web.webCompletion = ^(NSMutableDictionary * _Nullable params, UIViewController * _Nullable controller) {
        controllerCallBack(@"",params,controller);
    };
    [DDWebManager.shared openWeb:web onController:controller];
}


@end
