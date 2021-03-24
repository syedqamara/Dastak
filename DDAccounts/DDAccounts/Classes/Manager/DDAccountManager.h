//
//  DDAccountManager.h
//  DDAccounts
//
//  Created by M.Jabbar on 30/01/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>
#import <DDNetwork/DDNetwork.h>
#import <DDConstants/DDConstants.h>
#import <DDProducts/DDProducts.h>
#import <DDFamily/DDFamily.h>
#import <DDAuth/DDAuth.h>
#import <DDPodGamification/GamificationLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDAccountManager : NSObject

+(DDAccountManager *)shared;
@property(nonatomic) PSSmilesData *smiles;
@property(nonatomic)NSMutableArray <DDSettingsSectionM> *profileSettings;

-(void)profileFamilyWithCompletion:(BOOL)showLoader completion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)profileProductsWithCompletion:(void (^)(DDProfileApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)settingsWithParams:(NSDictionary *)dict completion:(void (^)(DDSettingsApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)submitFeedback:(NSDictionary *)dict completion:(void (^)(DDResponseMessageApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)getSmiles:(NSDictionary *)dict completion:(void (^)(PSSmilesData * _Nullable model, NSString * _Nullable error))completion;
-(void)purchaseSmilesPack:(NSDictionary*)dic completion:(void (^)(DDBuyPingsApiDataM * _Nullable model, NSError * _Nullable error))completion;
- (void)getSavings:(NSDictionary *)dict completion:(void (^)(DDSavingsDetailAPIData * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
