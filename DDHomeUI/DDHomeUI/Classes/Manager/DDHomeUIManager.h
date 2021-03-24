//
//  DDHomeUIManager.h
//  DDHomeUI
//
//  Created by Syed Qamar Abbas on 04/02/2020.
//

#import <Foundation/Foundation.h>
#import <DDModels/DDModels.h>
#import "DDHomeThemeManager.h"
#import "DDHomeManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDHomeUIManager : NSObject
+(DDHomeUIManager *)shared;
@property (strong, nonatomic) NSArray <DDHomeSectionListM *> *categories;
-(void)showGoodsType:(UIViewController*)controller withSelected:(DDParcelInfoRM *)selected withcallBack:(ControllerCallBack _Nullable)block;
-(void)proceedInAppAfterAuthentication:(UIViewController *)controller onCompletion: (void (^)(void))completion;

-(void)openSearchScreenOnController:(UIViewController *)controller withData:(DDBaseRequestModel *)req;
-(void)showPaymentMethod:(UIViewController*)controller withSelectedMethod:(DDPaymentMethod *)selectedMethod withcallBack:(ControllerCallBack _Nullable)block;

-(void)showOutletsListingOn:(UIViewController*)controller withReqModel:(DDBaseRequestModel*)reqM andControllerCallBack:(ControllerCallBack)controllerCallBack;

-(void)showDeliveryLocationsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)openFilterScreenOnController:(UIViewController *)controller withCallback:(ControllerCallBack)callBack;
-(void)showMerchantDetail:(UIViewController*)controller withReqModel:(DDBaseRequestModel*)reqM andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showSettingsOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block;
-(void)showChangeEmailOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block;
-(void)showChangePasswordOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)block;
-(void)openCustomoization:(UIViewController *)controller withData:(id)data withCallBack:(ControllerCallBack)callBack;
-(void)openRemoveCustomoization:(UIViewController *)controller withData:(id)data withCallBack:(ControllerCallBack)callBack;
-(void)showMenu:(UIViewController*)controller withMenu:(NSArray <DDMerchantDeliveryMenuM *> *)menus withcallBack:(ControllerCallBack _Nullable)block;
-(void)showOrderStatus:(UIViewController*)controller withData:(id)data WithcallBack:(ControllerCallBack _Nullable)block;
-(void)showCashlessCart:(DDBaseRequestModel *)cart onController:(UIViewController *)controller controllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showMerchantInfoRatingOnController:(UIViewController*)controller withData:(id)data withcallBack:(ControllerCallBack _Nullable)block;
-(void)showOrderRating:(UIViewController*)controller withData:(DDRatingRM *)data WithcallBack:(ControllerCallBack _Nullable)block;
-(void)openLoginVC:(UIViewController *)controller onCompletion: (void (^)(void))completion;
-(void)showC2CCart:(DDBaseRequestModel *)cart onController:(UIViewController *)controller controllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showForm:(DDFormCollectionM *)form onController:(UIViewController *)controller controllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showC2CLocationsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
@end

NS_ASSUME_NONNULL_END
