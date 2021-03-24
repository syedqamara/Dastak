//
//  DDReceivedPingsHFV.h
//  DDPingsUI
//
//  Created by Hafiz Aziz on 30/01/2020.
//

#import "DDBaseHFV.h"
#import <DDPingsUI.h>
#import <UIKit/UIKit.h>
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>
#import "DDPingBaseHFV.h"
#import <DDAuth/DDAuth.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDReceivedPingsHFV : DDPingBaseHFV
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;


@end

NS_ASSUME_NONNULL_END
