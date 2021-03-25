//
//  DDAppConfiguration.h
//  dynamicdelivery_Example
//
//  Created by Syed Qamar Abbas on 30/12/2019.
//  Copyright © 2019 etDev24. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define IS_PROD_ENV 0
#define DD_PROD YES // Make sure to change KEYCHAIN_ACCESS_GROUP & APPS_GROUP_FOR_DEFAULTS for App store builds and remove .ent

#define DD_DEV NO
#define DD_QA NO
#define DD_UAT NO
#define DD_RC NO
#define DD_EYBRIX NO

#define DD_BUNDLE_BUILD_CONFIG_KEY @"bundle_build_type"
#define DD_CHANGE_THEME_WHILE_SHAKE @"bundle_theme_type"
#define DD_BUNDLE_URL_CHANGE_KEY @"bundle_allow_url_change"


typedef NS_ENUM (NSUInteger, DDBuildConfig){
    DDBuildConfigDEVNode = 1,
    DDBuildConfigQANode = 2,
    DDBuildConfigUATNode = 3,
    DDBuildConfigRCNode = 4,
    DDBuildConfigPRODNode = 5,
    DDBuildConfigEBRYXNode = 6
};

@interface DDAppConfiguration : NSObject
+(void) loadAppConfig;
+(BOOL)shouldAllowURLChange;
+(void)cachedApiConfig:(NSDictionary *)dict;
+(NSDictionary *)getCachedApiConfig;
+(void)showEditConfigurationViewController;
+(BOOL)isEditConfigAlreadyDisplaying;
+(DDBuildConfig)buildType;
@end

NS_ASSUME_NONNULL_END
