//
//  DDOrderHistoryApiM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 06/08/2020.
//

#import "DDBaseApiModel.h"
#import "DDOrderHistoryDataM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDOrderHistoryApiM : DDBaseApiModel
@property (strong, nonatomic) DDOrderHistoryDataM <Optional>*data;

@end

NS_ASSUME_NONNULL_END
