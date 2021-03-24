//
//  DDAppConfiguration.m
//  theDDERTAINER_Example
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
#define DF_SAVE_CONFIG_KEY @"entertainer_saved_api_config"

@implementation DDAppConfiguration

+(void)loadAppConfig {
    DDCAppConfigManager.shared.SSL_CERTIFICATE_NAME = @"*theentertainermecom";
    DDCAppConfigManager.shared.SSL_CERTIFICATE_EXTENSION = @"crt";
    [DDCAppConfigManager.shared setApiConfig:[self selectedApiConfig] andAppConfig:[self appConfigDic]];
    DDCAppConfigManager.shared.isEditConfigAllowed = [self shouldAllowURLChange];
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
        [params addEntriesFromDictionary:[self MS_devDic]];
    } else if (build == DDBuildConfigQANode){
        [params addEntriesFromDictionary:[self qaDic]];
        [params addEntriesFromDictionary:[self MS_qaDic]];
    } else if (build == DDBuildConfigUATNode){
        [params addEntriesFromDictionary:[self uatDic]];
        [params addEntriesFromDictionary:[self MS_uatDic]];
    } else if (build == DDBuildConfigPRODNode){
        [params addEntriesFromDictionary:[self prodDic]];
        [params addEntriesFromDictionary:[self MS_prodDic]];
    } else if (build == DDBuildConfigEBRYXNode){
        [params addEntriesFromDictionary:[self ebrixDic]];
        [params addEntriesFromDictionary:[self MS_ebryxDic]];
    } else if (build == DDBuildConfigRCNode){
        [params addEntriesFromDictionary:[self rcDic]];
        [params addEntriesFromDictionary:[self MS_rcDic]];
    }else {
        [params addEntriesFromDictionary:[self uatDic]];
        [params addEntriesFromDictionary:[self MS_uatDic]];
    }
    
    return params;
}
+(NSMutableDictionary*)appConfigDic{
    NSMutableDictionary  * config = [[NSMutableDictionary alloc]init];
    
    config = [  @{
                  @"APPLICATION_DEEPLINK_SCHEME": @"entertainer://",
                  @"APP_GROUP_IDDDIFIER": @"",
                  @"BRANCH_SCHEME": @"entertainer.app.link",
                  @"BRANCH_SCHEME_TEST": @"entertainer.test-app.link",
                  @"BUY_PAGE" : @(0),
                  @"COMPANY_NAME" : @"slice",
                  @"IS_MULTILINE_MERCHANT_NAME" : @(0),
                  @"NEW_TAB" : @"SABB",
                  @"NEW_TAB_ORDER" : @(2),
                  @"PING_OPTION" : @(0),
                  @"PURCHASE_HISTORY" : @(0),
                  @"SIGNIN_ACTIVATION_MESSAGE" : @"Get your 9 digit Activation Code by calling Gulf Bank Customer Contact Center on +965 1805805:",
                  @"SIGNIN_VALIDATION_MESSAGE" : @"Sorry, we do not recognize the information you have entered.\\n\\nThis app is for use by Gulf Bank customers only. Please check your details and try again, alternatively you can call Gulf Bank on +965 1805805.",
                  @"SIGNIN_WELCOME_MESSAGE" : @"Welcome to the Gulf Bank Entertainer app.  Please complete the details below to register.",
                  @"VIP_KEY" : @(0),
                  @"WHITE_LABEL" : @(0),
                  @"APP_STORE_URL_241":@"https://itunes.apple.com/us/app/241passport/id1015294255?mt=8",
                  @"END_USER_LIS_AGR":@"https://www.theentertainerme.com/end-user-license-agreement?language=%@",
                  @"HELP_PAGE":@"https://hub.theentertainerme.com/article-categories/faqs?header=no&language=%@",
                  @"HOTEL_RULE_OF_USE":@"https://www.theentertainerme.com/hotel-rules-of-use?language=%@",
                  @"RULE_OF_USE":@"https://www.theentertainerme.com/rules-of-use?language=%@",
                  @"PRIVACY_POLICY_URL":@"https://www.theentertainerme.com/Privacy-Policy?language=%@&header=no"
                  }mutableCopy];
    return config;
}

//MARK: - ApiConfig (Self)

