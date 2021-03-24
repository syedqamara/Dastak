//
//  DDLocationPermissionVC.m
//  DDLocationsUI
//
//  Created by Zubair Ahmad on 06/02/2020.
//

#import "DDLocationPermissionVC.h"
#import "DDLocationsUIConstants.h"
#import <DDCommons/DDCommons.h>
#import "DDCoreLocation.h"
#import "DDLocationsManager.h"

@interface DDLocationPermissionVC () <DDCoreLocationDelegate>

@end

@implementation DDLocationPermissionVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)designUI {
    self.view.backgroundColor = DDLocationsThemeManager.shared.selected_theme.bg_white.colorValue;
    self.lblTitle.font = [UIFont DDBoldFont:28];
    self.lblTitle.textColor = DDLocationsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.lblTitle.text = [NSString stringWithFormat:@"%@",K_LOCATIONS_PERMISSION_TITLE.localized];
    
    self.lblSubTitle.font = [UIFont DDRegularFont:15];
    self.lblSubTitle.textColor = DDLocationsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.lblSubTitle.text = [NSString stringWithFormat:@"%@",K_LOCATIONS_PERMISSION_SUBTITLE.localized];
    
    self.btnAccept.titleLabel.font = [UIFont DDBoldFont:17];
    self.btnAccept.backgroundColor = DDLocationsThemeManager.shared.selected_theme.app_theme.colorValue;
    [self.btnAccept setTitleColor:DDLocationsThemeManager.shared.selected_theme.text_white.colorValue forState:UIControlStateNormal];
    self.btnAccept.cornerR = 12.0;
    [self.btnAccept setTitle:[NSString stringWithFormat:@"%@",K_LOCATIONS_PERMISSION_ACCEPT_BUTTON.localized] forState:UIControlStateNormal];
    
    self.btnReject.titleLabel.font = [UIFont DDBoldFont:17];
    [self.btnReject setTitleColor:DDLocationsThemeManager.shared.selected_theme.app_theme.colorValue forState:UIControlStateNormal];
    [self.btnReject setTitle:[NSString stringWithFormat:@"%@",K_LOCATIONS_PERMISSION_REJECT_BUTTON.localized] forState:UIControlStateNormal];
    
    self.imageView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"location_permission.png"];
}

- (IBAction)permissionAcceptAction:(UIButton*)sender {
    [UIApplication showDDLoaderAnimation];
    [[DDCoreLocation shared] setDelegate:self];
    [[DDCoreLocation shared] requestUserLocation];
}

- (IBAction)permissionRejectAction:(UIButton*)sender {
    [self locationPermissionDidChanged];
}

- (void) locationDidFetched {
    DDLocationsManager.shared.isLocationPermissionScreenOpened = YES;
    [self locationPermissionDidChanged];
}

- (void) locationPermissionDidChanged {
    [UIApplication dismissDDLoaderAnimation];
    self.navigation.routerModel.callback(nil, nil, self);
    [self goBackWithCompletion:nil];
}
+(void)setRouteConfiguration {
    NSString *moduleName = @"DDLocations";
    
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Locations_Permission andModuleName:moduleName withClassRef:self.class];
}
@end
