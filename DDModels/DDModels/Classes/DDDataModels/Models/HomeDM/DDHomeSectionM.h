//
//  DDHomeSectionM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 28/06/2020.
//

#import "DDBaseModel.h"
#import "DDHomeSectionAttributeM.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DDHomeSectionType) {
    DDHomeSectionTypeExplore,
    DDHomeSectionTypeFeature,
    DDHomeSectionTypeUnknown,
};

@interface DDHomeSectionListM : DDBaseModel
@property (nonatomic, strong) NSString <Optional> *title;
@property (nonatomic, strong) NSString <Optional> *image_url;
@property (nonatomic, strong) NSString <Optional> *background_color;
@property (nonatomic, strong) NSString <Optional> *delivery_time;
@property (nonatomic, strong) NSString <Optional> *delivery_time_unit;
@property (nonatomic, strong) NSNumber <Optional> *merchant_id;
@property (nonatomic, strong) NSNumber <Optional> *outlet_id;
@property (nonatomic, strong) NSNumber <Optional> *category_id;
@property (nonatomic, strong) NSMutableArray <DDHomeSectionAttributeM,Optional> *tile_attribute;
@property (nonatomic, strong) NSMutableArray <DDHomeSectionAttributeM,Optional> *attributes;
@property (nonatomic, strong) NSDictionary <Optional> *api_params;
- (NSDictionary *)toApiDictionary;

@end

@interface DDHomeSectionM : DDBaseModel
@property (nonatomic, strong) NSString <Optional> *section_title;
@property (nonatomic, strong) NSString <Optional> *section_identifier;
@property (nonatomic, strong) NSDictionary <Optional> *api_param;
@property (nonatomic, strong) NSMutableArray <DDHomeSectionListM,Optional> *section_list;
-(DDHomeSectionType)type;
@end



NS_ASSUME_NONNULL_END
