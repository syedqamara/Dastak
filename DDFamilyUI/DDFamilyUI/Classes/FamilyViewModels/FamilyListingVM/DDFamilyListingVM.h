//
//  DDFamilyListingVM.h
//  DDModels
//
//  Created by Awais Shahid on 29/01/2020.
//

#import "JSONModel.h"
#import <DDModels/DDModels.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DDFamilyListingSectionVM <NSObject> @end
@protocol DDFamilyListingVM <NSObject> @end
@protocol DDFamilyListingActionVM <NSObject> @end

typedef NS_ENUM(NSInteger, DDFamilyListingSectionVMType) {
    DDFamilyListingSectionVMUnknown    = 0,
    DDFamilyListingSectionVMTree       = 1,
    DDFamilyListingSectionVMAction     = 2,
    DDFamilyListingSectionVMCreatedBy  = 3,
};


@interface DDFamilyListingSectionVM : JSONModel
@property (nonatomic, strong) NSString<Optional> *section_identifier;
@property (nonatomic, strong) NSString<Optional> *section_title;
@property (nonatomic, strong) NSString<Optional> *section_subtitle;
@property (nonatomic, strong) NSMutableArray<DDFamilyMemberM, Optional> *members_list;
@property (nonatomic, strong) NSMutableArray<DDFamilyListingActionVM, Optional> *actions_list;
-(DDFamilyListingSectionVMType)type;
@end

@interface DDFamilyListingActionVM : JSONModel
@property (nonatomic, strong) DDFamilyMemberInfoM<Optional> *member_info;
@end

@interface DDFamilyListingVM : JSONModel
@property (nonatomic, strong) NSArray<DDFamilyListingSectionVM, Optional> *family_listing_sections;
@property (nonatomic, strong) DDFamilyMemberInfoM<Optional> *member_info;
+(DDFamilyListingVM*)setUpApiDataIntoVM:(DDFamilyApiModel *)model;
@end




NS_ASSUME_NONNULL_END

