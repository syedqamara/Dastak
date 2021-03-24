//
//  DDRedemptionsManager.m
//  DDRedemptions
//
//  Created by Hafiz Aziz on 11/02/2020.
//

#import "DDRedemptionsManager.h"
#import "DDHistoryRequestM.h"
#import "DDAuth.h"
#import <DDAnalyticsManager.h>

@implementation DDRedemptionsManager

static DDRedemptionsManager *sharedObj;
+(DDRedemptionsManager *)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObj = [[DDRedemptionsManager alloc]init];
    });
    return sharedObj;
}

-(void)getRedemptionHistory:(DDHistoryRequestM * )redemptionRequestModel  andCompletion:(historyCompletionCallBack) completion{
    
    [self getApiRequest:DDApisType_Redemption_History andParam:redemptionRequestModel completion:completion];
}
-(void)getReservationHistory:(DDHistoryRequestM * )redemptionRequestModel  andCompletion:(historyCompletionCallBack) completion{
    [self getApiRequest:DDApisType_Reservations_History andParam:redemptionRequestModel completion:completion];
}

-(void)performRedemption:(DDMerchantOffersLocalDataM *)viewModel  andCompletion:(redemptionCompletionCallBack) completion{
    [self getRedemptionRequestModelFromVM:viewModel completion:^(id _Nullable requestM, NSString * _Nullable message) {
        if (message && message.length){
            NSError *err = [NSError errorWithDomain:@"DDError"
                code:100 userInfo:@{NSLocalizedDescriptionKey:message}];
            if (completion != nil) {
                completion(nil, nil, err);
            }
        }else if ([requestM isKindOfClass:DDRedemptionAPIModel.class]) {
            if (completion != nil) {
                completion(requestM, nil, nil);
            }
        }else if ([requestM isKindOfClass:DDRedemptionRequestM.class]){
            [DDNetworkManager.shared post:DDApisType_Redemption_Redemptions
                                   showHUD:YES
                                 withParam:requestM
                             andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (completion != nil) {
                    completion((DDRedemptionAPIModel*)model, response, error);
                }
            }];
        }
    }];
}

-(void)getRedemptionRequestModelFromVM:(DDMerchantOffersLocalDataM *)viewModel completion:(void (^)(id _Nullable requestM, NSString * _Nullable message))completion{
        
    BOOL isNetworkReachable = [UIApplication isInternetConnected];
    BOOL isDeliveryOffer = [viewModel.offerSection isDelivery];
    if (!isDeliveryOffer && !isNetworkReachable){
        completion(nil,@"You need to be online to redeem this offer. Please check your Internet connection and try again.".localized);
        return;
    }
    [[DDNetworkManager shared] get:DDApisType_Redemption_NETWORK_CHECK showHUD:YES withParam:[DDBaseRequestModel new] andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (model){
            [self getRedemptionRequestAPIModelFromVM:viewModel completion:completion];
        }else {
            if (isDeliveryOffer){
                NSString *merchantPin = viewModel.offerToDisplay.hhs;
                NSString *enteredPin = [DDEncryptionManager.shared encryptRedemptionPin:viewModel.merchant_pin];
                if ([merchantPin isEqualToString:enteredPin]){
                    [self saveOfflineRedemption:viewModel completion:completion];
                }
            }else {
                completion(nil,@"You need to be online to redeem this offer. Please check your Internet connection and try again.".localized);
            }
        }
    }];
}

