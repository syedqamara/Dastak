//
//  DDOrderDetailM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/07/2020.
//

#import "DDBaseModel.h"
#import "DDOrderStatusItemM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDOrderDetailM : DDBaseModel


@property (strong, nonatomic) NSString <Optional>*sub_total;
@property (strong, nonatomic) NSString <Optional>*delivery;
@property (strong, nonatomic) NSString <Optional>*total;
@property (strong, nonatomic) NSString <Optional>*discount;
@property (strong, nonatomic) NSArray <DDOrderStatusItemM, Optional> *items;
@end

NS_ASSUME_NONNULL_END
