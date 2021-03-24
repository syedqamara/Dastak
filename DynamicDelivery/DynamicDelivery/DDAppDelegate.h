//
//  DDAppDelegate.h
//  dynamicdelivery
//
//  Created by etDev24 on 12/24/2019.
//  Copyright (c) 2019 etDev24. All rights reserved.
//

@import UIKit;
#import "ABKInAppMessageControllerDelegate.h"
#import <AppboyKit.h>

@interface DDAppDelegate : UIResponder <UIApplicationDelegate, ABKInAppMessageControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
@interface DDApplication : UIApplication

@end
