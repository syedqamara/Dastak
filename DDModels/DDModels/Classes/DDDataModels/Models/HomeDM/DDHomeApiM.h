//
//  DDHomeApiM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 28/06/2020.
//

#import "DDBaseApiModel.h"
#import "DDBaseModel.h"
#import "DDHomeSectionM.h"
#import "DDJSONModelProtocols.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDHomeDataM : DDBaseModel
@property (nonatomic, strong) NSMutableArray <DDHomeSectionListM,Optional> *c_2_c_goods_type;
@property (nonatomic, strong) NSMutableArray <DDHomeSectionM, Optional>*sections;
@end

@interface DDHomeApiM : DDBaseApiModel
@property (nonatomic, strong) DDHomeDataM <Optional> *data;
@end

NS_ASSUME_NONNULL_END
