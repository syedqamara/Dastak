//
//  DDFamilyBaseVC.h
//  DDFamilyUI
//
//  Created by Awais Shahid on 27/01/2020.
//

#import <UIKit/UIKit.h>

#import "DDConstants/DDConstants.h"
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>
#import <DDFamily/DDFamily.h>
#import <DDUI/DDUI.h>

#import "DDFamilyUIConstants.h"
#import "DDFamilyThemeManager.h"
#import "DDFamilyUIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDFamilyBaseVC : DDUIBaseViewController
-(void)setupScreenFromData:(id _Nullable)data;
-(void)setupFamilyThemedBtn:(UIButton *)btn withTitle:(NSString*)title;
@end

NS_ASSUME_NONNULL_END
