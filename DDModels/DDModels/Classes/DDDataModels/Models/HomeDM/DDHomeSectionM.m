//
//  DDHomeSectionM.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 28/06/2020.
//

#import "DDHomeSectionM.h"

#define EXPLORE_IDDDIFIER @"explore"
#define FEATURE_IDDDIFIER @"featured"


@implementation DDHomeSectionListM

- (NSDictionary *)toApiDictionary {
    if (self.category_id == nil) {
        return @{@"category_id": @(1)};
    }
    NSDictionary *dict = @{@"category_id": self.category_id};
    return dict;
}
@end


@implementation DDHomeSectionM
-(DDHomeSectionType)type{
    if ([self.section_identifier isEqualToString:EXPLORE_IDDDIFIER]) {
        return DDHomeSectionTypeExplore;
    }
    if ([self.section_identifier isEqualToString:FEATURE_IDDDIFIER]) {
        return DDHomeSectionTypeFeature;
    }
    return DDHomeSectionTypeUnknown;
}
@end
