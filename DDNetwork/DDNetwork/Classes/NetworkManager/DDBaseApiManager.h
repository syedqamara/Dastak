//
//  DDBaseApiM.h
//  ApiRouter
//
//  Created by mac on 26/12/2019.
//


#import "DDBaseApiBreakPointManager.h"
NS_ASSUME_NONNULL_BEGIN






@interface DDBaseApiManager : DDBaseApiBreakPointManager

-(void)apiDidCompleteRequest:(void(^)(DDBaseApiModel * _Nullable api_model, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
-(void)createAndSendRequest;
-(void)sendCallWithSelectorName:(NSString *)selectorName;
+(void)registerApiConfiguration;
@end

NS_ASSUME_NONNULL_END
