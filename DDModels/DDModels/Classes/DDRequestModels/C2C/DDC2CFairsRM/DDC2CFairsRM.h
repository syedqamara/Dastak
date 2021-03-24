//
//  DDC2CFairsRM.h
//  DDHome
//
//  Created by Syed Qamar Abbas on 16/10/2020.
//

#import "DDBaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDC2CFairsRM : DDBaseRequestModel
@property (strong, nonatomic) NSNumber <Optional> *pick_up_lat;
@property (strong, nonatomic) NSNumber <Optional> *pick_up_lng;
@property (strong, nonatomic) NSNumber <Optional> *drop_off_lat;
@property (strong, nonatomic) NSNumber <Optional> *drop_off_lng;

@end

NS_ASSUME_NONNULL_END




