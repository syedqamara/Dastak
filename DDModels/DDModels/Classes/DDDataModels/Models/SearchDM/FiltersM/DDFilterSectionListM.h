//
//  DDFilterSectionListM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 20/07/2020.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDFilterSectionListM : DDBaseModel
@property (strong, nonatomic) NSNumber <Optional> *is_selected;
@property (strong, nonatomic) NSString <Optional> *title;
@property (strong, nonatomic) NSString <Optional> *api_param_name;
@property (strong, nonatomic) NSString <Optional> *api_param_value;
@property (strong, nonatomic) NSString <Optional> *uid;
-(BOOL)isSelected;
-(void)toggleSelection;
-(NSDictionary *)toFilterDictionary;
@end

NS_ASSUME_NONNULL_END
