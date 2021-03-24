//
//  DDProductsUIManager.h
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 30/01/2020.
//

#import <Foundation/Foundation.h>
#import "DDAuth.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDProductsUIManager : NSObject

//+(DDProductsUIManager *)shared;
+(void)showCompleteLoginOnVC:(UIViewController *)vc onCompletion:(void (^)(BOOL))completion;
+(void)showProductsPurchsaeHistoryOnVC:(UIViewController *)vc data:(_Nullable id)data onCompletion:(_Nullable ControllerCallBack)completion;

@end

NS_ASSUME_NONNULL_END
