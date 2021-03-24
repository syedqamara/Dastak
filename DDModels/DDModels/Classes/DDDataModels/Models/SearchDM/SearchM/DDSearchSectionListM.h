//
//  DDSearchSectionListM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 05/07/2020.
//

#import "DDBaseModel.h"
#import "DDJSONModelProtocols.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDSearchSectionListM : DDBaseModel
@property (strong, nonatomic) NSString <Optional> *title;
@property (strong, nonatomic) NSString <Optional> *image_url;
@property (strong, nonatomic) NSString <Optional> *sub_title;
@property (strong, nonatomic) NSString <Optional> *item_description;
@property (strong, nonatomic) NSNumber <Optional> *item_id;
@property (strong, nonatomic) NSNumber <Optional> *outlet_id;
@property (strong, nonatomic) NSNumber <Optional> *merchant_id;
@property (nonatomic, strong) NSNumber <Optional> *category_id;
@property (strong, nonatomic) NSString <Ignore> *search_text;
@property (strong, nonatomic) NSDictionary <Optional> *api_params;
@end

NS_ASSUME_NONNULL_END
