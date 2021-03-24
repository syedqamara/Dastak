//
//  DDOrderStatusApiM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/07/2020.
//

#import "DDBaseApiModel.h"
#import "DDOrderStatusDataM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDOrderStatusApiM : DDBaseApiModel
@property (strong, nonatomic) DDOrderStatusDataM <Optional> *data;
@end

NS_ASSUME_NONNULL_END