-(void)getRedemptionRequestAPIModelFromVM:(DDMerchantOffersLocalDataM *)viewModel completion:(void (^)(id _Nullable requestM, NSString * _Nullable message))completion {
    DDRedemptionRequestM *requestM = [[DDRedemptionRequestM alloc] init];
    
    NSString *enteredPin = [DDEncryptionManager.shared encryptRedemptionPin:viewModel.merchant_pin];
    NSString *pinText = viewModel.merchant_pin;
    
    if (viewModel.isMerchantPinDecryptionRequired && viewModel.isMerchantPinDecryptionRequired.boolValue){
        pinText = [DDEncryptionManager.shared decryptRedemptionPin:viewModel.offerToDisplay.hhs];
        enteredPin = [DDEncryptionManager.shared encryptRedemptionPin:pinText];
    }
    
    NSString * isShared=[viewModel.offerSection isPingedToMe]?@"1":@"0";
    NSString* productID=[viewModel.offerSection.product_id stringValue];
    
    requestM.offer_id = viewModel.offerToDisplay.offer_id;
    requestM.quantity = @1;
    requestM.user_id = DDUserManager.shared.currentUser.user_id;
    requestM.outlet_id = viewModel.selectedOutlet.outlet_id;
    requestM.merchant_pin = pinText;
    requestM.lng = @(DDLocationsManager.shared.userCurrentLocation.coordinate.longitude);
    requestM.lat = @(DDLocationsManager.shared.userCurrentLocation.coordinate.latitude);
    requestM.is_shared = isShared;
    requestM.is_reattempt = viewModel.is_reattempt;
    requestM.transaction_id = viewModel.transaction_id;
    requestM.product_id = productID;
    
    if( [viewModel.offerSection isDelivery]){
        requestM.is_delivery = @(true);
    }
    
    if (viewModel.offerToDisplay.is_family_offer != nil){
        requestM.is_family_offer = @([viewModel.offerToDisplay.is_family_offer intValue]);
    }
    completion(requestM,nil);
}

-(void)saveOfflineRedemption:(DDMerchantOffersLocalDataM *)viewModel completion:(void (^)(id _Nullable requestM, NSString * _Nullable message))completion {

    DDRedemptionReferenceData *refData = [[DDRedemptionReferenceData alloc] init];
    DDRedemptionReferenceM * refM = [[DDRedemptionReferenceM alloc] init];
    DDRedemptionAPIModel *redemApiM = [[DDRedemptionAPIModel alloc] init];
    NSString *redemptionCode = [self getCustomerReferenceNumber];
    refData.redemption_code = redemptionCode;
    refM.referenceNo = refData;
    viewModel.offerToDisplay.redemptionCode = redemptionCode;
    redemApiM.data = refM;
    
    NSManagedObjectContext *context = [[DDDatabaseManager shared] getDefaultMRContext];
    DDUserRedemptions *localRedemption = [NSEntityDescription insertNewObjectForEntityForName:@"DDUserRedemptions" inManagedObjectContext:context];
    
    localRedemption.is_sync = [NSNumber numberWithBool:NO];
    localRedemption.outlet_id = viewModel.selectedOutlet.outlet_id;
    localRedemption.merchant_id = viewModel.merchant.merchant_id;
    localRedemption.offer_id = viewModel.offerToDisplay.offer_id;
    localRedemption.product_id = [NSString stringWithFormat:@"%lld",[[viewModel.offerSection.product_id stringValue] longLongValue]];
    localRedemption.user_id = [DDUserManager shared].currentUser.user_id;
    localRedemption.redemption_datetime = [NSDate date];
    localRedemption.redemption_date_timezone = [DDExtraUtil getDefaultTimezone];
    localRedemption.redemption_code = redemptionCode;
    localRedemption.transaction_id = viewModel.transaction_id;
    localRedemption.currency = [DDUserManager shared].currentUser.currency;
    if (viewModel.offerToDisplay.is_family_offer){
        localRedemption.is_family_offer = viewModel.offerToDisplay.is_family_offer;
    }
    if (viewModel.offerToDisplay.is_birthday_offer){
        localRedemption.is_birthday_offer = viewModel.offerToDisplay.is_birthday_offer;
    }
    if (viewModel.offerToDisplay.family_identifier){
        localRedemption.family_identifier = viewModel.offerToDisplay.family_identifier;
    }
    double lat = 0.0;
    double lng = 0.0;
    CLLocation *loc = [[DDLocationsManager shared] userCurrentLocation];
    if (loc){
        lat = loc.coordinate.latitude;
        lng = loc.coordinate.longitude;
    }
    
    localRedemption.lat = @(lat);
    localRedemption.lng = @(lng);
    
    localRedemption.language = NSString.deviceLanguage;
    localRedemption.quantity = [NSNumber numberWithInt:1];
    if([viewModel.offerSection isPingedToMe]){
        localRedemption.isshared = [NSNumber numberWithBool:YES];
    } else {
        localRedemption.isshared = [NSNumber numberWithBool:NO];
    }
    [[DDDatabaseManager shared] saveData];
    [[DDDataSyncUtil sharedInstance]syncRedemptions];
    completion(redemApiM,nil);
}

