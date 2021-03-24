//
//  DDUIRouterConfigurationM.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 26/12/2019.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDUIRouterConfigurationM : NSObject
@property (strong, nonatomic) NSString *route_name;
@property (strong, nonatomic) NSString *module_name;
@property (assign, nonatomic) Class class_object;

-(instancetype)initWithRouteName:(NSString *)routeName andModuleName:(NSString *)moduleName withClassRef:(Class)classRef;
+(void)configureWithRouteName:(NSString *)routeName andModuleName:(NSString *)moduleName withClassRef:(Class)classRef;
-(UIViewController *)viewController;
-(instancetype)init NS_UNAVAILABLE;
@end

NS_ASSUME_NONNULL_END
