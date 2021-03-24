//
//  DDMapsUIManager.h
//  DDMapsUI
//
//  Created by Zubair Ahmad on 06/02/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>
#import <DDUI/DDUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDMapsUIManager : NSObject
+(DDMapsUIManager *)shared;

-(void)showOutletsListingFrom:(UIViewController*)controller withReqModel:(DDBaseRequestModel*)reqM andControllerCallBack:(ControllerCallBack)controllerCallBack;

-(void)showMerchantDetailsFrom:(UIViewController*)controller withOutlet:(id)outlet andControllerCallBack:(ControllerCallBack)controllerCallBack;
@end


NS_ASSUME_NONNULL_END
