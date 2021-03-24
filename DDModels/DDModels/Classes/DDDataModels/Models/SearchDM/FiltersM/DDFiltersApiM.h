//
//  DDFiltersApiM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 19/07/2020.
//

#import "DDBaseApiModel.h"
#import "DDBaseModel.h"
#import "DDJSONModelProtocols.h"
#import "DDFilterSectionM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDFiltersDataM : DDBaseModel
@property (strong, nonatomic) NSArray <DDFilterSectionM,Optional>*filters;
@end

@interface DDFiltersApiM : DDBaseApiModel
@property (strong, nonatomic) DDFiltersDataM <Optional>*data;
-(NSDictionary *)selected_filter_param;
-(void)reset;
@end

NS_ASSUME_NONNULL_END
