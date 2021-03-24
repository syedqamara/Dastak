//
//  DDOutletDataM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 07/08/2020.
//

#import "DDBaseModel.h"
#import "DDOutletM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDOutletDataM : DDBaseModel
@property (strong, nonatomic) NSMutableArray <DDOutletM, Optional> *outlets;
@property (strong, nonatomic) NSMutableArray <DDOutletM, Optional> *favorites;
@end

NS_ASSUME_NONNULL_END
