//
//  DDOutletM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 07/08/2020.
//

#import "DDBaseModel.h"
#import <DDHomeSectionAttributeM.H>
NS_ASSUME_NONNULL_BEGIN

@interface DDOutletM : DDBaseModel
@property (strong, nonatomic) NSNumber <Optional> *outlet_id;
@property (strong, nonatomic) NSNumber <Optional> *merchant_id;
@property (strong, nonatomic) NSNumber <Optional> *category_id;
@property (strong, nonatomic) NSString <Optional> *name;
@property (strong, nonatomic) NSString <Optional> *logo;
@property (strong, nonatomic) NSString <Optional> *opening_time;
@property (strong, nonatomic) NSString <Optional> *status_text;
@property (strong, nonatomic) NSString <Optional> *status_color;
@property (strong, nonatomic) NSDictionary <Optional> *api_params;
@property (strong, nonatomic) NSArray <DDHomeSectionAttributeM, Optional> *outlet_attribute;
-(NSAttributedString *)timeAttributedTextWithFont:(UIFont *)font withStaticColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
