//
//  DDCAppConfigM.h
//  DDCommons
//
//  Created by Syed Qamar Abbas on 30/12/2019.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDCAppConfigM : JSONModel

@property (strong, nonatomic) NSString <Optional> *BRANCH_SCHEME;
@property (strong, nonatomic) NSString <Optional> *BRANCH_SCHEME_TEST;

@property (strong, nonatomic) NSString <Optional> *APP_GROUP_IDDDIFIER;
// MARK:- RunTimeTempConfigs
@property (strong, nonatomic) NSString <Optional> *END_USER_LIS_AGR;
@property (strong, nonatomic) NSString <Optional> *CONTACT_US;
@property (strong, nonatomic) NSString <Optional> *HELP_PAGE;
@property (strong, nonatomic) NSString <Optional> *PRIVACY_POLICY_URL;
@property (strong, nonatomic) NSString <Optional> *APPLICATION_DEEPLINK_SCHEME;
@property (strong, nonatomic) NSString <Optional> *cashless_cart_url;

@end

NS_ASSUME_NONNULL_END
