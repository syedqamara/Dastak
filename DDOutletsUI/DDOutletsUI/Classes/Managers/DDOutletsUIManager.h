//
//  DDOutletsUIManager.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 06/02/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import "DDOutletsUIConstants.h"
#import <DDModels/DDModels.h>
#import "DDMerchantOutletLocationViewM.h"
#import <DDUI/DDUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDOutletsUIManager : NSObject
+(DDOutletsUIManager *)shared;


-(void)showMerchantDetailsFrom:(UIViewController*)controller withOutlet:(DDOutletM*)outlet andControllerCallBack:(ControllerCallBack)controllerCallBack;

-(void)showSearchScreenFrom:(UIViewController*)controller withControllerCallBack:(ControllerCallBack)controllerCallBack;

-(void)showCashlessMerchantDetailsFrom:(UIViewController*)controller withOutlet:(DDCashlessRequestM*)model andControllerCallBack:(ControllerCallBack)controllerCallBack;

-(void)openFiltersWithFilters:(DDFiltersScreenRequestM *)filters onController:(UIViewController *)controller onCompletion:(ControllerCallBack)completion;

-(void)openAmenitiesDetail:(UIViewController *)controller withAmenitiesArray :(NSArray*)amenitiesArray onCompletion: (void (^)(void))completion;

-(void)openMerchantTopMenuOptions:(UIViewController *)controller withMerchnatData :(DDMerchantDetailM*)merchantData onCompletion: (void (^)(void))completion;

-(void)openMerchantOnMap:(UIViewController *)controller withSelectedOutlet :(DDMerchantOffersLocalDataM*)selectedOutlet onCompletion: (void (^)(void))completion;

-(void)openMerchantOutlets:(UIViewController *)controller withViewModel:(DDMerchantOutletLocationViewM*) viewModel onCompletion:(ControllerCallBack)completion;

-(void)openMerchantLockeOffersView:(UIViewController *)controller withLockOffersSectionAndModel:(DDMerchantOffersLocalDataM*)vModel onCompletion: (void (^)(void))completion;

-(void)openMerchantBaseOnlineOffersHistory:(UIViewController *)controller withLockOffersSectionAndModel:(NSString*)merchantID onCompletion: (void (^)(void))completion;

-(void) openRedemptionVCFrom:(UIViewController*)controller withOfferViewModel : (DDMerchantOffersLocalDataM*) viewModel andControllerCallBack:(ControllerCallBack)controllerCallBack;

-(void) openPingShareVCFrom:(UIViewController*)controller withOfferViewModel : (DDMerchantOffersLocalDataM*) viewModel andControllerCallBack:(ControllerCallBack)controllerCallBack;

-(DDEmptyViewModel*)checkAndGetEmptyViewModelForOnlineOfferHistory:(DDBaseHistoryAPIModel* _Nullable)apiData;

-(void)showDemographicsOnController:(UIViewController*)controller WithcallBack:(ControllerCallBack _Nullable)completion;

-(DDEmptyViewModel*)getEmptyViewModelForOutletsListing;
@end


NS_ASSUME_NONNULL_END
