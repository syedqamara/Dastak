//
//  DDMerchantRatingM.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 19/07/2020.
//

#import "DDMerchantRatingM.h"

@implementation DDMerchantRatingM

-(NSInteger)maxRate {
    if (self.max_rate == nil || self.max_rate.integerValue == 0) {
        return 5;
    }
    return self.max_rate.integerValue;
}
@end
@implementation DDMerchantRatingReviewsM

@end
