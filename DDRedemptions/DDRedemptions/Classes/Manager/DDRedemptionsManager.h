//
//  DDRedemptionsManager.h
//  DDRedemptions
//
//  Created by Hafiz Aziz on 11/02/2020.
//

#import <Foundation/Foundation.h>
#import <DDModels/DDModels.h>
#import <DDNetwork/DDNetwork.h>
#import <DDUI/DDUI.h>
#import "DDUserM.h"
#import "DDRedemptionsConstant.h"
#import <DDStorage/DDStorage.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ _Nullable historyCompletionCallBack)(DDBaseHistoryAPIModel * _Nullable model,NSURLResponse * _Nullable response, NSError * _Nullable error);
typedef void(^ _Nullable redemptionCompletionCallBack)(DDRedemptionAPIModel * _Nullable model,  NSURLResponse * _Nullable response, NSError * _Nullable error);

@interface DDRedemptionsManager : NSObject
@property(strong, nonatomic) DDBaseHistoryAPIModel *historyData;
+(DDRedemptionsManager *)shared;

-(void)getReservationHistory:(DDHistoryRequestM * )redemptionRequestModel  andCompletion:(historyCompletionCallBack) completion;
-(void)getRedemptionHistory:(DDHistoryRequestM * )pingRequestModel  andCompletion:(historyCompletionCallBack) completion;

- (void)checkAndShowOfferDetails:(DDMerchantOffersLocalDataM *)merchantOfferModel completion:(void (^)(DDMOfferRedemptionType responseType, NSString * _Nullable alertTitle, NSString * _Nullable alertMsg))completion;

-(void) sendTopupOfferRequest:(DDMerchantOffersLocalDataM *) viewModel showLoader: (BOOL)showLoader  andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion;

-(void)performRedemption:(DDMerchantOffersLocalDataM *)viewModel  andCompletion:(redemptionCompletionCallBack) completion;

-(void)sendRedemptionAnalytics:(DDMerchantOffersLocalDataM *)dataMOdel;
@end

NS_ASSUME_NONNULL_END
