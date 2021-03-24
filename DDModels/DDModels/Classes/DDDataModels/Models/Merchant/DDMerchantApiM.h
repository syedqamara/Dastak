//
//  DDMerchantApiM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 19/07/2020.
//

#import "DDBaseApiModel.h"
#import "DDMerchantM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantDataM : DDBaseModel
@property (strong, nonatomic) DDMerchantM *merchant;
@end

@interface DDMerchantApiM : DDBaseApiModel
@property (strong, nonatomic) DDMerchantDataM <Optional> *data;
@end

NS_ASSUME_NONNULL_END
