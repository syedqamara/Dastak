//
//  DDOutletApiM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 07/08/2020.
//

#import <UIKit/UIKit.h>
#import "DDOutletDataM.h"
#import "DDBaseApiModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDOutletApiM : DDBaseApiModel
@property (strong, nonatomic) DDOutletDataM <Optional>*data;
@end

NS_ASSUME_NONNULL_END
