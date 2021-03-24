//
//  DDFiltersManager.h
//  DDFilters
//
//  Created by Syed Qamar Abbas on 16/01/2020.
//

#import <Foundation/Foundation.h>
#import "DDFiltersDataM.h"
#import <DDCommons/DDCommons.h>
#import <DDNetwork/DDNetwork.h>
#import <DDModels/DDModels.h>
#import "DDFiltersApiModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ _Nullable filtersCompletion)(DDFiltersApiModel * _Nullable model, NSError * _Nullable error);

@interface DDFiltersManager : NSObject
+(DDFiltersManager *)shared;

@property (nonatomic, strong) DDFiltersDataM *filtersData;
@property (nonatomic, strong) DDFiltersDataM *deliveryFiltersData;

-(NSArray<DDFiltersSectionM *> *)filtersDeepCopy;

-(void)fetchFiltersWithHUD:(BOOL)hud WithCompletion:(filtersCompletion)completion;
-(void)fetchDeliveryFiltersWithCompletion:(filtersCompletion)completion;
-(void)outletCountForSelectedFilters:(DDBaseRequestModel *)requestM andCompletion:(filtersCompletion)completion;

- (NSString *)getShowResultsTitleWithCount:(NSInteger)count;
-(DDFiltersOptionM*)getShowMoreOptionFor:(DDFiltersSectionM*)section;
-(void)resetFiltersForSection:(DDFiltersSectionM*)section;
-(void)resetAllFilters;

-(NSDictionary*)getSelectedFiltersParams;
-(NSDictionary*)getSelectedDeliveryFiltersParams;
-(NSMutableArray*)getSelectedDeliveryFilters;

@end

NS_ASSUME_NONNULL_END
