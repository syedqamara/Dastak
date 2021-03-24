//
//  DDAppConfiguration.m
//  dynamicdelivery_Example
//
//  Created by Syed Qamar Abbas on 30/12/2019.
//  Copyright © 2019 etDev24. All rights reserved.
//

#import "DDAppConfiguration.h"
#import <DDCommons.h>
#import "DDEncryption.h"
#import <DDStorage/DDStorage.h>
#import "DDEditConfigM.h"
#import "DDEditConfigManager.h"
#import "DDUI.h"
#define DF_SAVE_CONFIG_KEY @"_saved_api_config"

@implementation DDAppConfiguration

+(void)loadAppConfig {
    DDCAppConfigManager.shared.SSL_CERTIFICATE_NAME = @"*dynamicdeliverycom";
    DDCAppConfigManager.shared.SSL_CERTIFICATE_EXTENSION = @"crt";
    DDCAppConfigManager.shared.isEditConfigAllowed = [self shouldAllowURLChange];
    [DDCAppConfigManager.shared setApiConfig:[self selectedApiConfig] andAppConfig:[self appConfigDic]];
    
}

+(NSDictionary *) selectedApiConfig{
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    DDBuildConfig build = [self buildType];
    if ([self getCachedApiConfig].count > 0) {
        return [self getCachedApiConfig];
    }
    if (build == DDBuildConfigDEVNode){
        //Load V6 Based Api Configurations
        [params addEntriesFromDictionary:[self devDic]];
        //Load Micro Services Based Api Configurations
//        [params addEntriesFromDictionary:[self MS_devDic]];
    } else if (build == DDBuildConfigQANode){
        [params addEntriesFromDictionary:[self qaDic]];
//        [params addEntriesFromDictionary:[self MS_qaDic]];
    } else if (build == DDBuildConfigUATNode){
        [params addEntriesFromDictionary:[self uatDic]];
//        [params addEntriesFromDictionary:[self MS_uatDic]];
    } else if (build == DDBuildConfigPRODNode){
        [params addEntriesFromDictionary:[self prodDic]];
//        [params addEntriesFromDictionary:[self MS_prodDic]];
    } else if (build == DDBuildConfigEBRYXNode){
        [params addEntriesFromDictionary:[self ebrixDic]];
//        [params addEntriesFromDictionary:[self MS_ebryxDic]];
    } else if (build == DDBuildConfigRCNode){
        [params addEntriesFromDictionary:[self rcDic]];
//        [params addEntriesFromDictionary:[self MS_rcDic]];
    }else {
        [params addEntriesFromDictionary:[self uatDic]];
//        [params addEntriesFromDictionary:[self MS_uatDic]];
    }
    
    return params;
}







+(NSMutableDictionary*)appConfigDic{
    NSMutableDictionary  * config = [[NSMutableDictionary alloc]init];
    
    config = [  @{
                  @"APPLICATION_DEEPLINK_SCHEME": @"dynamicdelivery://",
                  @"END_USER_LIS_AGR":@"https://dynamicdelivery.net/content/terms-and-conditions",
                  @"HELP_PAGE":@"https://dynamicdelivery.net/content/help",
                  @"CONTACT_US": @"https://dynamicdelivery.net/content/contact-us",
                  @"PRIVACY_POLICY_URL":@"https://dynamicdelivery.net/content/privacy-policy"
                  }mutableCopy];
    return config;
}

//MARK: - ApiConfig (Self)