+(NSDictionary*)devDic{
    return @{
            @"ENCRYPTION_KEY":@"18b8c9ef473e2126c3c56ab0cb2b71cb",
            @"ENCRYPTION_IV":@"18b8c9ef473e2126",
             @"ANALYTICS_BASE_URL":@"https://dventapi.etenvbiz.com/api_analytics/web/v4/", @"REDEMPTION_HISTORY_URL":@"https://fkru86rv14.execute-api.eu-west-1.amazonaws.com/DEV/v2/",
             @"GOOGLE_CAPTCHA_URL": @"https://entcartut.theentertainerme.com/captcha/g-captcha.html",
             @"AMAZON_AUTHORIZATION_TOKEN":@"_aws_",
             @"API_GAMIFICATION_URL":@"https://dventapi.etenvbiz.com/gamify/web/v2/",
             @"G_U" : @"creativity",
             @"G_P" : @"HwJnm5_QP29ww_v6F7W",
             @"API_PASSWORD":@"k$V}B*(6DK5ymTNbH?4<rj3uGF;[~t>q",
             @"API_URL":@"https://dventapi.etenvbiz.com/et_rs_prd/web/v614/",
             @"API_USER":@"qlzfqghpkeiwhmzg",
             @"GOOGLE_API_KEY":@"AIzaSyBBEFrNt0SKTXdux772g7i7GqsYCy-VuGM",
             @"APPBOY_API_KEY":@"a387b1f9-a520-4082-b4ab-0c043e2f7f4f",
             @"BACKUP_API_URL":@"http://dventapi.etenvbiz.com/et_rs_prd/web/v610/",
             @"BADGE_URL":@"https://dventcart.etenvbiz.com/app/badges/%@?language=%@",
             @"CAREEM_API_TOKEN":@"6m9a6ak03p4k357fau4al8anng",
             @"CAREEM_API_URL":@"https://interface.careem.com/v1/",
             @"GAMIFICATION_KEY":@"YzZmY2QwMjUxZjM2MThlNTE0NDM3ZWQ3OWEyY2QxN2U",
             @"GOOGLE_TAG_MANAGER":@"GTM-P5J9QS",
             @"IS_SHOW_API_CHANGE":@"1",
             @"LEVEL_URL":@"https://dventcart.etenvbiz.com/app/levels/%@?language=%@",
             @"LIVE_SERVER_INTERVAL" : @"1",
             @"MERCHANT_SHARE_DETAIL_URL" : @"https://dventcart.etenvbiz.com/outlets/detail?m=%@&o=%@&language=%@",
             @"MESSAGING_BASE_URL" : @"http://dventapi.etenvbiz.com/messaging/api/web/",
             @"WALLET_LINK" : @"https://dventcart.etenvbiz.com/user-wallet?language=%@&app_version=%@&__t=%@",
             @"GETAWAY_API_URL" : @"https://dventapi.etenvbiz.com/et_rs_prd/test/getaways/v3/",
             @"HERMES_ENGAGEMDD_API_URL" : @"http://authhrmv3.entertainerebizservices.com",
             @"HERMES_ENGAGEMDD_COMPANY_KEY" : @"668bc31ce086154819ed9483f409d1b37f8fdcd7e118ac94fbecc4f9daaec79b"
             
             };
}

