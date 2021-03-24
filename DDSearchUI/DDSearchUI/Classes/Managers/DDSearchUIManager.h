//
//  DDSearchUIManager.h
//  DDSearchUI
//
//  Created by Syed Qamar Abbas on 10/02/2020.
//

#import <Foundation/Foundation.h>
#import "DDModels.h"
#import "DDUI.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDSearchUIManager : NSObject
+(void)openSearchScreenOnController:(UIViewController *)controller;
+(DDEmptyViewModel*)deeplinkSearchEmptyViewSearchText:(NSString *)searchText;
@end

NS_ASSUME_NONNULL_END
