//
//  DDHomeManager.h
//  DDHome
//
//  Created by Zubair Ahmad on 21/01/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>

NS_ASSUME_NONNULL_BEGIN


@interface DDHomeManager : NSObject
+(DDHomeManager *)shared;



-(void)fetchHomeDataWithReq:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(HomeCompletionCallback)completion;
-(void)fetchMerchantDetailWithReq:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(MerchantDetailCompletionCallback)completion;
-(void)fetchOrderDetailWithReq:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(OrderDetailCompletionCallback)completion;
-(void)fetchOrderHistoryWithReq:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(OrderHistoryCompletionCallback)completion;
-(void)fetchOutletListingWithReq:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(OuletListingCompletion)completion;
-(void)fetchFavOutletListingWithReq:(DDBaseRequestModel * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(OuletListingCompletion)completion;
-(void)markFavourite:(DDMerchantRM * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(DefaultApiCompletionCallback)completion;
-(void)cancelOrder:(DDOrderRM * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(DefaultApiCompletionCallback)completion;
-(void)rating:(DDRatingRM * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(DefaultApiCompletionCallback)completion;
-(void)calculateFair:(DDC2CFairsRM * _Nullable)requestM showHUD:(BOOL)showHUD onCompletion:(DefaultApiCompletionCallback)completion;
@end

NS_ASSUME_NONNULL_END
