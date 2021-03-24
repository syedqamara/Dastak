//
//  DDSplashVC.m
//  dynamicdelivery
//
//  Created by Syed Qamar Abbas on 15/09/2020.
//  Copyright © 2020 Syed Qamar Abbas. All rights reserved.
//

#import "DDSplashVC.h"
#import "DDAuth.h"
#import "DDCoreLocation.h"
@interface DDSplashVC ()

@end

@implementation DDSplashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [DDCoreLocation.shared requestUserLocation];
    [DDAuthManager.shared config:nil andCompletion:^(DDConfigApiM * _Nullable model, NSURLResponse * _Nullable resp, NSError * _Nullable error) {
        [self.navigation.routerModel sendDataCallback:nil withData:nil withController:self];
    }];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Splash andModuleName:@"" withClassRef:self];
}
+(void)openSplash:(ControllerCallBack)callBack {
    DDUIRouterM *fav = [[DDUIRouterM alloc]init];
    fav.route_link = DD_Nav_Splash;
    fav.should_embed_in_nav = NO;
    fav.transition = DDUITransitionWindows;
    fav.callback = callBack;
    [DDUIRouterManager.shared navigateTo:@[fav] onController:UIApplication.topMostController];
}
@end
