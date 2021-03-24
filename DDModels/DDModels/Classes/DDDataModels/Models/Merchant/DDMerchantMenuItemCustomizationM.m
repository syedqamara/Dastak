//
//  DDMerchantMenuItemCustomizationM.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 22/07/2020.
//

#import "DDMerchantMenuItemCustomizationM.h"

@implementation DDMerchantMenuItemCustomizationM
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"cust_id":@"id"}];
}
-(BOOL)isOpened {
    if (self.is_opened != nil) {
        return self.is_opened.boolValue;
    }
    return YES;
}
-(void)toggle {
    self.is_opened = @(![self isOpened]);
}
-(BOOL)allowSingleSelection {
    if (self.is_single_selection != nil) {
        if (self.is_single_selection.boolValue) {
            return YES;
        }
        return self.max_selected_count.integerValue == 1;
    }
    return NO;
}
-(void)resetAllSelection {
    for (DDMerchantMenuItemCustomizationOptionM *opt in self.options) {
        opt.is_selected = @(NO);
    }
}
-(void)select:(DDMerchantMenuItemCustomizationOptionM *)option {
    if (self.allowSingleSelection) {
        for (DDMerchantMenuItemCustomizationOptionM *opt in self.options) {
            opt.is_selected = @(NO);
        }
        option.is_selected = @(YES);
    }else {
        if ([self isAllowedToEnterMore]) {
            [option toggle];
        }else {
            if (option.isSelected) {
                option.is_selected = @(NO);
            }
        }
    }
}
-(BOOL)isMinSelected {
    NSInteger min = self.min_selected_count.integerValue;
    NSInteger count = 0;
    for (DDMerchantMenuItemCustomizationOptionM *opt in self.options) {
        if (opt.isSelected) {
            count++;
        }
    }
    return count == min;
}

-(BOOL)isAllowedToEnterMore {
    NSInteger max = self.max_selected_count.integerValue;
    NSInteger count = 0;
    for (DDMerchantMenuItemCustomizationOptionM *opt in self.options) {
        if (opt.isSelected) {
            count++;
        }
    }
    return count < max;
}
@end
