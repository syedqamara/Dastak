//
//  DDFamilyUIManager.h
//  DDFamilyUI
//
//  Created by Awais Shahid on 06/02/2020.
//

#import <Foundation/Foundation.h>
#import "DDFamilyBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDFamilyUIManager : NSObject
+(DDFamilyUIManager *)shared;

-(DDEmptyViewModel*)checkAndGetEmptyViewModelForFamily:(DDFamilyApiDataM* _Nullable)apiData;
-(DDEmptyViewModel*)checkAndGetEmptyViewModelForFriends:(DDFriendsAPI* _Nullable)apiData;
-(DDEmptyViewModel*)checkAndGetEmptyViewModelForReferAFriend:(DDFriendsAPI* _Nullable)apiData;

-(void)showFamilyInviationReceivedFrom: (DDPendingNotificatiosModel*)data  onController:(UIViewController *)controller;

-(void)showMyFamilyFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showFamilyMemberDetailFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showAddNewFamilyMemeberFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showTempVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;

-(void)showMyFriendsFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showMyFriendsLeaderBoardFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showReferAFriendFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;
-(void)showFriendDetailsFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack;

@end

NS_ASSUME_NONNULL_END