+(NSDictionary*)qaDic{
    return @{
            @"ENCRYPTION_KEY":@"18b8c9ef473e2126c3c56ab0cb2b71cb",
            @"ENCRYPTION_IV":@"18b8c9ef473e2126",
             @"ANALYTICS_BASE_URL":@"https://entqaapi.etenvbiz.com/api_analytics/web/v4/", @"REDEMPTION_HISTORY_URL":@"https://fkru86rv14.execute-api.eu-west-1.amazonaws.com/QA/v2",
             @"GOOGLE_CAPTCHA_URL": @"https://entqacart.etenvbiz.com/captcha/g-captcha.html",
             @"AMAZON_AUTHORIZATION_TOKEN":@"cda6397940d3b191b7960e432be3f16f",
             @"API_GAMIFICATION_URL":@"https://entqaapi.etenvbiz.com/gamify/web/v2/",
             @"G_U" : @"creativity",
             @"G_P" : @"HwJnm5_QP29ww_v6F7W",
             @"API_PASSWORD":@"k$V}B*(6DK5ymTNbH?4<rj3uGF;[~t>q",
             @"API_URL":@"https://entqaapi5.etenvbiz.com/et_rs_prd/web/v70/",
             @"GETAWAY_API_URL" : @"https://entqaapi.etenvbiz.com/et_rs_prd/getaways/v3/",
             @"API_USER":@"qlzfqghpkeiwhmzg",
             @"GAMIFICATION_KEY":@"YzZmY2QwMjUxZjM2MThlNTE0NDM3ZWQ3OWEyY2QxN2U",
             @"GOOGLE_API_KEY":@"AIzaSyBBEFrNt0SKTXdux772g7i7GqsYCy-VuGM",
             @"APPBOY_API_KEY":@"f377a5ff-f43c-4166-a7ad-2d2c8caa39a8",
             @"CAREEM_API_TOKEN":@"6m9a6ak03p4k357fau4al8anng",
             @"BACKUP_API_URL":@"https://stoffapi.etenvbiz.com/et_rs_prd/web/v610/",
             @"BADGE_URL":@"https://entqacart.etenvbiz.com/app/badges/%@?language=%@",
             @"CAREEM_API_URL":@"https://interface.careem.com/v1/",
             @"LEVEL_URL":@"https://entqacart.etenvbiz.com/app/levels/%@?language=%@",
             @"MERCHANT_SHARE_DETAIL_URL" : @"https://entqacart.etenvbiz.com/outlets/detail?m=%@&o=%@&language=%@",
             @"MESSAGING_BASE_URL" : @"http://entqaapi.etenvbiz.com/messaging/api/web/",
             @"WALLET_LINK" : @"https://entqacart.etenvbiz.com/user-wallet?language=%@&app_version=%@&__t=%@",
             @"GOOGLE_TAG_MANAGER":@"GTM-P5J9QS",
             @"IS_SHOW_API_CHANGE":@"1",
             @"LIVE_SERVER_INTERVAL" : @"1",
             @"HERMES_ENGAGEMDD_API_URL" : @"http://authhrmv3.entertainerebizservices.com",
             @"HERMES_ENGAGEMDD_COMPANY_KEY" : @"668bc31ce086154819ed9483f409d1b37f8fdcd7e118ac94fbecc4f9daaec79b"
             
             };
}


+(NSDictionary*)uatDic{
    return @{
            @"ENCRYPTION_KEY":@"18b8c9ef473e2126c3c56ab0cb2b71cb",
            @"ENCRYPTION_IV":@"18b8c9ef473e2126",
             @"ANALYTICS_BASE_URL":@"https://entutapi.theentertainerme.com/api_analytics/web/v4/", @"REDEMPTION_HISTORY_URL":@"https://391802pmmf.execute-api.eu-west-1.amazonaws.com/UAT/v2/",
             @"GOOGLE_CAPTCHA_URL": @"https://entcartut.theentertainerme.com/captcha/g-captcha.html",
             @"AMAZON_AUTHORIZATION_TOKEN":@"6ab7e131543a37ac89f7ce8993c9b3ce",
             @"API_GAMIFICATION_URL":@"https://entutapi.theentertainerme.com/gamify/web/v2/",
             @"G_U" : @"creativity",
             @"G_P" : @"HwJnm5_QP29ww_v6F7W",
             @"API_PASSWORD":@"k$V}B*(6DK5ymTNbH?4<rj3uGF;[~t>q",
             @"API_URL":@"https://entutapi5.theentertainerme.com/et_rs_prd/web/v70/",
             @"GETAWAY_API_URL" : @"https://entutapi.theentertainerme.com/et_rs_prd/getaways/v3/",
             @"API_USER":@"qlzfqghpkeiwhmzg",
             @"GOOGLE_API_KEY":@"AIzaSyBBEFrNt0SKTXdux772g7i7GqsYCy-VuGM",
             @"APPBOY_API_KEY" : @"f377a5ff-f43c-4166-a7ad-2d2c8caa39a8",
             @"BACKUP_API_URL":@"https://offlineapi.entertainerebizservices.com/et_rs_prd/web/v610/",
             @"CAREEM_API_TOKEN":@"6m9a6ak03p4k357fau4al8anng",
             @"CAREEM_API_URL":@"https://interface.careem.com/v1/",
             @"GAMIFICATION_KEY":@"YzZmY2QwMjUxZjM2MThlNTE0NDM3ZWQ3OWEyY2QxN2U",
             @"GOOGLE_TAG_MANAGER":@"GTM-P5J9QS",
             @"IS_SHOW_API_CHANGE":@"0",
             @"LIVE_SERVER_INTERVAL" : @"1",
             @"MESSAGING_BASE_URL" : @"http://entutapi.theentertainerme.com/messaging/api/web/",
             @"LEVEL_URL":@"https://entcartut.theentertainerme.com/app/levels/%@?language=%@",
             @"BADGE_URL":@"https://entcartut.theentertainerme.com/app/badges/%@?lanzguage=%@",
             @"MERCHANT_SHARE_DETAIL_URL" : @"https://entcartut.theentertainerme.com/outlets/detail?m=%@&o=%@&language=%@",
             @"WALLET_LINK" : @"https://entcartut.theentertainerme.com/user-wallet?language=%@&app_version=%@&__t=%@",
             @"HERMES_ENGAGEMDD_API_URL" : @"http://authhrmv3.entertainerebizservices.com",
             @"HERMES_ENGAGEMDD_COMPANY_KEY" : @"668bc31ce086154819ed9483f409d1b37f8fdcd7e118ac94fbecc4f9daaec79b"
             
             };
}



