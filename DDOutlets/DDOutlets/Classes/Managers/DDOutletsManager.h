//
//  DDOutletsManager.h
//  DDOutlets
//
//  Created by Zubair Ahmad on 21/01/2020..
//  Copyright © 2020 The Entertainer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDNetwork/DDNetwork.h>
#import <DDModels/DDModels.h>
#import <DDLocations/DDLocations.h>
#import <DDProducts/DDProducts.h>
#import <DDRedemptions/DDRedemptions.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDOutletsManager : NSObject

+(DDOutletsManager *)shared;

-(void)fetchListOfOutlets:(DDOutletsRequestM *)outletsReqModel showLoader: (BOOL)showLoader  andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion;

-(void)fetchMerchantDetail:(DDMerchantDetailRequestM *)reqModel showLoader: (BOOL)showLoader  andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion;

-(void)fetchMerchantBaseOnlineOfferHistory:(DDBaseRequestModel *)reqModel showLoader: (BOOL)showLoader  andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion;

-(void)fetchProductsList:(DDBaseRequestModel *)reqModel showLoader: (BOOL)showLoader  andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion;

-(void)checkAndShowRedemption:(DDMerchantOffersLocalDataM*)viewModel completion:(void (^)(DDMOfferRedemptionType responseType, NSString * _Nullable alertTitle, NSString * _Nullable alertMsg))completion;

@end

NS_ASSUME_NONNULL_END
