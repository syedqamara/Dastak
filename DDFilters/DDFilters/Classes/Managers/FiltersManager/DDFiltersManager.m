//
//  DDFiltersManager.m
//  DDFilters
//
//  Created by Syed Qamar Abbas on 16/01/2020.
//

#import "DDFiltersManager.h"

@interface DDFiltersManager ()

@end

@implementation DDFiltersManager
static DDFiltersManager *_sharedObject;
+(DDFiltersManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDFiltersManager alloc] init];
    });
    return _sharedObject;
}

-(NSArray<DDFiltersSectionM *> *)filtersDeepCopy {
    NSMutableArray <DDFiltersSectionM *> *arr = [NSMutableArray new];
    for (DDFiltersSectionM *filter in self.filtersData.filter_sections) {
        [arr addObject:filter.copyObj];
    }
    return arr;
}

-(void)resetFiltersForSection:(DDFiltersSectionM*)section {
    for (DDFiltersOptionM *option in section.options) {
        option.selected = @(0);
    }
}

-(void)resetAllFilters {
    for (DDFiltersSectionM *filterSection in self.filtersData.filter_sections) {
        for (DDFiltersOptionM *option in filterSection.options) {
            option.selected = @(0);
        }
    }
    for (DDFiltersOptionM *option in self.filtersData.options) {
        option.selected = @(0);
    }
    self.filtersData.minimum_option_display = @(0);
}


-(DDFiltersOptionM*)getShowMoreOptionFor:(DDFiltersSectionM*)section {
    DDFiltersOptionM *option = [DDFiltersOptionM new];
    NSString *title = [self showMoreTitleFor:section];
    option.title = title;
    option.selected = @(title.length > 0);
    if (title.length == 0) {
        option.image_url = @"filter_show_more.png";
    }
    return option;
}

-(NSString*)showMoreTitleFor:(DDFiltersSectionM*)section {
    int count = [self getSelectedFiltersCountInList:section.options itemToShow:section.minimum_option_display.intValue];
    if (count > 0) {
        return [NSString stringWithFormat:@"+%i",count];
    }
    return nil;
}

-(int) getSelectedFiltersCountInList:(NSArray *)filters itemToShow:(int)itemToShow {
    if (filters == nil || filters.count ==0 ){
        return 0;
    }
    int count = 0;
    NSArray *list = filters;
    NSArray *tempList = [list subarrayWithRange:NSMakeRange(itemToShow, list.count-itemToShow)];
    for (DDFiltersOptionM *filter in tempList){
        if(filter.selected.intValue == 1){
            count = count + 1;
        }
    }
    return count;
}

- (NSString *)getShowResultsTitleWithCount:(NSInteger)count {
    NSString *title = @"Show Results";
    if (count == 1) {
        title = [NSString stringWithFormat:@"Show %ld Result", count];
    }
    else {
        title = [NSString stringWithFormat:@"Show %ld Result", count];
    }
    return title;
}


- (void)mapPrevSelectedFilters:(NSArray*)filters {
    for (DDFiltersSectionM *filterSection in self.filtersData.filter_sections) {
        for (DDFiltersOptionM *option in filterSection.options) {
            for (DDFiltersOptionM *previousFilter in filters) {
                BOOL found = [previousFilter.uid isEqualToString:option.uid];
                if (found)
                    option.selected = @(1);
            }
        }
    }
}

-(NSArray*)getSelectedFilters {
    NSMutableArray *selected = [NSMutableArray new];
    for (DDFiltersSectionM *filterSection in self.filtersData.filter_sections) {
        for (DDFiltersOptionM *option in filterSection.options) {
            if (option.isSelected)
                [selected addObject:option];
        }
    }
    return selected;
}

- (NSDictionary *)getSelectedFiltersParams {
    NSMutableDictionary *params = [NSMutableDictionary new];
    for (DDFiltersOptionM *option in self.getSelectedFilters) {
        NSString *key = option.api_param_key;
        NSString *value = option.api_param_value;
        if (key == nil || value == nil) continue;
        NSMutableArray *ary = [params objectForKey:key];
        if (ary==nil) {
            ary = [NSMutableArray new];
        }
        [ary addObject:value];
        [params setObject:ary forKey:key];
    }
    return params;
}

- (NSDictionary *)getSelectedDeliveryFiltersParams {
    NSMutableDictionary *params = [NSMutableDictionary new];
    NSMutableArray *selected = [NSMutableArray new];
    for (DDFiltersOptionM *option in self.deliveryFiltersData.options) {
        if (option.isSelected && option.title.length)
            [selected addObject:option.title];
    }
    if (selected.count) {
        DDFiltersOptionM *option = self.deliveryFiltersData.options.firstObject;
        [params setObject:selected forKey:option.api_param_value];
    }
    return params;
}

-(NSMutableArray*)getSelectedDeliveryFilters {
    NSMutableArray *ary = [NSMutableArray new];
    for (DDFiltersOptionM *option in self.deliveryFiltersData.options) {
        if (option.isSelected)
            [ary addObject:option];
    }
    return ary;
}

#pragma mark - API Methods

-(DDFiltersApiModel*)loadedFilters {
    DDFiltersApiModel *api = [DDFiltersApiModel new];
    api.data = self.filtersData;
    api.success = @(1);
    return api;
}

-(void)fetchFiltersWithHUD:(BOOL)hud WithCompletion:(filtersCompletion)completion {
    __weak typeof(self) weakSelf = self;
    DDFiltersRequestM *requestM = [DDFiltersRequestM new];
    NSArray *previous = [self getSelectedFilters];
    if (previous.count) {
        requestM.custom_parameters = self.getSelectedFiltersParams.mutableCopy;
    }
    [DDNetworkManager.shared post:DDApisType_Filter_Get_Filters
                           showHUD:hud
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDFiltersApiModel *responseM = (DDFiltersApiModel *)model;
        weakSelf.filtersData = responseM.data;
        [weakSelf mapPrevSelectedFilters:previous];
        if (completion != nil) {
            completion(responseM, error);
        }
    }];
}

-(void)fetchDeliveryFiltersWithCompletion:(filtersCompletion)completion {
    __weak typeof(self) weakSelf = self;
    DDFiltersRequestM *requestM = [DDFiltersRequestM new];
    [requestM addCustomParams:@{@"delivery_cuisines": @(1)}];
    [DDNetworkManager.shared post:DDApisType_Filter_Get_Filters
                           showHUD:YES
                         withParam:requestM
                     andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDFiltersApiModel *responseM = (DDFiltersApiModel *)model;
        for (DDFiltersSectionM *section in responseM.data.filter_sections) {
            if ([section.section_identifier isEqualToString:@"cuisine"]) {
                responseM.data.options = section.options;
                responseM.data.minimum_option_display = section.minimum_option_display;
                break;
            }
        }
        weakSelf.deliveryFiltersData = responseM.data;
        if (completion != nil) {
            completion(responseM, error);
        }
    }];
}
-(void)outletCountForSelectedFilters:(DDBaseRequestModel *)requestM andCompletion:(filtersCompletion)completion {
    [DDNetworkManager.shared post:DDApisType_Filter_Get_Count showHUD:NO withParam:requestM andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDFiltersApiModel *apiModel = model;
        completion(apiModel, error);
    }];
    
}

@end
