//
//  DDAccessories.h
//  DDConstants
//
//  Created by Syed Qamar Abbas on 06/02/2020.
//

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define DEVICE_OFFSET (CGRectGetWidth([UIScreen mainScreen].bounds)/320)
#define IPHONE_6_DEVICE_OFFSET (CGRectGetWidth([UIScreen mainScreen].bounds)/375)


#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5_GREATER (IS_IPHONE && SCREEN_MAX_LENGTH > 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X  (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)
#define IS_IPHONE_XS  (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)
#define IS_IPHONE_XR  (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 896.0)
#define IS_IPHONE_XS_MAX  (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 896.0)
#define IS_IPHONE_X_LATER  (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height >= 896.0)
#define IS_IPHONE_WITH_NOTCH_DEVICES (IS_IPHONE_X || IS_IPHONE_XR || IS_IPHONE_XS || IS_IPHONE_XS_MAX || IS_IPHONE_X_LATER)
