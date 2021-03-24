//
//  DDPingsUIManager.h
//  DDPingsUI
//
//  Created by Hafiz Aziz on 06/02/2020.
//

#import <Foundation/Foundation.h>
#import "DDPingsManager.h"
#import "DDAlertUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPingsUIManager : NSObject
+(DDPingsUIManager *)shared;
-(NSMutableArray *)getOffersToDisplayArray:(NSMutableArray *)offerArray;
-(void) goToAnotherViewController:(UIViewController*)controller withPingsModel : (DDPingRequestM*) model routeLink :(NSString*)routeLink andControllerCallBack:(ControllerCallBack)controllerCallBack;

-(void)callPingAcceptRejectAPI:(DDPingRequestM*)requestModel andCompletion:(void(^)(DDPingApiModel * model, BOOL success)) completion;
-(void)showPingOffersUserHasReceived:(UIViewController *)controller pendingPings : (DDPendingNotificatiosModel*)pingsData onCompletion: (void (^)(BOOL completed))completion ;

-(DDEmptyViewModel*)checkAndGetEmptyViewModelForNoFriends:(DDFriendsAPI*)apiData;
-(DDEmptyViewModel*)checkAndGetEmptyViewModelForInvitePings:(DDPingApiModel*)apiData ;

-(void)showMerchantDetailsFrom:(UIViewController*)controller withOutlet:(DDMerchantDetailRequestM*)model andControllerCallBack:(ControllerCallBack)controllerCallBack;

@end

NS_ASSUME_NONNULL_END
