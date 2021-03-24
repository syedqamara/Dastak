//
//  DDPingsHistoryVC.h
//  DDPingsUI
//
//  Created by Hafiz Aziz on 28/01/2020.
//

#import "DDUIBaseViewController.h"
#import <DDCommons/DDCommons.h>
#import <DDConstants/DDConstants.h>
#import <DDUI/DDUI.h>
#import <DDPings/DDPings.h>
#import "UITableView+DDRegistration.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDPingsHistoryVC : DDUIBaseViewController
@property (nonatomic, copy) void (^callBackAfterDataLoaded)(DDPingSectionModel * model, UIViewController *controller);
@end

NS_ASSUME_NONNULL_END
