//
//  DDUIBaseViewController+Navigation.h
//  DDUI
//
//  Created by Awais Shahid on 18/02/2020.
//

#import <Foundation/Foundation.h>
#import "DDUIBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDUIBaseViewController (Navigation)

-(void)setThemeNavigationBar;
-(void)setNativeNavigationBar;
-(void)setTransparentNavigationBar;
-(void)addCrossImageWithColor:(UIColor *)color withDirection:(DDNavigationItemDirection)direction;
-(void)addNavigationItemWithTitle:(NSString* _Nullable)title
                       identifier:(NSString* _Nullable)identifier
                        tintColor:(UIColor *)tintColor
                        direction:(DDNavigationItemDirection)direction;
-(void)addNavigationItemWithImage:(NSString* _Nullable)image
                       identifier:(NSString* _Nullable)identifier
                        tintColor:(UIColor *)tintColor
                        direction:(DDNavigationItemDirection)direction;
-(void)addNavigationItemWithTitle:(NSString* _Nullable)title
image:(NSString* _Nullable)image
identifier:(NSString* _Nullable)identifier
 tintColor:(UIColor *)tintColor
                        direction:(DDNavigationItemDirection)direction;
-(void)addBackArrowNavigtaionItemWithtitle:(NSString* _Nullable)title;
-(void)addBackArrowNavigtaionItemWithtitle:(NSString* _Nullable)title tintColor:(UIColor* )tintColor;
- (void)didTapOnNavigationItem:(DDNavigationItem*)sender;
- (DDNavigationItem*)navigationItemWithIdentifier:(NSString*)identifier;
-(void)setNavigationBarBackgroundColor:(UIColor *)color;
-(void)largeNavigationBar;
-(void)standardNavigationBar;
-(void)setWhiteDragableNavigationBar;
-(void)setStatusBarStyle:(UIStatusBarStyle)style;
@end

NS_ASSUME_NONNULL_END
