//
//  DDMerchantRM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/08/2020.
//

#import "DDBaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantRM : DDBaseRequestModel
@property (strong, nonatomic) NSString <Optional> *selected_delivery_lat;
@property (strong, nonatomic) NSString <Optional> *selected_delivery_lng;
@property (strong, nonatomic) NSNumber <Optional> *outlet_id;
@property (strong, nonatomic) NSNumber <Optional> *merchant_id;
@property (nonatomic, strong) NSNumber <Optional> *category_id;
@property (strong, nonatomic) NSNumber <Optional> *is_mark_fav;
-(BOOL)isValidMerchantRequest;
@end

NS_ASSUME_NONNULL_END
