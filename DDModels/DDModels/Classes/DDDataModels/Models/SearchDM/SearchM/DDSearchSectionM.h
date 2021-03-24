//
//  DDSearchSectionM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 05/07/2020.
//

#import "DDBaseModel.h"
#import "DDSearchSectionListM.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, DDSearchSectionType) {
    DDSearchSectionTypeMerchant,
    DDSearchSectionTypeRecentSearches,
    DDSearchSectionTypeItems,
    DDSearchSectionTypeUnknown,
};
@interface DDSearchSectionM : DDBaseModel
@property (strong, nonatomic) NSString <Optional> *section_title;
@property (strong, nonatomic) NSString <Optional> *section_identifier;
@property (strong, nonatomic) NSMutableArray <DDSearchSectionListM,Optional> *section_list;
-(DDSearchSectionType)type;
@end

NS_ASSUME_NONNULL_END