+(NSDictionary*)prodDic{
    return @{
            @"ENCRYPTION_KEY":@"18b8c9ef473e2126c3c56ab0cb2b71cb",
            @"ENCRYPTION_IV":@"18b8c9ef473e2126",
             @"ANALYTICS_BASE_URL":@"https://api.theentertainerme.com/api_analytics/web/v4/", @"REDEMPTION_HISTORY_URL":@"https://jb0auve5he.execute-api.eu-west-1.amazonaws.com/PROD/v2/",
             @"GOOGLE_CAPTCHA_URL": @"https://entcartut.theentertainerme.com/captcha/g-captcha.html",
             @"AMAZON_AUTHORIZATION_TOKEN":@"d44335434557f59bf52e55bfa4b77708",
             @"API_GAMIFICATION_URL":@"https://api.theentertainerme.com/gamify/web/v2/",
             @"G_U" : @"creativity",
             @"G_P" : @"HwJnm5_QP29ww_v6F7W",
             @"API_PASSWORD":@"k$V}B*(6DK5ymTNbH?4<rj3uGF;[~t>q",
             @"API_URL":@"https://api.theentertainerme.com/et_rs_prd/web/v614/",
             @"GETAWAY_API_URL" : @"https://api.theentertainerme.com/et_rs_prd/getaways/v3/",
             @"API_USER":@"qlzfqghpkeiwhmzg",
             @"GOOGLE_API_KEY":@"AIzaSyBBEFrNt0SKTXdux772g7i7GqsYCy-VuGM",
             @"APPBOY_API_KEY" : @"0e9a3e31-ecf7-497f-94f2-126ca10089d3",
             @"BACKUP_API_URL":@"https://offlineapi.entertainerebizservices.com/et_rs_prd/web/vo610/",
             @"CAREEM_API_TOKEN":@"6m9a6ak03p4k357fau4al8anng",
             @"CAREEM_API_URL":@"https://interface.careem.com/v1/",
             @"GAMIFICATION_KEY":@"YzZmY2QwMjUxZjM2MThlNTE0NDM3ZWQ3OWEyY2QxN2U",
             @"GOOGLE_TAG_MANAGER":@"GTM-P5J9QS",
             @"IS_SHOW_API_CHANGE":@"0",
             @"LIVE_SERVER_INTERVAL" : @"1",
             @"MESSAGING_BASE_URL" : @"http://api.theentertainerme.com/messaging/api/web/",
             @"BADGE_URL":@"https://www.theentertainerme.com/app/badges/%@?language=%@",
             @"LEVEL_URL":@"https://www.theentertainerme.com/app/levels/%@?language=%@",
             @"WALLET_LINK" : @"https://www.theentertainerme.com/user-wallet?language=%@&app_version=%@&__t=%@",
             @"MERCHANT_SHARE_DETAIL_URL" : @"https://www.theentertainerme.com/outlets/detail?m=%@&o=%@&language=%@",
             @"HERMES_ENGAGEMDD_API_URL" : @"http://authhrmv3.entertainerebizservices.com",
             @"HERMES_ENGAGEMDD_COMPANY_KEY" : @"668bc31ce086154819ed9483f409d1b37f8fdcd7e118ac94fbecc4f9daaec79b"
             
             
             };
}
+(NSDictionary*)rcDic{
    return @{
            @"ENCRYPTION_KEY":@"18b8c9ef473e2126c3c56ab0cb2b71cb",
            @"ENCRYPTION_IV":@"18b8c9ef473e2126",
             @"ANALYTICS_BASE_URL":@"https://api.theentertainerme.com/api_analytics/web/v4/", @"REDEMPTION_HISTORY_URL":@"https://jb0auve5he.execute-api.eu-west-1.amazonaws.com/PROD/v2/",
             @"GOOGLE_CAPTCHA_URL": @"https://entcartut.theentertainerme.com/captcha/g-captcha.html",
             @"AMAZON_AUTHORIZATION_TOKEN":@"d44335434557f59bf52e55bfa4b77708",
             @"API_GAMIFICATION_URL":@"https://api.theentertainerme.com/gamify/web/v2/",
             @"G_U" : @"creativity",
             @"G_P" : @"HwJnm5_QP29ww_v6F7W",
             @"API_PASSWORD":@"k$V}B*(6DK5ymTNbH?4<rj3uGF;[~t>q",
             @"API_URL":@"https://rcapi.theentertainerme.com/et_rs_prd/web/v614/",
             @"GETAWAY_API_URL" : @"https://rcapi.theentertainerme.com/et_rs_prd/getaways/v3/",
             @"API_USER":@"qlzfqghpkeiwhmzg",
             @"GOOGLE_API_KEY":@"AIzaSyBBEFrNt0SKTXdux772g7i7GqsYCy-VuGM",
             @"APPBOY_API_KEY" : @"0e9a3e31-ecf7-497f-94f2-126ca10089d3",
             @"BACKUP_API_URL":@"https://offlineapi.entertainerebizservices.com/et_rs_prd/web/vo610/",
             @"CAREEM_API_TOKEN":@"6m9a6ak03p4k357fau4al8anng",
             @"CAREEM_API_URL":@"https://interface.careem.com/v1/",
             @"GAMIFICATION_KEY":@"YzZmY2QwMjUxZjM2MThlNTE0NDM3ZWQ3OWEyY2QxN2U",
             @"GOOGLE_TAG_MANAGER":@"GTM-P5J9QS",
             @"IS_SHOW_API_CHANGE":@"0",
             @"LIVE_SERVER_INTERVAL" : @"1",
             @"MESSAGING_BASE_URL" : @"http://api.theentertainerme.com/messaging/api/web/",
             @"BADGE_URL":@"https://www.theentertainerme.com/app/badges/%@?language=%@",
             @"LEVEL_URL":@"https://www.theentertainerme.com/app/levels/%@?language=%@",
             @"WALLET_LINK" : @"https://www.theentertainerme.com/user-wallet?language=%@&app_version=%@&__t=%@",
             @"MERCHANT_SHARE_DETAIL_URL" : @"https://www.theentertainerme.com/outlets/detail?m=%@&o=%@&language=%@",
             @"HERMES_ENGAGEMDD_API_URL" : @"http://authhrmv3.entertainerebizservices.com",
             @"HERMES_ENGAGEMDD_COMPANY_KEY" : @"668bc31ce086154819ed9483f409d1b37f8fdcd7e118ac94fbecc4f9daaec79b"
             
             
             };
}

