//
//  DDFamilyBaseVC.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 27/01/2020.
//

#import "DDFamilyBaseVC.h"

@interface DDFamilyBaseVC ()

@end

@implementation DDFamilyBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setupScreenFromData:(id _Nullable)data {
    
}

-(void)setupFamilyThemedBtn:(UIButton *)btn withTitle:(NSString*)title {
    [btn setTitle:title.localized forState:UIControlStateNormal];
    [btn setTitleColor:DDFamilyThemeManager.shared.selected_theme.text_white.colorValue forState:UIControlStateNormal];
    [btn setBackgroundColor:DDFamilyThemeManager.shared.selected_theme.app_theme.colorValue];
    btn.cornerR = 12;
    btn.clipsToBounds = YES;
    btn.titleLabel.font = [UIFont DDBoldFont:17];
}

@end
