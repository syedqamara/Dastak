//
//  DDFilterUIManager.h
//  DDFiltersUI
//
//  Created by Umair on 27/02/2020.
//

#import <Foundation/Foundation.h>
#import "DDFamilyBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDFilterUIManager : NSObject

+(DDFilterUIManager *)shared;

-(void)showFilterOptionsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;

@end

NS_ASSUME_NONNULL_END
