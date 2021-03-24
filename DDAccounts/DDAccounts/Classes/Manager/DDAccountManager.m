//
//  DDAccountManager.m
//  DDAccounts
//
//  Created by M.Jabbar on 30/01/2020.
//

#import "DDAccountManager.h"

@implementation DDAccountManager
static DDAccountManager *_sharedObject;
+(DDAccountManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDAccountManager alloc]init];
    });
    return _sharedObject;
}

-(void)profileFamilyWithCompletion:(BOOL)showLoader completion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion{
    
    DDUserM *user  = [DDUserManager shared].currentUser;
    if (user) {
        DDFamilyRequestM *familyRequest = [[DDFamilyRequestM alloc] init];
        [DDFamilyManager.shared fetchFriendsRankingWithRequestModel:showLoader familyreq:familyRequest completion:^(DDFriendsAPI * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            completion(model,response,error);
        }];
    }else{
        NSError *error = [[NSError alloc] initWithDomain:@"Oops" code:1223 userInfo:@{NSLocalizedDescriptionKey: @"User is not login"}];
        completion(nil,nil,error);
    }
}
-(void)profileProductsWithCompletion:(void (^)(DDProfileApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion{
    DDUserM *user  = [DDUserManager shared].currentUser;
     if (user) {
         DDBaseRequestModel *requestModel = [[DDBaseRequestModel alloc] init];
         [DDProductManager  loadProfileSectionWithModel:requestModel showLoader:NO withCompletion:completion];

     }else{
         NSError *error = [[NSError alloc] initWithDomain:@"Oops" code:1223 userInfo:@{NSLocalizedDescriptionKey: @"User is not login"}];
         completion(nil,nil,error);
     }
}
-(void)settingsWithParams:(NSDictionary *)dict completion:(void (^)(DDSettingsApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion{
     if ([DDUserManager shared].isLoggedIn) {
         DDBaseRequestModel *requestModel = [[DDBaseRequestModel alloc] init];
         [requestModel.custom_parameters addEntriesFromDictionary:dict];
         [[DDNetworkManager shared] post:DDApisType_Account_Settings showHUD:YES withParam:requestModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
             completion((DDSettingsApiM*)model,response,error);
         }];
     }else{
         NSError *error = [[NSError alloc] initWithDomain:@"Oops" code:1223 userInfo:@{NSLocalizedDescriptionKey: @"User is not login"}];
         completion(nil,nil,error);
     }
}
-(void)submitFeedback:(NSDictionary *)dict completion:(void (^)(DDResponseMessageApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion{
    if ([DDUserManager shared].isLoggedIn) {
    
        DDBaseRequestModel *requestModel = [[DDBaseRequestModel alloc] init];
        [requestModel.custom_parameters addEntriesFromDictionary:dict];
         [DDNetworkManager.shared post:DDApisType_Account_Submit_Feed_Back showHUD:YES withParam:requestModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
             completion((DDResponseMessageApiM*)model,response,error);
         }];
     }else{
         NSError *error = [[NSError alloc] initWithDomain:@"Oops" code:1223 userInfo:@{NSLocalizedDescriptionKey: @"User is not login"}];
         completion(nil,nil,error);
     }
}
- (void)getSmiles:(NSDictionary *)dict completion:(void (^)(PSSmilesData * _Nullable, NSString * _Nullable))completion{
    
    if ([DDUserManager shared].isLoggedIn) {
    
         [PSSmilesAPI getSmilesBurnForStoreListing:^(id object, NSString *error) {
                if(object){
                 PSSmilesData *data = (PSSmilesData *) object;
                    self.smiles = data;
                    completion(data,error);
                } else {
                    [DDLogs log:@"ERROR IN SMILES %@",error];
                    completion(nil,error);
                }
            }];

     }else{
         NSError *error = [[NSError alloc] initWithDomain:@"Oops" code:1223 userInfo:@{NSLocalizedDescriptionKey: @"User is not login"}];
         completion(nil,error.localizedDescription);
     }
}
-(void)purchaseSmilesPack:(NSDictionary*)dic completion:(void (^)(DDBuyPingsApiDataM * _Nullable model, NSError * _Nullable error))completion{
    
    if ([DDUserManager shared].isLoggedIn) {
       
           DDBaseRequestModel *requestModel = [[DDBaseRequestModel alloc] init];
           [requestModel.custom_parameters addEntriesFromDictionary:dic];
            [DDNetworkManager.shared post:DDApisType_Account_Buy_Smiles_Pack showHUD:YES withParam:requestModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                DDBuyPingsApiM *resposneModel =  (DDBuyPingsApiM*)model;
                completion(resposneModel.data,error);
            }];

        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"Oops" code:1223 userInfo:@{NSLocalizedDescriptionKey: @"User is not login"}];
            completion(nil,error);
        }
}
//- (void)getSavings:(NSDictionary *)dict completion:(void (^)(DDSavingsApiDataM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion{
//
////    if ([DDUserManager shared].isLoggedIn) {
//
//        DDBaseRequestModel *requestModel = [[DDBaseRequestModel alloc] init];
//        [requestModel.custom_parameters addEntriesFromDictionary:dict];
//        [DDNetworkManager.shared post:DDApisType_Account_Savings showHUD:YES withParam:requestModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            DDSavingsApiM *resposneModel =  (DDSavingsApiM*)model;
//            completion(resposneModel.data,response,error);
//        }];
//
//
////    }else{
////        NSError *error = [[NSError alloc] initWithDomain:@"Oops" code:1223 userInfo:@{NSLocalizedDescriptionKey: @"User is not login"}];
////        completion(nil,nil,error.localizedDescription);
////    }
//}
- (void)getSavings:(NSDictionary *)dict completion:(void (^)(DDSavingsDetailAPIData * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion{
    
//    if ([DDUserManager shared].isLoggedIn) {
        
        DDBaseRequestModel *requestModel = [[DDBaseRequestModel alloc] init];
        [requestModel.custom_parameters addEntriesFromDictionary:dict];
        [DDNetworkManager.shared post:DDApisType_Account_Savings showHUD:YES withParam:requestModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            DDSavingsDetailAPI *resposneModel =  (DDSavingsDetailAPI*)model;
            completion(resposneModel.data,response,error);
        }];
        
        
//    }else{
//        NSError *error = [[NSError alloc] initWithDomain:@"Oops" code:1223 userInfo:@{NSLocalizedDescriptionKey: @"User is not login"}];
//        completion(nil,nil,error.localizedDescription);
//    }
}

@end
