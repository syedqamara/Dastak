//
//  DDCCommonParamManager.h
//  DDCommons
//
//  Created by Syed Qamar Abbas on 31/12/2019.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "DDCCommonApiParam.h"
#import "DDCCommonWebParam.h"
NS_ASSUME_NONNULL_BEGIN




@class DDCCommonParamManager;

@interface DDCCommonParamManager : NSObject
+(DDCCommonParamManager *)shared;
-(void)reset;
@property (strong, nonatomic) DDCCommonApiParam *default_api_parameters;
@property (strong, nonatomic) DDCCommonWebParam *default_web_parameters;
-(NSString*)getDefaultWebParametersUrl:(NSString*)url;
-(NSString *)JWTToken;
@end

NS_ASSUME_NONNULL_END