+(NSDictionary*)ebrixDic{
    return @{
            @"ENCRYPTION_KEY":@"18b8c9ef473e2126c3c56ab0cb2b71cb",
            @"ENCRYPTION_IV":@"18b8c9ef473e2126",
             @"ANALYTICS_BASE_URL":@"https://ebxapi.theentertainerme.com/api_analytics/web/v4/", @"REDEMPTION_HISTORY_URL":@"https://jb0auve5he.execute-api.eu-west-1.amazonaws.com/PROD/v2/",
             @"GOOGLE_CAPTCHA_URL": @"https://entcartut.theentertainerme.com/captcha/g-captcha.html",
             @"AMAZON_AUTHORIZATION_TOKEN":@"d44335434557f59bf52e55bfa4b77708",
             @"API_GAMIFICATION_URL":@"https://ebxgmfy.theentertainerme.com/gamify/web/v2/",
             @"G_U" : @"creativity",
             @"G_P" : @"HwJnm5_QP29ww_v6F7W",
             @"API_PASSWORD":@"k$V}B*(6DK5ymTNbH?4<rj3uGF;[~t>q",
             @"API_URL":@"https://ebxapi.theentertainerme.com/et_rs_prd/web/v614/",
             @"GETAWAY_API_URL" : @"https://ebxapi.theentertainerme.com/et_rs_prd/test/getaways/v3/",
             @"API_USER":@"qlzfqghpkeiwhmzg",
             @"GOOGLE_API_KEY":@"AIzaSyBBEFrNt0SKTXdux772g7i7GqsYCy-VuGM",
             @"APPBOY_API_KEY" : @"0e9a3e31-ecf7-497f-94f2-126ca10089d3",
             @"BACKUP_API_URL":@"https://offlineapi.entertainerebizservices.com/et_rs_prd/web/vo610/",
             @"CAREEM_API_TOKEN":@"6m9a6ak03p4k357fau4al8anng",
             @"CAREEM_API_URL":@"https://interface.careem.com/v1/",
             @"GAMIFICATION_KEY":@"YzZmY2QwMjUxZjM2MThlNTE0NDM3ZWQ3OWEyY2QxN2U",
             @"GOOGLE_TAG_MANAGER":@"GTM-P5J9QS",
             @"IS_SHOW_API_CHANGE":@"0",
             @"LIVE_SERVER_INTERVAL" : @"1",
             @"MESSAGING_BASE_URL" : @"http://api.theentertainerme.com/messaging/api/web/",
             @"BADGE_URL":@"https://ebxenter.theentertainerme.com/app/badges/%@?language=%@",
             @"LEVEL_URL":@"https://ebxenter.theentertainerme.com/app/levels/%@?language=%@",
             @"WALLET_LINK" : @"https://ebxenter.theentertainerme.com/user-wallet?language=%@&app_version=%@&__t=%@",
             @"MERCHANT_SHARE_DETAIL_URL" : @"https://ebxenter.theentertainerme.com/outlets/detail?m=%@&o=%@&language=%@",
             @"HERMES_ENGAGEMDD_API_URL" : @"http://authhrmv3.entertainerebizservices.com",
             @"HERMES_ENGAGEMDD_COMPANY_KEY" : @"668bc31ce086154819ed9483f409d1b37f8fdcd7e118ac94fbecc4f9daaec79b"
             
             };
}

