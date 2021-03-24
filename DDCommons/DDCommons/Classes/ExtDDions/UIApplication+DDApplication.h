//
//  UIApplication+DDApplicatio.h
//  DDSE_Example
//
//  Created by Raheel on 06/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (DDApplication)

+(UIViewController*) topMostController;
+(UIViewController*) visibleController;

+(void) showDDLoaderAnimation;
+(void) dismissDDLoaderAnimation;
+(BOOL) isLessTheniOS11;
+(BOOL) isInternetConnected;
+ (BOOL) isRightToLeftDeviceSettings;
+(void) refreshAppWithParams:(NSDictionary* _Nullable)params;

@end

NS_ASSUME_NONNULL_END
