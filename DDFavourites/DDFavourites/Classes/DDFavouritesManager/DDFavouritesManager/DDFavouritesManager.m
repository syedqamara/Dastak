//
//  DDFavouritesManager.m
//  DDFavourites
//
//  Created by M.Jabbar on 04/03/2020.
//

#import "DDFavouritesManager.h"
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>
#import <DDNetwork/DDNetwork.h>
#import <DDAuth/DDAuth.h>
#import "DDFavouritesConstants.h"

@implementation DDFavouritesManager

static DDFavouritesManager *_sharedObject;

+(DDFavouritesManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDFavouritesManager alloc]init];
    });
    return _sharedObject;
}


-(void)getFavoritiesListAndCompletion:(void (^)(DDFavouritesApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion  {
    
    DDBaseRequestModel *requestModel = [[DDBaseRequestModel alloc] init];
    [requestModel.custom_parameters setValue:DDCCommonParamManager.shared.default_api_parameters.company forKey:@"__c"];
    [DDNetworkManager.shared post:DDApisType_Favourites_Favourites showHUD:YES withParam:requestModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion((DDFavouritesApiM*)model,response,error);
    }];
}


-(void)markFavoritie:(NSArray*)favourites isFavourite:(BOOL)isFavourite needFavRefresh:(BOOL)refresh completion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    DDBaseRequestModel *requestModel = [[DDBaseRequestModel alloc] init];
       [requestModel.custom_parameters setValue:DDCCommonParamManager.shared.default_api_parameters.company forKey:@"__c"];
    if (isFavourite){
        [requestModel.custom_parameters setValue:favourites forKey:@"__m_ids"];
        [DDNetworkManager.shared post:DDApisType_Favourites_Mark_Favourites showHUD:YES withParam:requestModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (refresh){
                [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_FAVOURITES_NOTIFICATION object:nil];
            }
            completion(model,response,error);
        }];
    }else {
        if (favourites.count > 0){
            [requestModel.custom_parameters setValue:favourites.firstObject forKey:@"__m_id"];
            [DDNetworkManager.shared post:DDApisType_Favourites_Remove_Favourites showHUD:YES withParam:requestModel andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (refresh){
                    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_FAVOURITES_NOTIFICATION object:nil];
                }
                completion(model,response,error);
            }];
        }
    }
}

-(void)sendPendingFavouritesToServer {
    if([DDUserManager shared].currentUser && [DDUserManager shared].currentUser.user_id) {
        NSMutableArray *nonSyncedFavourites =  [self getNonSyncedFavourites:[DDUserManager shared].currentUser.user_id];
        if(nonSyncedFavourites == nil || (nonSyncedFavourites && nonSyncedFavourites.count == 0)){
            [DDSharedPreferences.shared setObjectDF:nil forKey:@"favorites"];
            return;
        }
        NSLog(@"%@",nonSyncedFavourites);
        [self markFavoritie:nonSyncedFavourites isFavourite:YES needFavRefresh:YES completion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil && model.successfulApi){
                [DDSharedPreferences.shared setObjectDF:nil forKey:@"favorites"];
            }
        }];
    }
}

    
-(NSMutableArray *)getNonSyncedFavourites:(NSNumber *) userId {
    NSString *favorities = [DDSharedPreferences.shared objectforKeyDF:@"favorites"];
    if (favorities == nil || (favorities && favorities.length == 0)){
        [DDSharedPreferences.shared setObjectDF:nil forKey:@"favorites"];
        return @[].mutableCopy;
    }
    NSArray *favArray = [favorities componentsSeparatedByString:@","];
    NSMutableArray *thisUserFav =[[NSMutableArray alloc] init];
    for (NSString *favIDWithUserID in favArray){
        NSArray *temp = [favIDWithUserID componentsSeparatedByString:@"###"];
        if (temp && temp.count > 0){
            if ([temp[0] isEqualToString:userId.stringValue]){
                [thisUserFav addObject:temp[1]];
            }
        }
    }
    return thisUserFav;
}


@end
