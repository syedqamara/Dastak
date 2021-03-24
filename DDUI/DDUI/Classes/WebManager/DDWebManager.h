//
//  DDWebManager.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 23/01/2020.
//

#import <Foundation/Foundation.h>
#import "DDUIWebViewVM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDWebManager : NSObject
+(DDWebManager *)shared;
-(void)openURL:(NSString *)url title:(NSString*)title  onController:(UIViewController *)controller;
-(void)openGeneralWeb:(NSString * _Nullable)screenTitle andURL:(NSString *)webUrl onController:(UIViewController *)controller onURLChange:(WebControllerURLChange _Nullable)urlChange  onComplete:(WebControllerCompletion _Nullable)completion onClose:(WebControllerClose _Nullable)close;
-(void)openWeb:(DDUIWebViewVM *)webModel onController:(UIViewController *)controller;
@end

NS_ASSUME_NONNULL_END
