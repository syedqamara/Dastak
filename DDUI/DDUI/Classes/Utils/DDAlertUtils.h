//
//  DDAlertUtils.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDAlertUtils : NSObject
+(DDAlertUtils *)shared;

+(void)showOkAlertWithTitle:(NSString* _Nullable)title subtitle:(NSString* _Nullable)subtitle completion:(VoidCompletionCallBack)completion;
+(void)showAlertWithTitle:(NSString *_Nullable)title subtitle:(NSString *_Nullable)subtitle buttonNames:(NSArray <NSString *>*)buttons onClick:(IntCompletionCallBack)completion;
+(void)showAlertWithTitle:(NSString *_Nullable)title subtitle:(NSString *_Nullable)subtitle buttonNames:(NSArray <NSString *>*)buttons highlightedAt:(NSUInteger)index onClick:(IntCompletionCallBack)completion;

+(void)showCancelActionSheetWithTitle:(NSString* _Nullable)title message:(NSString* _Nullable)message buttonTexts:(NSArray* _Nullable)buttonTexts completion:(void (^ _Nullable)(int))completion;
+(void)showActionSheetWithTitle:(NSString* _Nullable)title message:(NSString* _Nullable)message buttonTexts:(NSArray* _Nullable)buttonTexts completion:(void (^ _Nullable)(int))completion cancelBtnText:(NSString *_Nullable)cancelBtnText cancelButtonAction:(void (^ __nullable)(void))cancelButtonAction;

- (void)showLoginWithThirdPartyResult:(NSString *)emailStr andFirstName:(NSString *)firstName andLastName:(NSString *)lastName withCompletion:(void (^ _Nullable)(NSString * _Nullable email,NSString * _Nullable firstName,NSString * _Nullable lastName))completion;
- (void)showNameInputAlertWithCompletion:(void (^ _Nullable)(NSString * _Nullable))completion;
@end

NS_ASSUME_NONNULL_END
