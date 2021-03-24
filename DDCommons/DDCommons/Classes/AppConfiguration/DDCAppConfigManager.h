//
//  DDCAppConfigManager.h
//  DDCommons
//
//  Created by Syed Qamar Abbas on 30/12/2019.
//

#import <Foundation/Foundation.h>
#import "DDCAppConfigM.h"
#import "DDCAppApiConfigM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDCAppConfigManager : NSObject
+(DDCAppConfigManager *)shared;

@property (assign) BOOL isEditConfigAllowed;
@property (strong, nonatomic) DDCAppApiConfigM *api_config;
@property (strong, nonatomic) DDCAppConfigM *app_config;

@property (strong, nonatomic) NSString *SSL_CERTIFICATE_NAME;
@property (strong, nonatomic) NSString *SSL_CERTIFICATE_EXTENSION;

-(void)setApiConfig:(NSDictionary *)api_config andAppConfig:(NSDictionary *)app_config;
-(NSURLRequest *)helpRequest;
-(NSString *)deeplinkSchemeFor:(NSString*)host;
@property (assign, nonatomic) UIStatusBarStyle statusBarStyle;
@end

NS_ASSUME_NONNULL_END
