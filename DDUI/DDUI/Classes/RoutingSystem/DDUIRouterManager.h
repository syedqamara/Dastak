//
//  DDUIRouterManager.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 26/12/2019.
//

#import <Foundation/Foundation.h>
#import "DDUIRouterM.h"
#import "DDUIRouterConfigurationM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDUIRouterManager : NSObject
+(DDUIRouterManager *)shared;
@property (strong, nonatomic) UIWindow *applicationsWindow;
//-(void)setRouteConfiguration:(NSArray <DDUIRouterConfigurationM *>*)configurations;
-(void)addRouteToConfiguration:(DDUIRouterConfigurationM *)config;
-(DDUIRouterConfigurationM *)configForID:(NSString *)configID;
-(void)navigateTo:(NSArray <DDUIRouterM *> *)params onController:(UIViewController *)controller;
-(void)navigateDeeplinkTo:(NSArray <DDUIRouterM *> *)params onController:(UIViewController *)controller;
@end

NS_ASSUME_NONNULL_END
