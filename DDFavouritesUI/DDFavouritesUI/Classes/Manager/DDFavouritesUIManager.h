//
//  DDFavouritesUIManager.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 06/02/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>
#import <DDUI/DDUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDFavouritesUIManager : NSObject
+(DDFavouritesUIManager *)shared;


-(void)showMerchantDetailsFrom:(UIViewController*)controller withModel:(DDMerchantDetailRequestM*)model andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(DDEmptyViewModel*)getEmptyViewModelForNoFavData;
@end


NS_ASSUME_NONNULL_END
