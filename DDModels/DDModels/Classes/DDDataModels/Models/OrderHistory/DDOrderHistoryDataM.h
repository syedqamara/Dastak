//
//  DDOrderHistoryDataM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 06/08/2020.
//

#import "DDBaseModel.h"
#import "DDOrderHistoryM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDOrderHistoryDataM : DDBaseModel
@property (strong, nonatomic) NSArray <DDOrderHistoryM, Optional> *orders;
@end

NS_ASSUME_NONNULL_END
