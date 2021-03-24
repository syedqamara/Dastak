//
//  DDPingBaseTVC.h
//  DDPingsUI
//
//  Created by Hafiz Aziz on 06/02/2020.
//

#import "DDUIThemeTableViewCell.h"
#import "DDPingApiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPingBaseTVC : DDUIThemeTableViewCell

@property (nonatomic, copy) void (^callBackAfterPing)(DDPingApiModel * model);
@end

NS_ASSUME_NONNULL_END
