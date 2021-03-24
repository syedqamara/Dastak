//
//  DDFilterSectionM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 20/07/2020.
//

#import "DDBaseModel.h"
#import "DDJSONModelProtocols.h"
#import "DDFilterSectionListM.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDFilterSectionType) {
    DDFilterSectionTypeCheckbox,
    DDFilterSectionTypeButtons,
    DDFilterSectionTypeNone,
};

@interface DDFilterSectionM : DDBaseModel
@property (strong, nonatomic) NSString <Optional> *section_title;
@property (strong, nonatomic) NSString <Optional> *section_identifier;
@property (strong, nonatomic) NSArray <DDFilterSectionListM,Optional> *section_list;
-(DDFilterSectionType)type;
@end

NS_ASSUME_NONNULL_END
