//
//  DDCommons.h
//  DDCommons
//
//  Created by M.Jabbar on 24/12/2019.
//

#ifndef DDCommons_h
#define DDCommons_h

#define DD_DEFAULTS [NSUserDefaults standardUserDefaults]
#define DD_GROUP_DEFAULTS [[NSUserDefaults alloc] initWithSuiteName:APP_BUNDLE_ID]
#define APP_BUNDLE_ID [[NSBundle mainBundle] bundleIdentifier]

#define DEEP_LINK_IDDDIFIER_CATEGORY_ID @"dynamicdelivery://?cat_id"
#define DEEP_LINK_IDDDIFIER_CATEGORY_NAME @"dynamicdelivery://?category"
#define DEEP_LINK_PRODUCT_DETAIL @"dynamicdelivery://ProductDetail/?"

#define SIGNIN_OR_SIGNUP_NOTIFICATION @"SIGNIN_OR_SIGNUP_NOTIFICATION"
#define SHOW_REGISTER_SCREEN @"SHOW_REGISTER_SCREEN"
#define SAVED_URL @"SAVED_URL"
#define SAVED_GETAWAYS_API_URL @"SAVED_GETAWAYS_API_URL"

#define SAVED_API_USER @"SAVED_API_USER"
#define SAVED_API_PASSWORD @"SAVED_API_PASSWORD"
#define SAVED_ANALYTICS_BASE_URL @"SAVED_ANALYTICS_BASE_URL"
#define SAVED_API_GAMIFICATION_URL @"SAVED_API_GAMIFICATION_URL"
#define SAVED_BACKUP_API_URL @"SAVED_BACKUP_API_URL"
#define SAVED_WALLET_LINK @"SAVED_WALLET_LINK"
#define SAVED_MESSAGING_BASE_URL @"SAVED_MESSAGING_BASE_URL"
#define kBranchData  @"BranchData"
#define kGenericKeyParams  @"BranchParams"

#define HSS @"18b8c9ef473e2126c3c56ab0cb2b71cb"
#define HSS_IV5 @"18b8c9ef473e2126"
#define AES_PARAM @"D84sGxHqTdEJWzLGawhv9URkKn5fY7B2"



#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define OK @"Ok"
#define DELETE_All @"Delete All"
#define DELETE @"Delete"
#define CANCEL @"Cancel"
#define NEXT @"Next"
#define SUBMIT @"Submit"
#define EDIT @"Edit"
#define BACK @"Back"
#define SKIP @"Skip"
#define CONTINUE @"Continue"
#define SEARCH @"Search"
#define SAVE @"Save"
#define DONE @"Done"
#define DETAILS @"Details"
#define RESET @"Reset"
#define APPLY @"Apply"
#define CURRDD_LOCATION @"Current Location"
#define SOMETHING_WDD_WRONG @"Something went wrong please try again later."
#define UNKNOWN_ERROR @"Unknown error"


#define INVALID_EMAIL_MESSAGE @"Please enter a valid email"
#define PRIVACY_POLICY_ERROR_MESSAGE @"Please review and accept the Privacy Policy."
#define EULA_ERROR_MESSAGE @"Please review and accept the End User Licence Agrement."
#define PASSWORD_ERROR_MESSAGE @"Password is invalid."

#endif /* DDCommons_h */
#import "UIPlaceHolderTextView.h"
#import "DDLogs.h"
#import "DDCallBacks.h"
#import "DDCCommonApiParam.h"
#import "DDCCommonWebParam.h"
#import "DDCCommonParamManager.h"
#import "DDExtraUtil.h"
#import "NSDate+TimeAgo.h"
#import "DDCAppApiConfigM.h"
#import "DDCAppConfigM.h"
#import "DDCAppConfigManager.h"
#import "NSBundle+DDNSBundle.h"
#import "NSDate+DDDate.h"
#import "NSDictionary+DDNSDictionary.h"
#import "NSError+DDError.h"
#import "NSMutableAttributedString+DDAttributedString.h"
#import "NSMutableURLRequest+DDNSMutableURLRequest.h"
#import "NSString+DDString.h"
#import "NSURL+DDNSURL.h"
#import "UITextField+DDTextField.h"
#import "UIApplication+DDApplication.h"
#import "UICollectionView+DDRegistration.h"
#import "UIColor+DDColor.h"
#import "UIImageView+DDImageLoading.h"
#import "UITableView+DDRegistration.h"
#import "UITableViewCell+DDUITableViewCell.h"
#import "UIView+DDView.h"
#import "UIViewController+DDViewController.h"
#import "UIWindow+RootVC.h"
#import "DDUILottieAnimationManager.h"
#import "NSData+DDNSData.h"
#import "DDLocalizedBundleFile.h"



#define APPBOY_EVDD_FoodNDrink @"visited food and drink"
#define APPBOY_EVDD_BeautyNFitness @"visited beauty and fitness"
#define APPBOY_EVDD_ProfileTab @"visited profile tab"
#define APPBOY_EVDD_RecievePing @"receive ping"
#define APPBOY_EVDD_DeliverySection @"opened delivery listing"
#define APPBOY_EVDD_OrderedDelivery @"ordered Delivery"
#define APPBOY_EVDD_REGISTRATION_COMPLETE @"registration complete"
#define APPBOY_EVDD_REDEEMED @"Redeemed"
