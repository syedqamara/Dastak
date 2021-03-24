//
//  DDLocationsAPIM.h
//  DDModels
//
//  Created by Zubair Ahmad on 04/02/2020.
//

#import "DDBaseApiModel.h"
#import "DDLocationsData.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDLocationsAPIM : DDBaseApiModel
@property (nonatomic, strong) DDLocationsData <Optional> * data;
@end

NS_ASSUME_NONNULL_END
