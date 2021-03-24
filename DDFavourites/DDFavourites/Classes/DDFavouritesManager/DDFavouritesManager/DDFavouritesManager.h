//
//  DDFavouritesManager.h
//  DDFavourites
//
//  Created by M.Jabbar on 04/03/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>
#import <DDNetwork/DDNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDFavouritesManager : NSObject
+(DDFavouritesManager *)shared;
-(void)getFavoritiesListAndCompletion:(void (^)(DDFavouritesApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)markFavoritie:(NSArray*)favourites isFavourite:(BOOL)isFavourite needFavRefresh:(BOOL)refresh completion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)sendPendingFavouritesToServer;
@end

NS_ASSUME_NONNULL_END
