//
//  DDUIRouterConfigurationM.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 26/12/2019.
//

#import "DDUIRouterConfigurationM.h"
#import "DDUIBaseViewController.h"
#import "UIViewController+DDViewController.h"
#import "DDUIRouterManager.m"

@implementation DDUIRouterConfigurationM
-(instancetype)initWithRouteName:(NSString *)routeName andModuleName:(NSString *)moduleName withClassRef:(Class)classRef {
    self = [super init];
    self.class_object = classRef;
    self.module_name = moduleName;
    self.route_name = routeName;
    return self;
}
+(void)configureWithRouteName:(NSString *)routeName andModuleName:(NSString *)moduleName withClassRef:(Class)classRef {
    DDUIRouterConfigurationM *config = [DDUIRouterConfigurationM.alloc initWithRouteName:routeName andModuleName:moduleName withClassRef:classRef];
    [DDUIRouterManager.shared addRouteToConfiguration:config];
}

-(UIViewController *)viewController {
    UIViewController *vc = [[self.class_object alloc]initWithNibName:NSStringFromClass(self.class_object) forClass:self.class_object];
    if (vc == nil) {
        vc = [[self.class_object alloc]init];
    }
    
    return vc;
}

@end
