//
//  DDC2CFairsM.h
//  DDHome
//
//  Created by Syed Qamar Abbas on 16/10/2020.
//

#import "DDBaseApiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDC2CFairsM : DDBaseApiModel
@property (strong, nonatomic) NSString <Optional> *charges;
@property (strong, nonatomic) NSString <Optional> *distance;
@property (strong, nonatomic) NSString <Optional> *time;

@property (strong, nonatomic) NSDictionary <Optional> *api_param;
@end

NS_ASSUME_NONNULL_END
