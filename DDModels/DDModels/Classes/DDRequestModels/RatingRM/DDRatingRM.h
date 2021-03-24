//
//  DDRatingRM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 10/09/2020.
//

#import "DDBaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDRatingRM : DDBaseRequestModel
@property (strong, nonatomic) NSNumber <Optional> *rating;
@property (strong, nonatomic) NSNumber <Optional> *outlet_id;
@property (strong, nonatomic) NSNumber <Optional> *merchant_id;
@property (strong, nonatomic) NSNumber <Optional> *order_id;
@property (strong, nonatomic) NSString <Optional> *merchant_name;
@property (strong, nonatomic) NSString <Optional> *additional_comment;
@end

NS_ASSUME_NONNULL_END
