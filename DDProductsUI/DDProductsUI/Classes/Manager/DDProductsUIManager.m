//
//  DDProductsUIManager.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 30/01/2020.
//

#import "DDProductsUIManager.h"
#import <DDUI.h>
@implementation DDProductsUIManager
//static DDProductsUIManager *_sharedObject;
//+(DDProductsUIManager *)shared {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedObject = [DDProductsUIManager.alloc init];
//    });
//    return _sharedObject;
//}

+(void)showCompleteLoginOnVC:(UIViewController *)vc onCompletion:(void (^)(BOOL))completion {
    if (DDUserManager.shared.isLoggedIn) {
        completion(YES);
    }else {
        DDUIRouterM *loginVC = [DDUIRouterM.alloc init];
        loginVC.route_link = DD_Nav_Auth_Login;
        loginVC.transition = DDUITransitionPush;
        loginVC.action_identifier = @"show_back";
        loginVC.should_embed_in_nav = YES;
        loginVC.is_animated = YES;
        loginVC.callback = ^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
            [controller dismissViewControllerAnimated:YES completion:nil];
            if (data != nil) {
                [self showCompleteLoginOnVC:vc onCompletion:completion];
            }else {
                completion(NO);
            }
        };
        [DDUIRouterManager.shared navigateTo:@[loginVC] onController:vc];
    }
}
+(void)showProductsPurchsaeHistoryOnVC:(UIViewController *)vc data:(_Nullable id)data onCompletion:(_Nullable ControllerCallBack)completion {
    
    DDUIRouterM *purchaseProductsHistoryVC = [DDUIRouterM.alloc init];
    purchaseProductsHistoryVC.route_link = DD_Nav_DDPurchase_Products_HistoryVC;
    purchaseProductsHistoryVC.transition = DDUITransitionPush;
    purchaseProductsHistoryVC.action_identifier = @"show_back";
    purchaseProductsHistoryVC.should_embed_in_nav = YES;
    purchaseProductsHistoryVC.is_animated = YES;
    purchaseProductsHistoryVC.data = data;
    purchaseProductsHistoryVC.callback = completion;
    [DDUIRouterManager.shared navigateTo:@[purchaseProductsHistoryVC] onController:vc];
}
@end
