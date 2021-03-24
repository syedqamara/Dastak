//
//  DDPingBaseHFV.h
//  DDPingsUI
//
//  Created by Hafiz Aziz on 06/02/2020.
//

#import "DDBaseHFV.h"
#import "DDPingApiModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDPingBaseHFV : DDBaseHFV

@property (nonatomic, copy) void (^callBackAfterAcceptAll)(DDPingApiModel * model);

@end

NS_ASSUME_NONNULL_END
