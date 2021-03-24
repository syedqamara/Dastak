//
//  DDFilterSectionM.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 20/07/2020.
//

#import "DDFilterSectionM.h"

@implementation DDFilterSectionM
-(DDFilterSectionType)type {
    if ([self.section_identifier.lowercaseString isEqualToString:@"filter_checkbox"]) {
        return DDFilterSectionTypeCheckbox;
    }
    if ([self.section_identifier.lowercaseString isEqualToString:@"filter_buttons"]) {
        return DDFilterSectionTypeButtons;
    }
    return DDFilterSectionTypeNone;
}
@end