-(NSString *) getCustomerReferenceNumber {
    NSString *uniqueIdString = [NSString stringWithFormat:@"%.6f",CACurrentMediaTime()];
    if(uniqueIdString.length > 5){
        uniqueIdString = [uniqueIdString stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSMutableString *mu = [NSMutableString stringWithString:uniqueIdString];
        [mu insertString:@"-" atIndex:5];
        uniqueIdString = [mu copy];
    }
    NSString *refCode = [NSString stringWithFormat:@"DLO-%@",uniqueIdString];
    return refCode;
}

// MARK: - Redemption related Util methods

- (void)checkAndShowOfferDetails:(DDMerchantOffersLocalDataM *)merchantOfferModel completion:(void (^)(DDMOfferRedemptionType responseType, NSString * _Nullable alertTitle, NSString * _Nullable alertMsg))completion{
    
    [merchantOfferModel.offerToDisplay checkRedemibilityStatus:^(BOOL isRedeemable) {
        
        if([merchantOfferModel.offerToDisplay isOutletExistInOffer:merchantOfferModel.selectedOutlet.outlet_id]){
            
            //we already did check if user is not logged-in or demographics not filled
            
            [self selectOfferFor:merchantOfferModel completion:completion];
        }
        
    } isRedeemed:^(BOOL isRedeemed) {
        
        if([merchantOfferModel.offerToDisplay isShowSmilesEarnValue] && [merchantOfferModel.offerToDisplay isTopupOfferAllowed]){
            [self startBuyBackProcess:merchantOfferModel completion:completion];
        }

    } isNotRedeemed:^(BOOL isNotRedeemed) {
        if([merchantOfferModel.offerToDisplay isPinged])
            return;
        [self selectOfferFor:merchantOfferModel completion:completion];
    }];

}

-(void) selectOfferFor:(DDMerchantOffersLocalDataM *)merchantOfferModel completion:(void (^)(DDMOfferRedemptionType responseType, NSString * _Nullable alertTitle, NSString * _Nullable alertMsg))completion{

    [self checkOutlet:merchantOfferModel.offerToDisplay selectedOutlet:merchantOfferModel.selectedOutlet completion:^(bool isSuccess){
        if (isSuccess){
            DDMerchantOfferToDisplay*offerSelecteds = merchantOfferModel.offerToDisplay;
            if (offerSelecteds.categories_analytics != nil){
                // TODO: [Zubair] Add analytics at appropriate place
//                [[DDCustomAppAnalytics defaultAnalytics]trackisNewScreen:NO parameters:@{@"current_screen":@"Merchant Detail",@"action":@"select_offer",@"merchant_id":selectedOutlet.merchant.merchant_id,@"offer_id":offerSelecteds.offer_id,@"category_id":offerSelecteds.categories_analytics,@"sub_category":selectedOutlet.sub_categories_analytics ? selectedOutlet.sub_categories_analytics : @""}];
            }

            // !!!: Show alert for Live Offers if offer is not valid for the current day.
            if (merchantOfferModel.offerToDisplay.checkAvailibilityForLiveOffer) {
                completion(DDMOfferRedemptionTypeUnknown, merchantOfferModel.offerToDisplay.restriction_title, merchantOfferModel.offerToDisplay.restriction_message);
                return;
            }

            if([merchantOfferModel isPromoOrSwipeBasedRedemption]){
                completion(DDMOfferRedemptionTypeRedeemableWithLocation, nil, nil);
            } else {
                completion(DDMOfferRedemptionTypeRedeemable, nil, nil);
            }
        } else {
            completion(DDMOfferRedemptionTypeOutletChangeAlert, nil, nil);
        }
    }];
}


-(void) checkOutlet:(DDMerchantOfferToDisplay *)offersToDisplay selectedOutlet:(DDOutletM *) selectedOutlet completion:(void (^)(bool isSuccess))completion{
    
    if (![offersToDisplay isRedeemable]){
        completion(YES);
        return;
    }
    
    if([offersToDisplay.outlet_ids count] == 1){
        completion(YES);
        return;
    }
    
    completion(NO);
}

-(void)startBuyBackProcess:(DDMerchantOffersLocalDataM *)merchantOfferModel completion:(void (^)(DDMOfferRedemptionType responseType, NSString * _Nullable alertTitle, NSString * _Nullable alertMsg))completion{
    
    // TODO: [Zubair] add analytics as per requirements
    
    
    if([merchantOfferModel.offerToDisplay.smiles_burn_value integerValue]<[merchantOfferModel.merchant.smiles_total_balance integerValue]){
        completion(DDMOfferRedemptionTypeBuyBack, nil, nil);
    }else{
        completion(DDMOfferRedemptionTypeUnknown, @"Sorry, You do not have enough Smiles to buy back this voucher.".localized,nil);
    }
}

// MARK: - General API Call
-(void)getApiRequest:(DDApisType)request andParam:(DDBaseRequestModel*)model completion:(historyCompletionCallBack)completion{
    
    __weak typeof(self) weakSelf = self;
    [DDNetworkManager.shared get:request showHUD:YES withParam:model andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDBaseHistoryAPIModel *apiData = (DDBaseHistoryAPIModel*)model;
        if (model) {
            weakSelf.historyData = apiData;
        }
        if (completion != nil)
            completion(weakSelf.historyData,response,error);
    }];
}