+(NSDictionary*)devDic{
    return @{
            @"CASHLESS_CART_URL":@"https://dd.thewowmedia.com/payment/delivery",
            @"C2C_CART_URL": @"https://dd.thewowmedia.com/c2c/cart",
            @"ENCRYPTION_KEY":@"f473e2126c3c56ab098786c4a55b44d",
            @"ENCRYPTION_IV":@"f473e2126c3c56ab0",
            @"API_PASSWORD":@"k$V}B*(6DK5ymTNbH?4<rj3uGF;[~t>q",
            @"API_URL":@"https://uat.thewowmedia.com/api/v1/",
            @"API_USER":@"qlzfqghpkeiwhmzg",
            @"GOOGLE_API_KEY":@"AIzaSyDUpUvczaHG6QnalGoqdMMc4MKJyRr27YQ",
            @"GOOGLE_SIGNIN_API_KEY":@"949948782015-dmc30mb8me88r0360k0u34jk7btf76j0.apps.googleusercontent.com",
             };
}

+(NSDictionary*)qaDic{
    return @{
            @"CASHLESS_CART_URL":@"https://uat.dynamicdelivery.net/payment/delivery",
            @"C2C_CART_URL": @"https://uat.dynamicdelivery.net/c2c/cart",
            @"ENCRYPTION_KEY":@"f473e2126c3c56ab098786c4a55b44d",
            @"ENCRYPTION_IV":@"f473e2126c3c56ab0",
            @"API_PASSWORD":@"k$V}B*(6DK5ymTNbH?4<rj3uGF;[~t>q",
            @"API_URL":@"uat.api.dynamicdelivery.net",
            @"API_USER":@"qlzfqghpkeiwhmzg",
            @"GOOGLE_API_KEY":@"AIzaSyDUpUvczaHG6QnalGoqdMMc4MKJyRr27YQ",
            @"GOOGLE_SIGNIN_API_KEY":@"949948782015-dmc30mb8me88r0360k0u34jk7btf76j0.apps.googleusercontent.com",
             };
}


+(NSDictionary*)uatDic{
    return @{
        @"CASHLESS_CART_URL":@"https://uat.dynamicdelivery.net/payment/delivery",
        @"C2C_CART_URL": @"https://uat.dynamicdelivery.net/c2c/cart",
        @"ENCRYPTION_KEY":@"f473e2126c3c56ab098786c4a55b44d",
        @"ENCRYPTION_IV":@"f473e2126c3c56ab0",
        @"API_PASSWORD":@"k$V}B*(6DK5ymTNbH?4<rj3uGF;[~t>q",
        @"API_URL":@"https://uat.api.dynamicdelivery.net/api/v1/",
        @"API_USER":@"qlzfqghpkeiwhmzg",
        @"GOOGLE_API_KEY":@"AIzaSyDUpUvczaHG6QnalGoqdMMc4MKJyRr27YQ",
        @"GOOGLE_SIGNIN_API_KEY":@"949948782015-dmc30mb8me88r0360k0u34jk7btf76j0.apps.googleusercontent.com",
         };
}



+(NSDictionary*)prodDic{
    return @{
            @"CASHLESS_CART_URL":@"https://dynamicdelivery.net/payment/delivery",
            @"C2C_CART_URL": @"https://dynamicdelivery.net/c2c/cart",
            @"ENCRYPTION_KEY":@"f473e2126c3c56ab098786c4a55b44d",
            @"ENCRYPTION_IV":@"f473e2126c3c56ab0",
            @"API_PASSWORD":@"k$V}B*(6DK5ymTNbH?4<rj3uGF;[~t>q",
            @"API_URL":@"https://api.dynamicdelivery.net/api/v1/",
            @"API_USER":@"qlzfqghpkeiwhmzg",
            @"GOOGLE_API_KEY":@"AIzaSyDUpUvczaHG6QnalGoqdMMc4MKJyRr27YQ",
            @"GOOGLE_SIGNIN_API_KEY":@"949948782015-dmc30mb8me88r0360k0u34jk7btf76j0.apps.googleusercontent.com",
             };
}
+(NSDictionary*)rcDic{
    return @{
            @"CASHLESS_CART_URL":@"https://dd.thewowmedia.com/payment/delivery",
            @"C2C_CART_URL": @"https://dd.thewowmedia.com/c2c/cart",
            @"ENCRYPTION_KEY":@"f473e2126c3c56ab098786c4a55b44d",
            @"ENCRYPTION_IV":@"f473e2126c3c56ab0",
            @"API_PASSWORD":@"k$V}B*(6DK5ymTNbH?4<rj3uGF;[~t>q",
            @"API_URL":@"https://uat.thewowmedia.com/api/v1/",
            @"API_USER":@"qlzfqghpkeiwhmzg",
            @"GOOGLE_API_KEY":@"AIzaSyDUpUvczaHG6QnalGoqdMMc4MKJyRr27YQ",
            @"GOOGLE_SIGNIN_API_KEY":@"949948782015-dmc30mb8me88r0360k0u34jk7btf76j0.apps.googleusercontent.com",
    };
}

