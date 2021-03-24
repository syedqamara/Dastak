//
//  DDSearchApiM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 05/07/2020.
//

#import "DDBaseApiModel.h"
#import "DDSearchSectionM.h"
NS_ASSUME_NONNULL_BEGIN



@interface DDSearchApiDataM : DDBaseModel
@property (strong, nonatomic) NSMutableArray <DDSearchSectionM,Optional> *results;
@end

@interface DDSearchApiM : DDBaseApiModel
@property (strong, nonatomic) DDSearchApiDataM <Optional> *data;
@end

NS_ASSUME_NONNULL_END
