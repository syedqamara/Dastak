//
//  DDLoginVC.h
//  DDAuth
//
//  Created by M.Jabbar on 26/12/2019.
//

#import <UIKit/UIKit.h>
#import <DDCommons/DDCommons.h>
#import <DDUI/DDUI.h>
#import <DDAuth/DDAuth.h>


NS_ASSUME_NONNULL_BEGIN

@interface DDLoginVC : DDUIBaseViewController
@property (nonatomic, copy) void (^callBackAfterDataLoaded)(_Nullable id user, UIViewController *controller);

@property (nonatomic) BOOL shouldShowBackButton;

@end

NS_ASSUME_NONNULL_END
