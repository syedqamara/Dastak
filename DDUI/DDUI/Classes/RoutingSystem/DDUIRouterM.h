//
//  DDUIRouter.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 26/12/2019.
//

#import <Foundation/Foundation.h>
#import "DDUIRouterConfigurationM.h"
#import <DDCommons/DDCommons.h>
#import "DDDeeplinkModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDUITransition) {
    DDUITransitionPush,
    DDUITransitionPresent,
    DDUITransitionPresentWithPan,
    DDUITransitionPresentWithPan2,
    DDUITransitionWindows,
    DDUITransitionTabs,
    DDUITransitionEmbedInTab,
};

typedef NS_ENUM(NSUInteger, DDUIRouterAuthPermissionType) {
    DDUIRouterAuthPermissionTypeProceed,
    DDUIRouterAuthPermissionTypeStop,
    DDUIRouterAuthPermissionTypeAsk,
};


@interface DDUIRouterM : NSObject
@property (strong, nonatomic) NSString *auto_generated_unique_identifier;
@property (strong, nonatomic) NSString *route_link;
@property (strong, nonatomic) NSString *action_identifier;
@property (assign, nonatomic) DDUITransition transition;
///default value will be `DDUIRouterAuthPermissionTypeProceed`
@property (assign, nonatomic) DDUIRouterAuthPermissionType auth_permission;
@property (assign, nonatomic) BOOL select_tab_tabbar_controller;
@property (assign, nonatomic) BOOL is_animated;
@property (assign, nonatomic) BOOL should_embed_in_nav;
@property (strong, nonatomic) id data;
@property (assign, nonatomic) CGFloat panModelHeight;
@property (assign, nonatomic) BOOL panDraggableInFullScreen;
@property (assign, nonatomic) BOOL disableUpwardPan;
@property (strong, nonatomic, nullable) DDDeeplinkModel *deeplinkModel;
@property (nonatomic, strong) ControllerCallBack callback;
@property (nonatomic, strong) DeeplinkInvokingCallback deeplinkCallBack;
@property (nonatomic, copy) VoidCompletionCallBack transitionCallBack;

-(void)sendDataCallback:(NSString * _Nullable)identifier withData:(id _Nullable)data withController:(UIViewController * _Nullable)controller;
-(void)sendDeeplinkCallbackWithData:(id _Nullable)data withController:(UIViewController *  _Nullable)controller;

@end

@interface DDUIRouterInfoM : NSObject
@property (strong, nonatomic) NSString *route_link;
@property (strong, nonatomic) DDUIRouterM *routerModel;
@property (strong, nonatomic) UIViewController *vc;
@property (strong, nonatomic) Class class_object;

-(instancetype)initWithConfiguration:(DDUIRouterConfigurationM *)configuration andRouteModel:(DDUIRouterM *)route;
-(instancetype)init NS_UNAVAILABLE;
-(void)startTransitionOn:(UIViewController *)controller withCompletion:(void (^)(void))completion;
-(void)removeDeeplinkModel;
@end

NS_ASSUME_NONNULL_END
