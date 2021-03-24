//
//  DDCAppApiConfigM.h
//  DDCommons
//
//  Created by Syed Qamar Abbas on 30/12/2019.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDCAppApiConfigM : JSONModel

@property (strong, nonatomic) NSString <Optional> *CASHLESS_CART_URL;
@property (strong, nonatomic) NSString <Optional> *C2C_CART_URL;
@property (strong, nonatomic) NSString <Optional> *JWT_SECRET_KEY;
@property (strong, nonatomic) NSString <Optional> *JWT_API_KEY;
@property (strong, nonatomic) NSString <Optional> *ENCRYPTION_KEY;
@property (strong, nonatomic) NSString <Optional> *ENCRYPTION_IV;
@property (strong, nonatomic) NSString <Optional> *API_URL;
@property (strong, nonatomic) NSString <Optional> *GOOGLE_API_KEY;

//MARK: - MS is MicroServices
@property (strong, nonatomic) NSString <Optional> *MS_USER_API_URL;
@property (strong, nonatomic) NSString <Optional> *MS_CONFIG_API_URL;


@property (strong, nonatomic) NSString <Optional> *GOOGLE_CAPTCHA_URL;

@property (strong, nonatomic) NSString <Optional> *ANALYTICS_BASE_URL;
@property (strong, nonatomic) NSString <Optional> *REDEMPTION_HISTORY_URL;
@property (strong, nonatomic) NSString <Optional> *API_GAMIFICATION_URL;
@property (strong, nonatomic) NSString <Optional> *MESSAGING_HERMES_V2_URL;
@property (strong, nonatomic) NSString <Optional> *MESSAGING_HERMES_V2_COMPANY_KEY;
@property (strong, nonatomic) NSString <Optional> *API_USER;
@property (strong, nonatomic) NSString <Optional> *API_PASSWORD;
@property (strong, nonatomic) NSString <Optional> *CAREEM_API_TOKEN;
@property (strong, nonatomic) NSString <Optional> *CAREEM_API_URL;
@property (strong, nonatomic) NSString <Optional> *GAMIFICATION_KEY;
@property (strong, nonatomic) NSString <Optional> *MESSAGING_HERMES_FIREBASE_PLISTNAME;
@property (strong, nonatomic) NSString <Optional> *G_U;
@property (strong, nonatomic) NSString <Optional> *G_P;
@property (strong, nonatomic) NSString <Optional> *GOOGLE_TAG_MANAGER;
@property (strong, nonatomic) NSString <Optional> *IS_SHOW_API_CHANGE;
@property (strong, nonatomic) NSString <Optional> *LIVE_SERVER_INTERVAL;
@property (strong, nonatomic) NSString <Optional> *MESSAGING_BASE_URL;
@property (strong, nonatomic) NSString <Optional> *TRIP_ADV_KEY;
@property (strong, nonatomic) NSString <Optional> *TRIP_ADV_URL;
@property (strong, nonatomic) NSString <Optional> *WALLET_LINK;
@property (strong, nonatomic) NSString <Optional> *BADGE_URL;
@property (strong, nonatomic) NSString <Optional> *NEWSFEED_BASE_URL;
@property (strong, nonatomic) NSString <Optional> *LEVEL_URL;
@property (strong, nonatomic) NSString <Optional> *MERCHANT_SHARE_DETAIL_URL;
@property (strong, nonatomic) NSString <Optional> *BACKUP_API_URL;
@property (strong, nonatomic) NSString <Optional> *BADGEVILLE_API_KEY;
@property (strong, nonatomic) NSString <Optional> *BADGEVILLE_SITE_ID;
@property (strong, nonatomic) NSString <Optional> *BADGEVILLE_URL;
@property (strong, nonatomic) NSString <Optional> *UBER_API_KEY;
@property (strong, nonatomic) NSString <Optional> *UBER_API_URL;
@property (strong, nonatomic) NSString <Optional> *UBER_SIGNUP_URL;
@property (strong, nonatomic) NSString <Optional> *KALIGI_API_USERNAME;
@property (strong, nonatomic) NSString <Optional> *KALIGI_API_PASSWORD;
@property (strong, nonatomic) NSString <Optional> *DEMOGRAPHICS_URL;
@property (strong, nonatomic) NSString <Optional> *APPBOY_API_KEY;
@property (strong, nonatomic) NSString <Optional> *GETAWAY_API_URL;
@property (strong, nonatomic) NSString <Optional> *GOOGLE_SIGNIN_API_KEY;

@end

NS_ASSUME_NONNULL_END
