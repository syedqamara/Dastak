//
//  DDUIRouter.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 26/12/2019.
//

#import "DDUIRouterM.h"
#import "DDUIBaseViewController.h"
#import <DDUIRouterManager.h>
#import "UIWindow+RootVC.h"
#import "UIViewController+DDViewController.h"
#import "DDNavigationProtocol.h"
#import "DDDraggableVC.h"
#import "HWPanModal.h"
#import "DDDraggableNavigationController.h"


@interface DDNavigationController : UINavigationController

@end

@implementation DDNavigationController
-(void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    [super setNavigationBarHidden:hidden animated:animated];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return DDCAppConfigManager.shared.statusBarStyle;
}

@end


@implementation DDUIRouterM
-(id)copy {
    DDUIRouterM *router = [[DDUIRouterM alloc]init];
    router.auto_generated_unique_identifier = self.auto_generated_unique_identifier;
    router.route_link = self.route_link;
    router.action_identifier = self.action_identifier;
    router.transition = self.transition;
    router.is_animated = self.is_animated;
    router.should_embed_in_nav = self.should_embed_in_nav;
    router.data = self.data;
    router.callback = self.callback;
    router.deeplinkCallBack = self.deeplinkCallBack;
    router.transitionCallBack = self.transitionCallBack;
    router.auth_permission = self.auth_permission;
    router.select_tab_tabbar_controller = self.select_tab_tabbar_controller;
    return router;
}
-(instancetype)init{
    self = [super init];
    NSUUID *uuid = [NSUUID UUID];
    NSString *unique_id = [NSString stringWithFormat:@"ios-%@",[uuid UUIDString]];
    self.auto_generated_unique_identifier = unique_id;
    self.is_animated = YES;
    return self;
}
-(void)sendDataCallback:(NSString *)identifier withData:(id)data withController:(UIViewController *)controller {
    if (self.callback != nil) {
        self.callback(identifier, data, controller);
    }
}
-(void)sendDeeplinkCallbackWithData:(id _Nullable)data withController:(UIViewController *  _Nullable)controller {
    if (self.deeplinkCallBack != nil) {
        self.deeplinkCallBack(data, controller);
    }
}
@end
@implementation DDUIRouterInfoM
-(void)startTransitionOn:(UIViewController *)controller withCompletion:(void (^)(void))completion {
    if (self.vc) {
        
        switch (self.routerModel.transition) {
            case DDUITransitionPush: {
                if ([controller isKindOfClass:UINavigationController.class]) {
                    [((UINavigationController *)controller) pushViewController:self.vc animated:self.routerModel.is_animated];
                }else if ([controller isKindOfClass:UITabBarController.class]) {
                    [self startTransitionOn:((UITabBarController *)controller).selectedViewController withCompletion:completion];
                }else {
                    [controller.navigationController pushViewController:self.vc animated:self.routerModel.is_animated];
                }
                completion();
                break;
            }
            case DDUITransitionPresent: {
                if (self.routerModel.should_embed_in_nav) {
                    UIViewController *viewController = [[DDNavigationController alloc]initWithRootViewController:self.vc];
                    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
                    [controller presentViewController:viewController animated:self.routerModel.is_animated completion:completion];
                }else {
                    self.vc.modalPresentationStyle = UIModalPresentationFullScreen;
                    [controller presentViewController:self.vc animated:self.routerModel.is_animated completion:completion];
                }
                break;
            }
            case DDUITransitionPresentWithPan: {
                DDDraggableVC *panVC = [[DDDraggableVC alloc] initWithNibName:NSStringFromClass(DDDraggableVC.class) forClass:DDDraggableVC.class];
                if (panVC == nil) {
                    [self startTransitionOn:controller withCompletion:completion];
                    return;
                }
                __block UIViewController *draggableContainerVC;
                if (self.routerModel.should_embed_in_nav) {
                    UINavigationController *nav = [[DDNavigationController alloc]initWithRootViewController:self.vc];
                    draggableContainerVC = nav;
                }else {
                    draggableContainerVC = self.vc;
                }
                __weak typeof(panVC) panViewController = panVC;
                panVC.completionCallBack = ^{
                    [panViewController addChildViewController:draggableContainerVC inContainerView:panViewController.dragableContentView];
                };
                panVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [controller presentViewController:panVC animated:YES completion:nil];
                
                break;
            }
            case DDUITransitionPresentWithPan2: {
                if (self.routerModel.should_embed_in_nav) {
                    DDDraggableNavigationController *nav = [[DDDraggableNavigationController alloc] initWithRootViewController:self.vc];
                    nav.panModelHeight = self.routerModel.panModelHeight;
                    nav.panDraggableInFullScreen = self.routerModel.panDraggableInFullScreen;
                    nav.disableUpwardPan = self.routerModel.disableUpwardPan;
                    [controller presentPanModal:nav completion:completion];
                }else {
                    [controller presentPanModal:self.vc completion:completion];
                }
                break;
            }
            case DDUITransitionWindows: {
                __weak id <DDNavigationProtocol> navingVC = (id<DDNavigationProtocol>)self.vc;
                if (navingVC != nil) {
                    [navingVC didAddedToWindow];
                }
                if (self.routerModel.should_embed_in_nav) {
                    UINavigationController *navVC = [UINavigationController.alloc initWithRootViewController:self.vc];
                    [DDUIRouterManager.shared.applicationsWindow setNewRootVC:navVC];
                }else {
                    [DDUIRouterManager.shared.applicationsWindow setNewRootVC:self.vc];
                }
                
                
                break;
            }
            case DDUITransitionTabs: {
                __weak id <DDNavigationProtocol> tabvc = (id<DDNavigationProtocol>) [DDUIRouterManager.shared.applicationsWindow.rootViewController getViewControllerByClass:self.class_object];
                if (tabvc != nil) {
                    tabvc.navigation = self;
                }
                break;
            }
            case DDUITransitionEmbedInTab: {
                UIViewController *viewController = self.vc;
                __weak id <DDNavigationProtocol> baseVC = (id<DDNavigationProtocol>)viewController;
                if (baseVC != nil) {
                    baseVC.navigation = self;
                }
//                UITabBarItem *item = ((DDUIBaseViewController *)self.vc).tabItem;
                if (self.routerModel.should_embed_in_nav) {
                    viewController = [[DDNavigationController alloc]initWithRootViewController:self.vc];
                }
                [viewController setTabBarItem:self.vc.tabBarItem];
                UITabBarController *tabVC = (UITabBarController *)controller;
                
                BOOL isAdded = [tabVC addViewControllerToTabbar:viewController];
                if (self.routerModel.select_tab_tabbar_controller) {
                    NSInteger index = [tabVC.viewControllers indexOfObject:viewController];
                    [tabVC setSelectedIndex:index];
                }
                if (!isAdded) {
                    NSAssert(false, @"DD-Crash: Failed to Add %@ in Tabbar Controller",NSStringFromClass(self.class_object));
                }
                break;
            }
        }
        self.vc = nil;
    }else {
        NSAssert(false, @"DD-Crash: ViewController is not loaded for Transition %@",self.class_object);
    }
}
-(instancetype)initWithConfiguration:(DDUIRouterConfigurationM *)configuration andRouteModel:(DDUIRouterM *)route {
    self = [super init];
    self.route_link = configuration.route_name;
    self.class_object = configuration.class_object;
    self.routerModel = route;
    self.vc = (UIViewController *)[configuration viewController];
    id <DDNavigationProtocol> routeVC = (id<DDNavigationProtocol>)self.vc;
    if (routeVC != nil) {
        routeVC.navigation = self;
    }
    return self;
}
-(void)removeDeeplinkModel {
    self.routerModel.deeplinkModel = nil;
}
@end
