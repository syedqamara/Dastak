//
//  DDCashlessDeliveryLocationsVM.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 20/02/2020.
//

#import "DDCashlessDeliveryLocationsVM.h"
#import "DDLocationsThemeManager.h"
#import "DDLocations.h"
#import <DDCommons/DDCommons.h>

@implementation DDCashlessDeliveryLocationsVM
+ (DDCashlessDeliveryLocationsVM *)setupDataFromSavedDeliveryArray:(NSArray *)adresses {
    DDCashlessDeliveryLocationsVM *data = [DDCashlessDeliveryLocationsVM new];
    NSMutableArray *sections = [NSMutableArray new];
    
    DDCashlessDeliveryLocationsSectionVM *new = [DDCashlessDeliveryLocationsSectionVM new];
    new.is_new_section = @(1);
    [sections addObject:new];
    
    DDCashlessDeliveryLocationsSectionVM *locations = [DDCashlessDeliveryLocationsSectionVM new];
    locations.is_current_section = @(1);
    
    NSMutableArray *arr = adresses.mutableCopy;
//    if (DDLocationsManager.shared.selectedCashlessDeliveryLocation != nil) {
//        [arr addObject:DDLocationsManager.shared.selectedCashlessDeliveryLocation];
//    }
    
    locations.locations = arr;
    [sections addObject:locations];
    
    data.sections = sections;
    return data;
}
@end


@implementation DDCashlessDeliveryLocationsSectionVM

- (BOOL)isNewSection {
    if (self.is_new_section != nil)
        return self.is_new_section.boolValue;
    return NO;
}

- (BOOL)isCurrentSection {
    if (self.is_current_section != nil)
        return self.is_current_section.boolValue;
    return NO;
}

- (BOOL)isManualSection {
    if (self.is_manual_section != nil)
        return self.is_manual_section.boolValue;
    return NO;
}

- (NSString<Optional> *)image {
    if (self.isNewSection) {
        return @"icContentAdd.png";
    }
    else if (self.isCurrentSection) {
        return @"ic-current-location.png";
    }
    else if (self.isManualSection) {
        return @"ic-current-location.png";
    }
    return nil;
}

- (NSString<Optional> *)title {
    if (self.isNewSection) {
        return @"Add a New Location".localized;
    }
    else if (self.isCurrentSection) {
        return @"Deliver to my current location".localized;
    }
    else if (self.isManualSection) {
        return @"Add Address Manually".localized;
    }
    return nil;
}

- (NSString<Optional> *)color {
    if (self.isNewSection || self.isManualSection) {
        return DDLocationsThemeManager.shared.selected_theme.text_theme;
    }
    else if (self.isCurrentSection) {
        return DDLocationsThemeManager.shared.selected_theme.text_black;
    }
    return nil;
}

@end
