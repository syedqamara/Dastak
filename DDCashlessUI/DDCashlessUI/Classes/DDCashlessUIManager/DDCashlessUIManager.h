//
//  DDCashlessUIManager.h
//  DDCashlessUI
//
//  Created by Syed Qamar Abbas on 21/01/2020.
//

#import <UIKit/UIKit.h>
#import "DDModels.h"
#import "DDCashless.h"
#import "DDUI.h"
typedef void(^ _Nullable ControllerCallBack)(NSString * _Nonnull identifier, id _Nonnull data, UIViewController * _Nonnull controller);

NS_ASSUME_NONNULL_BEGIN

@interface DDCashlessUIManager : NSObject
+(DDCashlessUIManager *)shared;

-(void)showCashlessItemCustomization:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showCashlessOutletListingVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showCashlessRemoveItemsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)openMerchantTopMenuOptions:(UIViewController *)controller withTopMenuArray :(DDMerchantDetailM*)merchantData onCompletion: (void (^)(void))completion;
-(void)showCashlessCart:(DDCashlessCart *)cart onController:(UIViewController *)controller controllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showCashlessMerchantDetailVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showCashlessOutletSelectionVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showOrderStatus:(DDOrderStatusRequestM *)screenRequest onController:(UIViewController *)controller andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)openMerchantLockeOffersView:(UIViewController *)controller withLockOffersSectionAndModel:(DDMerchantOffersLocalDataM*)vModel onCompletion: (void (^)(void))completion;
+(void)showHorizontalSelectedFiltersIn:(UIView*)conatiner withDataSource:(id)dataSource crossedAt:(IntCompletionCallBack)callBack;
+(void)openFilterOptionsFrom:(UIViewController*)from withData:(id)data andControllerCallBack:(ControllerCallBack)callBack;
+(void)showDeliveryLocationsVCFrom:(UIViewController*)from withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)callBack;
-(void)showOrderStatusMapViewController:(DDOrderDetailSectionM *)viewModel onController:(UIViewController *)controller andControllerCallBack:(ControllerCallBack)controllerCallBack;
@end

NS_ASSUME_NONNULL_END
