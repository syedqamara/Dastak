//
//  DDFiltersApiM.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 19/07/2020.
//

#import "DDFiltersApiM.h"

@implementation DDFiltersApiM
-(NSMutableArray<DDFilterSectionListM *> *)selected_filters {
    NSMutableArray *arr = [NSMutableArray new];
    for (DDFilterSectionM *filter in self.data.filters) {
        for (DDFilterSectionListM *opt in filter.section_list) {
            if (opt.isSelected) {
                [arr addObject:opt];
            }
        }
    }
    return arr;
}
-(NSDictionary *)selected_filter_param {
    NSMutableArray *arr = [self selected_filters];
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (DDFilterSectionListM *opt in arr) {
        [dict addEntriesFromDictionary:opt.toFilterDictionary];
    }
    return dict;
}
-(void)reset {
    for (DDFilterSectionM *filter in self.data.filters) {
        for (DDFilterSectionListM *opt in filter.section_list) {
            opt.is_selected = @(NO);
        }
    }
}
@end
@implementation DDFiltersDataM

@end
