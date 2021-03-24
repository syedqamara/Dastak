//
//  DDCashlessCartWebVC.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 28/01/2020.
//

#import <UIKit/UIKit.h>
#import "DDUI.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCashlessCartWebVC : DDUIWebViewController
+(void)postOrderCompletionNotification:(NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END
