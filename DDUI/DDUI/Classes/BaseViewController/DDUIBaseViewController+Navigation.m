//
//  DDUIBaseViewController+Navigation.m
//  DDUI
//
//  Created by Awais Shahid on 18/02/2020.
//

#import "DDUIBaseViewController+Navigation.h"

@implementation DDUIBaseViewController (Navigation)

#pragma mark - Navigation Bar

-(void)setTransparentNavigationBar {
    
    UIColor *text_white_color =  DDUIThemeManager.shared.selected_theme.text_white.colorValue;
    if (text_white_color == nil) text_white_color = UIColor.whiteColor;
    
    UIFont *app_font = [UIFont DDBoldFont:17];
    if (app_font == nil) app_font = [UIFont boldSystemFontOfSize:17];
        
    NSDictionary *largeAtr = @{
        NSForegroundColorAttributeName: text_white_color,
        NSFontAttributeName: [app_font fontWithSize:34]
    };
    
    NSDictionary *standardAtr = @{
        NSForegroundColorAttributeName: text_white_color,
        NSFontAttributeName: app_font
    };
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] initWithIdiom:(UIUserInterfaceIdiomPhone)];
        [appearance configureWithTransparentBackground];
        appearance.titleTextAttributes = standardAtr;
        appearance.largeTitleTextAttributes = largeAtr;
        appearance.backgroundColor = UIColor.clearColor;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.compactAppearance = appearance;
        
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:(UIBarMetricsDefault)];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        self.navigationController.navigationBar.barTintColor = UIColor.clearColor;
        self.navigationController.navigationBar.tintColor = text_white_color;
        self.navigationController.navigationBar.titleTextAttributes = standardAtr;
        if (@available(iOS 11.0, *)) {
            self.navigationController.navigationBar.largeTitleTextAttributes = largeAtr;
        } else {
            // Fallback on earlier versions
        }
    }
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = UIColor.clearColor;
    self.navigationController.navigationBar.tintColor = text_white_color;
    self.navigationController.navigationBar.titleTextAttributes = standardAtr;
    [self setStatusBarStyle:(UIStatusBarStyleLightContent)];
}

-(void)setWhiteDragableNavigationBar {
    if (@available(iOS 11.0, *)) {
        [self.navigationController.navigationBar setPrefersLargeTitles:NO];
    } else {
        // Fallback on earlier versions
    }
    UIColor *text_color =  DDUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    if (text_color == nil) text_color = [UIColor blackColor];
    
    UIFont *app_font = [UIFont DDBoldFont:17];
    if (app_font == nil) app_font = [UIFont boldSystemFontOfSize:17];
    
    UIColor *whiteColor = [UIColor whiteColor];
    
    NSDictionary *largeAtr = @{
        NSForegroundColorAttributeName: text_color,
        NSFontAttributeName: [app_font fontWithSize:34]
    };
    
    NSDictionary *standardAtr = @{
        NSForegroundColorAttributeName: text_color,
        NSFontAttributeName: app_font
    };
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] initWithIdiom:(UIUserInterfaceIdiomPhone)];
        [appearance configureWithOpaqueBackground];
        appearance.titleTextAttributes = standardAtr;
        appearance.largeTitleTextAttributes = largeAtr;
        appearance.backgroundColor = whiteColor;
        appearance.shadowColor = UIColor.clearColor;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.compactAppearance = appearance;
    } else {
        self.navigationController.navigationBar.barTintColor = whiteColor;
        self.navigationController.navigationBar.tintColor = text_color;
        self.navigationController.navigationBar.titleTextAttributes = standardAtr;
        if (@available(iOS 11.0, *)) {
            self.navigationController.navigationBar.largeTitleTextAttributes = largeAtr;
        } else {
            // Fallback on earlier versions
        }
        self.navigationController.navigationBar.translucent = NO;
    }
    
    self.navigationController.navigationBar.barTintColor = whiteColor;
    self.navigationController.navigationBar.tintColor = text_color;
    self.navigationController.navigationBar.titleTextAttributes = standardAtr;
    
    UIView *indicator = [[UIView alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width/2-18, 10, 36, 4)];
    indicator.tag = -9999;
    indicator.layer.cornerRadius = 2;
    indicator.clipsToBounds = YES;
    indicator.backgroundColor = DDUIThemeManager.shared.selected_theme.bg_grey_220.colorValue;
    [self.navigationController.navigationBar addSubview:indicator];
    [self setStatusBarStyle:(UIStatusBarStyleDefault)];
}

