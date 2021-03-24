//
//  DDLocationsUIManager.h
//  DDLocationsUI
//
//  Created by Zubair Ahmad on 06/02/2020.
//

#import <Foundation/Foundation.h>
#import "DDLocationsBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDLocationsUIManager : NSObject

+(DDLocationsUIManager *)shared;
-(void)showDeliveryLocationsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showAddNewLocationsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showSearchLocationsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showCashlessLocationDetailsVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showAppLocationsVCFrom:(UIViewController*)controller withData:(id _Nullable)data
        andControllerCallBack:(ControllerCallBack)controllerCallBack;
@end

NS_ASSUME_NONNULL_END
