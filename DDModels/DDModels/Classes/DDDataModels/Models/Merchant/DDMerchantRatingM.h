//
//  DDMerchantRatingM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 19/07/2020.
//

#import "DDBaseModel.h"
#import "DDJSONModelProtocols.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantRatingReviewsM : DDBaseModel
@property (strong,nonatomic) NSString <Optional> *title;
@property (strong,nonatomic) NSString <Optional> *sub_title;
@property (strong,nonatomic) NSString <Optional> *review_text;
@property (strong,nonatomic) NSNumber <Optional> *rate;
@end

@interface DDMerchantRatingM : DDBaseModel
@property (strong,nonatomic) NSNumber <Optional> *max_rate;
@property (strong,nonatomic) NSNumber <Optional> *rate;
@property (strong,nonatomic) NSString <Optional> *review_title;
@property (strong,nonatomic) NSString <Optional> *review_subtitle;
@property (strong,nonatomic) NSArray <DDMerchantRatingReviewsM,Optional> *reviews;
-(NSInteger)maxRate;
@end

NS_ASSUME_NONNULL_END
