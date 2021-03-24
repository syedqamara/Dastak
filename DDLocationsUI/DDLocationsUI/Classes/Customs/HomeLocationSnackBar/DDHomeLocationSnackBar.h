//
//  DDHomeLocationSnackBar.h
//  DDHomeUI
//
//  Created by Awais Shahid on 28/02/2020.
//

#import "DDUIBaseView.h"
#import <DDModels/DDModels.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDHomeLocationSnackBar : DDUIBaseView
+ (void)showInConatiner:(UIView *)container withLocation:(DDLocationsM * _Nullable)model onChangeTapped:(void (^ _Nullable)(void))completion;
@end

NS_ASSUME_NONNULL_END








