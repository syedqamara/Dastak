//
//  DDSearchManager.h
//  DDSearch
//
//  Created by Syed Qamar Abbas on 14/01/2020.
//

#import <Foundation/Foundation.h>
#import "DDModels.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDSearchManager : NSObject
+(DDSearchManager *)shared;
@property (strong, nonatomic) DDFiltersApiM *filterModel;

-(void)searchWithRequest:(DDBaseRequestModel *)searchRequestModel showHUD:(BOOL)showHUD completion:(void (^)(DDSearchApiM * _Nullable model, NSError * _Nullable error))completion;
-(void)fetchFiltersWithRequest:(DDBaseRequestModel *)requestModel showHUD:(BOOL)showHUD completion:(void (^)(DDFiltersApiM * _Nullable model, NSError * _Nullable error))completion;
@end

NS_ASSUME_NONNULL_END
