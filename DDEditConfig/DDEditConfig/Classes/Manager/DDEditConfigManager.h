//
//  DDEditConfigManager.h
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 06/04/2020.
//

#import <Foundation/Foundation.h>
#import "DDConstants.h"
#import "DDCommons.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDEditConfigManager : NSObject
+(void)openEditOptions:(NSArray *)allEditingConfigs onController:(UIViewController *)controller andCallBack:(ControllerCallBack)callBack;
+(void)openJSONEditor:(NSData *)jsonData withTitle:(NSString *)title onController:(UIViewController *)controller andCallBack:(ControllerCallBack)callBack;
+(BOOL)isAlreadyDisplaying;
@end

NS_ASSUME_NONNULL_END
