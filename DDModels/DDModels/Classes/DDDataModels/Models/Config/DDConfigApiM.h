//
//  DDConfigApiM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 05/09/2020.
//

#import "DDBaseApiModel.h"
#import "DDConfigDataM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDConfigApiM : DDBaseApiModel
@property (strong, nonatomic) DDConfigDataM <Optional> *data;
@end

NS_ASSUME_NONNULL_END
