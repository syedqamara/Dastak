//
//  DDLocationsData.h
//  DDModels
//
//  Created by Zubair Ahmad on 04/02/2020.
//

#import "DDBaseApiModel.h"
#import "DDLocationsM.h"
#import "DDJSONModelProtocols.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDLocationsData : DDBaseApiModel
@property (nonatomic, strong) NSArray <DDLocationsM,Optional> *locations;

@end

NS_ASSUME_NONNULL_END