+(NSDictionary*)ebrixDic{
    return @{
            @"CASHLESS_CART_URL":@"https://dd.thewowmedia.com/payment/delivery",
            @"C2C_CART_URL": @"https://dd.thewowmedia.com/c2c/cart",
            @"ENCRYPTION_KEY":@"f473e2126c3c56ab098786c4a55b44d",
            @"ENCRYPTION_IV":@"f473e2126c3c56ab0",
            @"API_PASSWORD":@"k$V}B*(6DK5ymTNbH?4<rj3uGF;[~t>q",
            @"API_URL":@"https://uat.thewowmedia.com/api/v1/",
            @"API_USER":@"qlzfqghpkeiwhmzg",
            @"GOOGLE_API_KEY":@"AIzaSyDUpUvczaHG6QnalGoqdMMc4MKJyRr27YQ",
            @"GOOGLE_SIGNIN_API_KEY":@"949948782015-dmc30mb8me88r0360k0u34jk7btf76j0.apps.googleusercontent.com",
    };
}

//MARK: - ApiConfig (MicroServices)
//
//+(NSDictionary *)MS_devDic {
//    return @{
//        @"JWT_SECRET_KEY":@"156-7890--v614",
//        @"JWT_API_KEY":@"12345678-9012-3456-7890--v614",
//        @"MS_USER_API_URL":@"https://userqasvr.etenvbiz.com/api_ets/v4/",
//        @"MS_CONFIG_API_URL": @"https://configqasvr.etenvbiz.com/api_ets/v4/"
//    };
//}
//+(NSDictionary *)MS_qaDic {
//    return @{
//        @"JWT_SECRET_KEY":@"156-7890--v614",
//        @"JWT_API_KEY":@"12345678-9012-3456-7890--v614",
//        @"MS_USER_API_URL":@"https://userqasvr.etenvbiz.com/api_ets/v4/",
//        @"MS_CONFIG_API_URL": @"https://configqasvr.etenvbiz.com/api_ets/v4/"
//    };
//}
//+(NSDictionary *)MS_uatDic {
//    return @{
//        @"JWT_SECRET_KEY":@"156-7890--v614",
//        @"JWT_API_KEY":@"12345678-9012-3456-7890--v614",
//        @"MS_USER_API_URL":@"https://userqasvr.etenvbiz.com/api_ets/v4/",
//        @"MS_CONFIG_API_URL": @"https://configqasvr.etenvbiz.com/api_ets/v4/"
//    };
//}
//+(NSDictionary *)MS_rcDic {
//    return @{
//        @"JWT_SECRET_KEY":@"156-7890--v614",
//        @"JWT_API_KEY":@"12345678-9012-3456-7890--v614",
//        @"MS_USER_API_URL":@"https://userqasvr.etenvbiz.com/api_ets/v4/",
//        @"MS_CONFIG_API_URL": @"https://configqasvr.etenvbiz.com/api_ets/v4/"
//    };
//}
//+(NSDictionary *)MS_prodDic {
//    return @{
//        @"JWT_SECRET_KEY":@"156-7890--v614",
//        @"JWT_API_KEY":@"12345678-9012-3456-7890--v614",
//        @"MS_USER_API_URL":@"https://userqasvr.etenvbiz.com/api_ets/v4/",
//        @"MS_CONFIG_API_URL": @"https://configqasvr.etenvbiz.com/api_ets/v4/"
//    };
//}
//+(NSDictionary *)MS_ebryxDic {
//    return @{
//        @"JWT_SECRET_KEY":@"156-7890--v614",
//        @"JWT_API_KEY":@"12345678-9012-3456-7890--v614",
//        @"MS_USER_API_URL":@"https://userqasvr.etenvbiz.com/api_ets/v4/",
//        @"MS_CONFIG_API_URL": @"https://configqasvr.etenvbiz.com/api_ets/v4/"
//    };
//}