-(void) sendTopupOfferRequest:(DDMerchantOffersLocalDataM *) viewModel showLoader: (BOOL)showLoader  andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    
    DDBaseRequestModel *model = [[DDBaseRequestModel alloc] init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:viewModel.offerToDisplay.offer_id forKey:@"offer_id"];
    [params setObject:viewModel.merchant.merchant_id forKey:@"merchant_id"];
    [params setObject:viewModel.offerSection.product_id forKey:@"product_id"];
    [params setObject:viewModel.offerToDisplay.smiles_burn_value forKey:@"points"];
    [params setObject:viewModel.offerToDisplay.offer_pay_back_app_action_id forKey:@"app_action_id"];
    [model addCustomParams:params];
    
    [DDNetworkManager.shared post:DDApisType_Redemption_BuyBack showHUD:showLoader withParam:model andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(model, response, error);
    }];
}

-(void)sendRedemptionAnalytics:(DDMerchantOffersLocalDataM *)dataMOdel {
    NSMutableDictionary* appBoyDic = [[NSMutableDictionary alloc]init];
    [appBoyDic setValue:[NSDate date] forKey:@"Redemptiondate"];
    [appBoyDic setValue:dataMOdel.merchant.name forKey:@"MerchantName"];
    [appBoyDic setValue:dataMOdel.selectedOutlet.name forKey:@"OutletName"];
    [appBoyDic setValue:dataMOdel.offerToDisplay.savings_estimate_aed forKey:@"Savings"];
    [APP_ANALYTICS trackEvent:APPBOY_EVDD_REDEEMED withType:DDEventTypeBraze andParam:appBoyDic andEventDescription:@""];
}
@end