-(void)setStatusBarStyle:(UIStatusBarStyle)style {
    DDCAppConfigManager.shared.statusBarStyle = style;
    [self.navigationController setNeedsStatusBarAppearanceUpdate];
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)setThemeNavigationBar {
    if (@available(iOS 11.0, *)) {
        [self.navigationController.navigationBar setPrefersLargeTitles:NO];
    } else {
        // Fallback on earlier versions
    }
    UIColor *text_white_color =  DDUIThemeManager.shared.selected_theme.text_white.colorValue;
    if (text_white_color == nil) text_white_color = UIColor.whiteColor;
    
    UIFont *app_font = [UIFont DDBoldFont:17];
    if (app_font == nil) app_font = [UIFont boldSystemFontOfSize:17];
    
    UIColor *theme_color = THEME.app_theme.colorValue;
    if (theme_color == nil) theme_color = [UIColor blueColor];
    
    NSDictionary *largeAtr = @{
        NSForegroundColorAttributeName: text_white_color,
        NSFontAttributeName: [app_font fontWithSize:34]
    };
    
    NSDictionary *standardAtr = @{
        NSForegroundColorAttributeName: text_white_color,
        NSFontAttributeName: app_font
    };
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] initWithIdiom:(UIUserInterfaceIdiomPhone)];
        [appearance configureWithOpaqueBackground];
        appearance.titleTextAttributes = standardAtr;
        appearance.largeTitleTextAttributes = largeAtr;
        appearance.backgroundColor = theme_color;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.compactAppearance = appearance;
    } else {
        self.navigationController.navigationBar.barTintColor = theme_color;
        self.navigationController.navigationBar.tintColor = text_white_color;
        self.navigationController.navigationBar.titleTextAttributes = standardAtr;
        if (@available(iOS 11.0, *)) {
            self.navigationController.navigationBar.largeTitleTextAttributes = largeAtr;
        } else {
            // Fallback on earlier versions
        }
    }
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.barTintColor = theme_color;
    self.navigationController.navigationBar.tintColor = text_white_color;
    self.navigationController.navigationBar.titleTextAttributes = standardAtr;
    UIView *indicator;
    while((indicator = [self.navigationController.navigationBar viewWithTag:-9999]) != nil) {
        [indicator removeFromSuperview];
    }
    
    [self setStatusBarStyle:(UIStatusBarStyleLightContent)];

}

- (void)largeNavigationBar {
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
        if (@available(iOS 13.0, *)) {
        }else{
            self.navigationController.view.backgroundColor = [DDUIThemeManager shared].selected_theme.app_theme.colorValue;
        }
    }
}

- (void)standardNavigationBar {
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = NO;
        self.navigationController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    }
}


- (void)setNativeNavigationBar {
    if (@available(iOS 13.0, *)) {
        self.navigationController.navigationBar.barTintColor = [UIColor systemBackgroundColor];
    } else { // default
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(247.0f/255.0f) green:(247.0f/255.0f) blue:(247.0f/255.0f) alpha:1];
    }
    self.navigationController.navigationBar.tintColor = [UIColor systemBlueColor];
    self.navigationController.navigationBar.titleTextAttributes = nil;
    self.navigationController.navigationBar.translucent = YES;
    
    [self setStatusBarStyle:(UIStatusBarStyleDefault)];
}