//MARK: - ApiConfig (MicroServices)

+(NSDictionary *)MS_devDic {
    return @{
        @"JWT_SECRET_KEY":@"156-7890-entertainer-v614",
        @"JWT_API_KEY":@"12345678-9012-3456-7890-entertainer-v614",
        @"MS_USER_API_URL":@"https://userqasvr.etenvbiz.com/api_ets/v4/",
        @"MS_CONFIG_API_URL": @"https://configqasvr.etenvbiz.com/api_ets/v4/"
    };
}
+(NSDictionary *)MS_qaDic {
    return @{
        @"JWT_SECRET_KEY":@"156-7890-entertainer-v614",
        @"JWT_API_KEY":@"12345678-9012-3456-7890-entertainer-v614",
        @"MS_USER_API_URL":@"https://userqasvr.etenvbiz.com/api_ets/v4/",
        @"MS_CONFIG_API_URL": @"https://configqasvr.etenvbiz.com/api_ets/v4/"
    };
}
+(NSDictionary *)MS_uatDic {
    return @{
        @"JWT_SECRET_KEY":@"156-7890-entertainer-v614",
        @"JWT_API_KEY":@"12345678-9012-3456-7890-entertainer-v614",
        @"MS_USER_API_URL":@"https://userqasvr.etenvbiz.com/api_ets/v4/",
        @"MS_CONFIG_API_URL": @"https://configqasvr.etenvbiz.com/api_ets/v4/"
    };
}
+(NSDictionary *)MS_rcDic {
    return @{
        @"JWT_SECRET_KEY":@"156-7890-entertainer-v614",
        @"JWT_API_KEY":@"12345678-9012-3456-7890-entertainer-v614",
        @"MS_USER_API_URL":@"https://userqasvr.etenvbiz.com/api_ets/v4/",
        @"MS_CONFIG_API_URL": @"https://configqasvr.etenvbiz.com/api_ets/v4/"
    };
}
+(NSDictionary *)MS_prodDic {
    return @{
        @"JWT_SECRET_KEY":@"156-7890-entertainer-v614",
        @"JWT_API_KEY":@"12345678-9012-3456-7890-entertainer-v614",
        @"MS_USER_API_URL":@"https://userqasvr.etenvbiz.com/api_ets/v4/",
        @"MS_CONFIG_API_URL": @"https://configqasvr.etenvbiz.com/api_ets/v4/"
    };
}
+(NSDictionary *)MS_ebryxDic {
    return @{
        @"JWT_SECRET_KEY":@"156-7890-entertainer-v614",
        @"JWT_API_KEY":@"12345678-9012-3456-7890-entertainer-v614",
        @"MS_USER_API_URL":@"https://userqasvr.etenvbiz.com/api_ets/v4/",
        @"MS_CONFIG_API_URL": @"https://configqasvr.etenvbiz.com/api_ets/v4/"
    };
}

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
