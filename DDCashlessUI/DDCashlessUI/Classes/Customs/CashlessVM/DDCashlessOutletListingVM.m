//
//  DDCashlessOutletListingVM.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 24/03/2020.
//

#import "DDCashlessOutletListingVM.h"
#import "DDCashlessUIConstants.h"

@implementation DDCashlessOutletListingSectionVM

- (DDCOListingSectionVMType)type {
    if ([self.section_identifier isEqualToString:FILTERS_SECTION]) {
        return DDCOListingSectionVMTypeFilters;
    }
    if ([self.section_identifier isEqualToString:OUTLETS_SECTION]) {
        return DDCOListingSectionVMTypeOutlets;
    }
    return DDCOListingSectionVMTypeUnknow;
}

@end

@implementation DDCashlessOutletListingVM

-(DDCashlessOutletListingSectionVM*)newOutletSection {
    DDCashlessOutletListingSectionVM *section = [DDCashlessOutletListingSectionVM new];
    section.section_identifier = OUTLETS_SECTION;
    return section;
}

-(DDCashlessOutletListingSectionVM*)outletSection {
    DDCashlessOutletListingSectionVM *section;
    if (self.sections.count == 0) {
        self.sections = [NSMutableArray<DDCashlessOutletListingSectionVM, Optional> new];
        section = [self newOutletSection];
        [self.sections addObject:section];
    }
    else {
        for (DDCashlessOutletListingSectionVM *sec in self.sections) {
            if (sec.type == DDCOListingSectionVMTypeOutlets) {
                section = sec;
            }
        }
    }
    if (section == nil) { // means other sections are added into array
        section = [self newOutletSection];
        [self.sections addObject:section];
    }
    return section;
}

-(DDCashlessOutletListingSectionVM*)newFiltersSection {
    DDCashlessOutletListingSectionVM *section = [DDCashlessOutletListingSectionVM new];
    section.section_identifier = FILTERS_SECTION;
    section.section_title = @"Popular Cuisines";
    section.section_subtitle = @"View All";
    return section;
}

-(DDCashlessOutletListingSectionVM*)filterSection {
    DDCashlessOutletListingSectionVM *section;
    if (self.sections.count == 0) {
        self.sections = [NSMutableArray<DDCashlessOutletListingSectionVM, Optional> new];
        section = [self newFiltersSection];
        [self.sections addObject:section];
    }
    else {
        for (DDCashlessOutletListingSectionVM *sec in self.sections) {
            if (sec.type == DDCOListingSectionVMTypeFilters) {
                section = sec;
            }
        }
    }
    if (section == nil) { // means other sections are added into array
        section = [self newFiltersSection];
        [self.sections insertObject:section atIndex:0];
    }
    return section;
}

-(void)setUpApiDataIntoVM:(id)apiData {
    
    if (apiData == nil) return;
    
    if ([apiData isKindOfClass:[DDOutletApiM class]]) {
        DDCashlessOutletListingSectionVM *section = [self outletSection];
        DDOutletApiM *newData = (DDOutletApiM*)apiData;
        if (section.outlets == nil || newData.data.offset.intValue == 0) {
            section.outlets = [NSMutableArray<DDOutletM, Optional> new];
        }
        section.outlets = [[section.outlets arrayByAddingObjectsFromArray:newData.data.outlets] mutableCopy];
        section.section_title = [NSString stringWithFormat:@"%ld Outlets", section.outlets.count];
    }
    else if ([apiData isKindOfClass:[DDFiltersApiModel class]]) {
        DDFiltersApiModel *newData = (DDFiltersApiModel*)apiData;
        if (newData.data.options.count == 0) return;
        DDCashlessOutletListingSectionVM *section = [self filterSection];
        section.filtersData = newData.data;
    }
    
}

@end