+(DDBuildConfig)buildType {
    NSInteger type = [DDSharedPreferences.shared integerforKeyDF:DD_BUNDLE_BUILD_CONFIG_KEY];
    NSInteger firstTimeConfig = [self firstirstTimeSelectedConfig];
    if (firstTimeConfig == 0) {
        if (DD_DEV) {
            type = 1;
        }
        else if (DD_QA) {
            type = 2;
        }
        else if (DD_UAT) {
            type = 3;
        }
        else if (DD_RC) {
            type = 4;
        }
        else if (DD_PROD) {
            type = 5;
        }
        else if (DD_EYBRIX) {
            type = 6;
        }
        [self setFirstTimeSelectedConfig:type];
    }
    if (type == 0){
        type = 3;
    }
    [DDSharedPreferences.shared setIntegerDF:type forKey:DD_BUNDLE_BUILD_CONFIG_KEY];
    return type;
}


+(void)setFirstTimeSelectedConfig:(NSInteger)isOn {
    [DDSharedPreferences.shared setBoolDF:isOn forKey:@"firstTimeSelectedConfig"];
}
+(NSInteger)firstirstTimeSelectedConfig {
    return [DDSharedPreferences.shared integerforKeyDF:@"firstTimeSelectedConfig"];
}
+(BOOL)shouldAllowURLChange {
    return [DDSharedPreferences.shared boolforKeyDF:DD_BUNDLE_URL_CHANGE_KEY];
}
+(NSArray <DDEditConfigM *>*)editableConfigurations {
    NSDictionary *dict = DDCAppConfigManager.shared.api_config.toDictionary;
    NSMutableArray <DDEditConfigM *>*arr = [NSMutableArray new];
    for (NSString *key in dict.allKeys) {
        DDEditConfigM *config = [DDEditConfigM new];
        config.key = key;
        config.data = dict[key];
        config.title = [key snakeToUpperCammel]; // is_valid_to (Snake)==> Is Valid To(Upper Cammel)
        [arr addObject:config];
    }
    return arr;
}
+(void)cachedApiConfig:(NSDictionary *)dict {
    [DDSharedPreferences.shared setObjectDF:dict forKey:DF_SAVE_CONFIG_KEY];
}
+(NSDictionary *)getCachedApiConfig {
    NSDictionary *dict = [DDSharedPreferences.shared objectforKeyDF:DF_SAVE_CONFIG_KEY];
    return dict;
}
+(void)showEditConfigurationViewController {
    [DDEditConfigManager openEditOptions:[self editableConfigurations] onController:UIApplication.topMostController andCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        NSDictionary *updatedData = (NSDictionary *)data;
        if (identifier.length > 0) {
            if ([identifier isEqualToString:@"save"]) {
                if (updatedData.count > 0) {
                    [self cachedApiConfig:updatedData];
                }
            }
            else if ([identifier isEqualToString:@"reset"]){
                [self cachedApiConfig:@{}];
            }
            NSAssert(false, @"Configuration Changed. Please restart");
        }
        
    }];
}
+(BOOL)isEditConfigAlreadyDisplaying {
    return DDEditConfigManager.isAlreadyDisplaying;
}
@end
