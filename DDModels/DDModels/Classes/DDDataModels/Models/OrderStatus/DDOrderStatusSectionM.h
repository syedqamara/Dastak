//
//  DDOrderStatusSectionM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/07/2020.
//

#import "DDBaseModel.h"
#import "DDOrderDetailM.h"
#import "DDOrderStatusM.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger, DDOrderStatusSectionType){
    DDOrderStatusSectionTypeStatus,
    DDOrderStatusSectionTypeMerchantInfo,
    DDOrderStatusSectionTypeDeliveryInfo,
    DDOrderStatusSectionTypeDriverInfo,
    DDOrderStatusSectionTypeDetail,
    DDOrderStatusSectionTypeUnknown,
};

@interface DDOrderStatusSectionM : DDBaseModel
@property (strong, nonatomic) NSString <Optional>*title;
@property (strong, nonatomic) NSString <Optional>*sub_title;
@property (strong, nonatomic) NSString <Optional>*status_title;
@property (strong, nonatomic) NSString <Optional>*status_title_color;
@property (strong, nonatomic) NSString <Optional>*identifier;
@property (strong, nonatomic) NSString <Optional>*image_url;
@property (strong, nonatomic) NSString <Optional>*phone_number;
@property (strong, nonatomic) DDOrderDetailM <Optional>*order_detail;
@property (strong, nonatomic) NSArray <DDOrderStatusM, Optional> *statuses;
-(DDOrderStatusSectionType)type;
@property (strong, nonatomic) NSNumber <Optional> *is_expanded;
@property (strong, nonatomic) NSNumber <Optional> *is_expandable;

-(BOOL)isExpanded;
-(BOOL)isExpandable;
-(void)toggle;
-(NSArray <NSDictionary *> *)charts;
@end

NS_ASSUME_NONNULL_END
