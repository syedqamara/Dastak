//
//  DDPingsUIManager.m
//  DDPingsUI
//
//  Created by Hafiz Aziz on 06/02/2020.
//

#import "DDPingsUIManager.h"
#import "DDUI.h"
#import <DDAuth/DDAuth.h>
#import "DDPingsHistoryVC.h"
#import <DDAnalyticsManager.h>

@implementation DDPingsUIManager

static DDPingsUIManager *_sharedObj;

+(DDPingsUIManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObj = [[DDPingsUIManager alloc] init];
    });
    return _sharedObj;
}
-(NSMutableArray *)getOffersToDisplayArray:(NSMutableArray *)offerArray{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for(DDMerchantOfferM *offersection in offerArray){
        if([offersection isKindOfClass:[DDMerchantOfferM class]])
            for (DDMerchantOfferToDisplay *offer in offersection.offers_to_display) {
                if([offer isSelectedForPing])
                    [tempArray addObject:offer];
            }
    }
    return tempArray;
}

-(void) goToAnotherViewController:(UIViewController*)controller withPingsModel : (DDPingRequestM*) model routeLink :(NSString*)routeLink andControllerCallBack:(ControllerCallBack)controllerCallBack{
    DDUIRouterM *route = [DDUIRouterM.alloc init];
    route.route_link = routeLink;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.should_embed_in_nav = NO;
    route.data = model;
    route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}


-(void)callPingAcceptRejectAPI:(DDPingRequestM*)requestModel andCompletion:(void(^)(DDPingApiModel * model, BOOL success)) completion {
    [DDPingsManager.shared acceptPingsRequest:requestModel andCompletion:^(DDPingApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            [DDAlertUtils showOkAlertWithTitle:@"" subtitle:model.data.message completion:nil];
            completion(model,YES);
        }else{
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
            completion(nil,NO);
        }
    }];
}
-(void)showPingOffersUserHasReceived:(UIViewController *)controller pendingPings : (DDPendingNotificatiosModel*)pingsData onCompletion: (void (^)(BOOL completed))completion {
    if (![[UIApplication visibleController] isKindOfClass:[DDPingsHistoryVC class]]) {
        [APP_ANALYTICS trackEvent:APPBOY_EVDD_RecievePing withType:DDEventTypeBraze andParam:@{} andEventDescription:@""];
        [self showPingOffers:pingsData.offer_pinging_pending:pingsData:controller:completion];
    }else {
        completion(NO);
    }
}

- (void)showPingOffers:(NSArray*)pings : (DDPendingNotificatiosModel*)pingsData : (UIViewController*)controller : (void (^)(BOOL completed))completion {
    if (pings.count > 0) {
        DDOfferPingingPending *ping = [pings lastObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            DDCustomeActionSheetM *model = [[DDCustomeActionSheetM alloc] init];
            model.title = ping.title;
            model.subtitle = ping.sub_title;
            model.hideCross = @(1);
            model.btnsArray = @[@"Accept All".localized, @"View Pinged Offers".localized, @"No right now".localized];
            model.Image = pingsData.image_url;
            [DDCustomActionSheet showWithData:model withCompletion:^(int index) {
                if (index == 0){
                    // call api to accept all these pings
                    // get pings from ping.offers
                    NSMutableArray *mutablePings = pings.mutableCopy;
                    [mutablePings removeObject:[mutablePings lastObject]];
                    [self callPingAcceptAPIFromActionSheetDialogue:ping andCompletion:^(BOOL completed) {
                        [self showPingOffers:mutablePings:pingsData:controller:completion];
                    }];
                }else if (index == 1){
                    // open pings history screen to show all received pings
                    [[DDWebManager  shared] openURL:@"entertainer://pingshistory" title:@"" onController:controller];
                    completion(YES);
                }else if (index == -1){
                    // run  the next iteration
                    NSMutableArray *mutablePings = pings.mutableCopy;
                    [mutablePings removeObject:[mutablePings lastObject]];
                    [self showPingOffers:mutablePings:pingsData:controller:completion];
                }
            }];
            
        });
//        NSMutableDictionary* appBoyDic = [[NSMutableDictionary alloc]init];
//        [appBoyDic setValue:[NSDate date] forKey:@"ReceivePingDate"];
//        [[DDAppboyEventManager sharedInstance] addEventWithTitle:@"Receive Ping" andParam:appBoyDic];
    }else{
        completion(YES);
    }
}

//MARK:- Empty View Setup
-(DDEmptyViewModel*)checkAndGetEmptyViewModelForInvitePings:(DDPingApiModel*)apiData {
    DDEmptyViewModel *emptyVM = [DDEmptyViewModel new];
    emptyVM.title = @"Nothing to Ping right now";
    emptyVM.btn_title = @"Buy Smiles";
    emptyVM.image = @"nothingToPing.png";
    emptyVM.imageHeight = @(120);
    if (apiData.message.length > 0) {
        emptyVM.title = apiData.title;
        emptyVM.sub_title = apiData.message;
    }
    return emptyVM;
}

-(DDEmptyViewModel*)checkAndGetEmptyViewModelForNoFriends:(DDFriendsAPI*)apiData {
    DDEmptyViewModel *emptyVM = [DDEmptyViewModel new];
    emptyVM.title = @"It looks like you haven’t add a friend yet.";
    emptyVM.sub_title = @"Add friends to see who is saving more!";
    emptyVM.image = @"family.png";
    if (apiData != nil && apiData.message.length > 0) {
        emptyVM.title = apiData.title;
        emptyVM.sub_title = apiData.message;
    }
    return emptyVM;
}


-(void)callPingAcceptAPIFromActionSheetDialogue:(DDOfferPingingPending*)pings andCompletion:(void(^)(BOOL completed)) completion {
    DDPingRequestM *pingRequestM = [[DDPingRequestM alloc] init];
    pingRequestM.customer_id = DDUserManager.shared.currentUser.user_id;
    pingRequestM.ping_ids = pings.ping_id.mutableCopy;
    pingRequestM.status = @(1);
    if (!pingRequestM.isValidRequestForAcceptPingCall) {
        [DDAlertUtils showOkAlertWithTitle:nil subtitle:pingRequestM.validationErrorMessageForAcceptPing completion:nil];
    } else {
        [self callPingAcceptRejectAPI:pingRequestM andCompletion:^(DDPingApiModel * _Nonnull model, BOOL success) {
            completion(YES);
        }];
    }
}

-(void)showMerchantDetailsFrom:(UIViewController*)controller withOutlet:(DDMerchantDetailRequestM*)model andControllerCallBack:(ControllerCallBack)controllerCallBack {
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = DD_Nav_Outlets_Detail;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.data = model;
    route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];
}

@end
