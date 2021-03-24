//
//  DDPingsReceivedVC.h
//  DDPingsUI
//
//  Created by Hafiz Aziz on 29/01/2020.
//

#import "DDPingsBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPingsReceivedVC : DDPingsBaseVC
@property (nonatomic, copy) void (^callBackAfterDataLoaded)(DDPingSectionModel * model);
@end

NS_ASSUME_NONNULL_END
