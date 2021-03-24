//
//  DDEmptyView.h
//  DDUI
//
//  Created by Awais Shahid on 07/02/2020.
//

#import <UIKit/UIKit.h>
#import <DDModels/DDModels.h>
#import "DDUIBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDEmptyView : DDUIBaseView
@property (nonatomic, assign) BOOL shouldDismissItself;
+ (void)showInConatiner:(UIView *)container withEmptyViewModel:(DDEmptyViewModel *)modal completion:(void (^ _Nullable)(void))completion;
+ (void)showInternetNotAvailableWithcompletion:(void (^ _Nullable)(void))completion;


+ (DDEmptyView*)showAndReturnInConatiner:(UIView *)container withEmptyViewModel:(DDEmptyViewModel *)modal completion:(void (^ _Nullable)(void))completion;
@end

NS_ASSUME_NONNULL_END
