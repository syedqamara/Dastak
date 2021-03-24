//
//  DDFamilyListingVM.m
//  DDModels
//
//  Created by Awais Shahid on 29/01/2020.
//

#import "DDFamilyListingVM.h"
#import "DDFamilyUIConstants.h"

@implementation DDFamilyListingSectionVM

- (DDFamilyListingSectionVMType)type {
    if ([self.section_identifier isEqualToString:FamilyTree]) {
        return DDFamilyListingSectionVMTree;
    }
    if ([self.section_identifier isEqualToString:FamilyAction]) {
        return DDFamilyListingSectionVMAction;
    }
    if ([self.section_identifier isEqualToString:FamilyCreatedBy]) {
        return DDFamilyListingSectionVMCreatedBy;
    }
    return DDFamilyListingSectionVMUnknown;
}

@end




@implementation DDFamilyListingActionVM

@end




@implementation DDFamilyListingVM

+ (DDFamilyListingVM *)setUpApiDataIntoVM:(DDFamilyApiModel *)model {
        
    DDFamilyListingVM *temp = [DDFamilyListingVM new];
    NSMutableArray *sectionsAry = [NSMutableArray new];

    if (model.data.family_list_section.members.count > 0) {
        DDFamilyListingSectionVM *membersSectionVM = [DDFamilyListingSectionVM new];

        NSMutableArray *membersAry = [model.data.family_list_section.members mutableCopy];
        if(model.data.member_info.isPrimaryMember) {
            DDFamilyMemberM *new = [DDFamilyMemberM new];
            new.name = ADD_MEMBER;
            new.can_add_new_member = @(model.data.family_list_section.members.count < model.data.family_list_section.max_member_limit.intValue);
            [membersAry insertObject:new atIndex:0];
        }
        membersSectionVM.members_list = membersAry;

        membersSectionVM.section_identifier = FamilyTree;
        membersSectionVM.section_title = model.data.family_list_section.header_section.title;
        membersSectionVM.section_subtitle = model.data.family_list_section.header_section.limit_text;
        
        [sectionsAry addObject:membersSectionVM];
    }
    
    if (model.data.member_info != nil) {
        DDFamilyListingSectionVM *actionsSectionVM = [DDFamilyListingSectionVM new];

        DDFamilyListingActionVM *tempAction = [DDFamilyListingActionVM new];
        tempAction.member_info = model.data.member_info;
        actionsSectionVM.actions_list = [[NSMutableArray<DDFamilyListingActionVM, Optional> alloc] initWithObjects:tempAction, nil];

        actionsSectionVM.section_identifier = FamilyAction;
        [sectionsAry addObject:actionsSectionVM];
        temp.member_info = model.data.member_info;
    }
    
    DDFamilyListingSectionVM *footerSectionVM = [DDFamilyListingSectionVM new];
    footerSectionVM.section_identifier = FamilyCreatedBy;
    footerSectionVM.section_title = model.data.family_list_section.family_created_by;
    NSArray *dateStringComponents = [model.data.family_list_section.family_created_date componentsSeparatedByString:@" "];
    NSString *dateString = model.data.family_list_section.family_created_date;
    if (dateStringComponents && dateStringComponents.count > 0){
        dateString = dateStringComponents[0];
        dateString = [dateString getDayMonthYearDateStringWithSlashes];
        if (dateString == nil){
            dateString = model.data.family_list_section.family_created_date;
        }
    }
    dateString = [NSString stringWithFormat:@"Created at %@",dateString];
    footerSectionVM.section_subtitle = dateString;
    [sectionsAry addObject:footerSectionVM];
    
    temp.family_listing_sections = sectionsAry;
    return temp;
}


@end
