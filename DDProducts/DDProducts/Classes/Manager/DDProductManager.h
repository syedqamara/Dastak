//
//  DDProductManager.h
//  DDProducts
//
//  Created by Syed Qamar Abbas on 30/01/2020.
//

#import <Foundation/Foundation.h>
#import <DDModels/DDModels.h>
#import <DDCommons/DDCommons.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDProductManager : NSObject
///Please write a RequestModel for this Api Call

//+(DDProductManager *)shared;

+(void)loadProfileSectionWithModel:(DDBaseRequestModel *)model showLoader: (BOOL)showLoader withCompletion:(void (^)(DDProfileApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
+(void)loadMerchantDetailSectionProducts:(DDBaseRequestModel *)model showLoader: (BOOL)showLoader withCompletion:(void (^)(DDProfileApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
+(void)loadProductsWithModel:(DDBaseRequestModel *)model withCompletion:(void (^)(DDProductPurchaseApiDataM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
