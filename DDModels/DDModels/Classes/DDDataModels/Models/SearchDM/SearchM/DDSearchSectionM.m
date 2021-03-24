//
//  DDSearchSectionM.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 05/07/2020.
//

#import "DDSearchSectionM.h"

@implementation DDSearchSectionM
-(DDSearchSectionType)type {
    if ([self.section_identifier isEqualToString:@"merchants"]) {
        return DDSearchSectionTypeMerchant;
    }
    if ([self.section_identifier isEqualToString:@"items"]) {
        return DDSearchSectionTypeItems;
    }
    if ([self.section_identifier isEqualToString:@"recent_searches"]) {
        return DDSearchSectionTypeRecentSearches;
    }
    return DDSearchSectionTypeUnknown;
}
@end
