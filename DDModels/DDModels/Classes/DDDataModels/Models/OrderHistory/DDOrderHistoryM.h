//
//  DDOrderHistoryM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 06/08/2020.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDOrderHistoryM : DDBaseModel
@property (strong, nonatomic) NSNumber <Optional>* order_id;
@property (strong, nonatomic) NSString <Optional>* name;
@property (strong, nonatomic) NSString <Optional>* logo;
@property (strong, nonatomic) NSString <Optional>* date_time;
@property (strong, nonatomic) NSString <Optional>* delivery_address;
@property (strong, nonatomic) NSString <Optional>* order_status;
@property (strong, nonatomic) NSString <Optional>* order_status_color;
@property (strong, nonatomic) NSString <Optional>* order_status_icon;
@end

NS_ASSUME_NONNULL_END
