//
//  DDFilterSectionListM.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 20/07/2020.
//

#import "DDFilterSectionListM.h"

@implementation DDFilterSectionListM
-(BOOL)isSelected {
    if (self.is_selected != nil) {
        return self.is_selected.boolValue;
    }
    return NO;
}
-(void)toggleSelection {
    self.is_selected = @(![self isSelected]);
}
-(NSDictionary *)toFilterDictionary {
    if (self.api_param_name.length > 0 && self.api_param_value.length > 0 ) {
        return @{self.api_param_name : self.api_param_value};
    }
    return @{self.title: @"api_param_value"};
}
@end