-(void)addNavigationItemWithTitle:(NSString* _Nullable)title
                       identifier:(NSString* _Nullable)identifier
                        tintColor:(UIColor *)tintColor
                        direction:(DDNavigationItemDirection)direction {
    [self addNavigationItemWithTitle:title image:nil identifier:identifier tintColor:tintColor direction:direction];
}

-(void)addNavigationItemWithImage:(NSString* _Nullable)image
                       identifier:(NSString* _Nullable)identifier
                        tintColor:(UIColor *)tintColor
                        direction:(DDNavigationItemDirection)direction {
    [self addNavigationItemWithTitle:nil image:image identifier:identifier tintColor:tintColor direction:direction];
}
-(void)addCrossImageWithColor:(UIColor *)color withDirection:(DDNavigationItemDirection)direction{
    [self addNavigationItemWithImage:@"ic-close.png" identifier:BACK_BTN_IDDDIFIER_CUSTOM tintColor:color direction:direction];
}
-(void)addBackArrowNavigtaionItemWithtitle:(NSString* _Nullable)title {
    [self addBackArrowNavigtaionItemWithtitle:title tintColor:DDUIThemeManager.shared.selected_theme.app_theme.colorValue];
}

-(void)addBackArrowNavigtaionItemWithtitle:(NSString* _Nullable)title tintColor:(UIColor* )tintColor {
    [self addNavigationItemWithTitle:title image:@"icNavBack.png" identifier:BACK_BTN_IDDDIFIER tintColor:tintColor direction:DDNavigationItemDirectionLeft ];
}

// Override this method to get navigation item action
- (void)didTapOnNavigationItem:(DDNavigationItem*)sender {
    if ([sender.identifier isEqualToString:BACK_BTN_IDDDIFIER] || [sender.identifier isEqualToString:BACK_BTN_IDDDIFIER_CUSTOM]){
        [self goBackWithCompletion:nil];
    }
}

// To get navigation item for show hide or change something in added item
- (DDNavigationItem*)navigationItemWithIdentifier:(NSString*)identifier {
    for (DDNavigationItem *item in self.navigationItems) {
        if ([item.identifier isEqualToString:identifier]) {
            return item;
        }
    }
    return nil;
}

// Internal method
-(void)addNavigationItemWithTitle:(NSString* _Nullable)title
                            image:(NSString* _Nullable)image
                       identifier:(NSString* _Nullable)identifier
                        tintColor:(UIColor* )tintColor
                        direction:(DDNavigationItemDirection)direction {
    
    if (self.navigationController == nil) return;
    if (title.length == 0 && image.length == 0) return;
    
    if (self.navigationItems == nil) {
        self.navigationItems = [NSMutableArray new];
    }
        
    DDNavigationItem *item = [DDNavigationItem nibInstanceOfClass:DDNavigationItem.class];
    item.text = title;
    item.tintColor = tintColor;
    item.identifier = identifier;
    item.image = image;
    item.direction = direction;
    __weak typeof (self) weakSelf = self;
    item.completion = ^(DDNavigationItem * sender) {
        [weakSelf didTapOnNavigationItem:sender];
    };
    
    [self.navigationItems addObject:item];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:item];

    if (direction == DDNavigationItemDirectionLeft) {
        NSMutableArray *barButtons = self.navigationItem.leftBarButtonItems.mutableCopy;
        if (barButtons == nil)
            barButtons = [NSMutableArray new];
        [barButtons addObject:barButton];
        [self.navigationItem setLeftBarButtonItems:barButtons];
    }
    else if (direction == DDNavigationItemDirectionRight){
        NSMutableArray *barButtons = self.navigationItem.rightBarButtonItems.mutableCopy;
        if (barButtons == nil)
            barButtons = [NSMutableArray new];
        [barButtons addObject:barButton];
        [self.navigationItem setRightBarButtonItems:barButtons];
    }else {
        self.navigationItem.titleView = item;
    }
}
-(void)setNavigationBarBackgroundColor:(UIColor *)color {
    self.navigationController.navigationBar.barTintColor = color;
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        view.backgroundColor = color;
    }
}
@end
