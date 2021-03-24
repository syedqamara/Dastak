//
//  UIFont+DDSEFont.h
//  DDSE_Example
//
//  Created by Raheel on 06/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (DDFont)

+ (UIFont *)DDLightFont:(float)size;
+ (UIFont *)DDRegularFont:(float)size;
+ (UIFont *)DDBoldFont:(float)size;
+ (UIFont *)DDMediumFont:(float)size;
+ (UIFont *)DDSemiBoldFont:(float)size;
+ (UIFont *)DDHeavyFont:(float)size;
@end

NS_ASSUME_NONNULL_END
