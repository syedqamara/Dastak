//
//  DDCashlessNavBaseVC.m
//  DDCashlessUI
//
//  Created by Syed Qamar Abbas on 21/04/2020.
//

#import "DDCashlessNavBaseVC.h"

#define DEFAULT_CUSTOM_NAV_BAR_HEIGHT 120

@interface DDCashlessNavBaseVC ()

@end

@implementation DDCashlessNavBaseVC
-(void)viewDidLoad {
    [self loadNavigationBar];
    [self setThemeNavigationBar];
    [super viewDidLoad];
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapSelectDeliveryLocation)];
    gest.numberOfTapsRequired = 1;
    [self.navigationBar.selectedTitleLabel setUserInteractionEnabled:YES];
    [self.navigationBar.selectedTitleLabel addGestureRecognizer:gest];
}
-(void)hideNavBarWithDuration:(NSTimeInterval)duration{
    if ([self shouldLoadNavigationBar]) {
        [self hideCustomNavBarWithDuration:duration];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}
-(void)showNavBarWithDuration:(NSTimeInterval)duration{
    if ([self shouldLoadNavigationBar]) {
        [self showCustomNavBarWithDuration:duration];
    }else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}
-(void)hideCustomNavBarWithDuration:(NSTimeInterval)duration{
    [UIView animateWithDuration:duration animations:^{
        self.navigationBarHeightConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}
-(void)showCustomNavBarWithDuration:(NSTimeInterval)duration{
    [UIView animateWithDuration:duration animations:^{
        self.navigationBarHeightConstraint.constant = DEFAULT_CUSTOM_NAV_BAR_HEIGHT;
        [self.view layoutIfNeeded];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }];
}
-(void)loadNavigationBar {
    DDCashlessNavigationBarView *navBar = [DDCashlessNavigationBarView nibInstanceOfClass:DDCashlessNavigationBarView.class];
    [navBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.navigationView addSubview:navBar];
    [Autolayout addConstrainsToParentView:self.navigationView andChildView:navBar withConstraintTypeArray:@[@(AutolayoutTop),@(AutolayoutRight),@(AutolayoutLeft),@(AutolayoutBottom)] andValues:@[@(0),@(0),@(0),@(0)]];
    [navBar.backButton addTarget:self action:@selector(didTapBackButton) forControlEvents:(UIControlEventTouchUpInside)];
    [navBar.optionsButton addTarget:self action:@selector(didTapOptionsButton) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationBar = navBar;
    
    [navBar setData:DDLocationsManager.shared.selectedCashlessDeliveryLocation];
    if (DDLocationsManager.shared.isLocationServicesEnable && DDLocationsManager.shared.selectedCashlessDeliveryLocation == nil) {
        __weak typeof(self) weakSelf = self;
        [DDLocationsManager.shared getCurrentDeliveryLocationWithGeoAdress:^(DDDeliveryAddressM * _Nullable adrs) {
            DDLocationsManager.shared.selectedCashlessDeliveryLocation = adrs;
            [navBar setData:DDLocationsManager.shared.selectedCashlessDeliveryLocation];
            [weakSelf deliveryLocationChanged];
        }];
    }
    [self.navigationBar.optionsButton setHidden:[self shouldHideOptionButton]];
    if (!self.shouldLoadNavigationBar) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self hideCustomNavBarWithDuration:0.0];
    }
}

-(void)designUI {
    [self addBackArrowNavigtaionItemWithtitle:@"Back".localized tintColor:CASHLESS_THEME.text_white.colorValue];
}

-(void)showMoreButton{
    [self addNavigationItemWithImage:@"icMore" identifier:@"more" tintColor:DDCashlessThemeManager.shared.selected_theme.text_white.colorValue direction:(DDNavigationItemDirectionRight)];
}
-(BOOL)shouldLoadNavigationBar {
    return NO;
}
-(BOOL)shouldHideOptionButton {
    return NO;
}
-(void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    if (sender.direction == DDNavigationItemDirectionRight) {
        [self didTapOptionsButton];
    }else {
        [self goBackWithCompletion:nil];
    }
}
-(void)didTapBackButton {
    [self goBackWithCompletion:nil];
}

-(void)didTapSelectDeliveryLocation {
    __weak typeof(self) weakSelf = self;
    [DDCashlessUIManager showDeliveryLocationsVCFrom:self withData:nil andControllerCallBack:^(NSString * _Nonnull txt, id _Nonnull data, UIViewController * _Nonnull from) {
        [from.navigationController dismissViewControllerAnimated:YES completion:nil];
        [weakSelf.navigationBar setData:data];
        [weakSelf deliveryLocationChanged];
    }];
}

-(void)didTapOptionsButton {
    
}



- (void)deliveryLocationChanged {

}


@end
