//
//  DDApiRouteConfig.h
//  theDDERTAINER_Example
//
//  Created by Syed Qamar Abbas on 31/12/2019.
//  Copyright © 2019 etDev24. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDApiRouteConfig : NSObject
+(void)loadApiConfiguration;
+(void)loadAppConfigurations;
+(void)loadAppConfigurationsFromAPI;
@end

NS_ASSUME_NONNULL_END
