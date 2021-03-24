//
//  DDFamilyUIManager.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 06/02/2020.
//

#import "DDFamilyUIManager.h"
#import "DDAuth.h"
#import "DDFamilyListingVM.h"

@implementation DDFamilyUIManager


static DDFamilyUIManager *_sharedObject;
+(DDFamilyUIManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [DDFamilyUIManager.alloc init];
    });
    return _sharedObject;
}

-(DDEmptyViewModel*)checkAndGetEmptyViewModelForFamily:(DDFamilyApiDataM*)apiData {
    
    DDEmptyViewModel *emptyVM;
    
    if (apiData.message.length > 0) {
        if (apiData.member_info.isPrimaryMember && apiData.members.count == 0) {
            emptyVM = [DDEmptyViewModel new];
            emptyVM.title = apiData.message;
            if (apiData.detail_description != nil && apiData.detail_description.length){
                emptyVM.sub_title = apiData.detail_description;
            }else{
                emptyVM.sub_title = @"You can give up to 4 family members exclusive access to your account, they can be changed anytime".localized;
            }
            emptyVM.btn_title = @"Start My Family".localized;
            emptyVM.image = @"youHaventCreatedFamily.png";
        }
        else if (apiData.pending_invites.count == 0) {
            emptyVM = [DDEmptyViewModel new];
            emptyVM.title = apiData.message;
            emptyVM.image = @"youHaventCreatedFamily.png";
        }
    }
    return emptyVM;
}

-(DDEmptyViewModel*)checkAndGetEmptyViewModelForFriends:(DDFriendsAPI*)apiData {
    DDEmptyViewModel *emptyVM = [DDEmptyViewModel new];
    emptyVM.title = @"It looks like you haven’t add a friend yet.";
    emptyVM.sub_title = @"Add friends to see who is saving more!";
    emptyVM.btn_title = @"Add a Friend";
    emptyVM.image = @"family.png";
    if (apiData.message.length > 0) {
        emptyVM.title = apiData.title;
        emptyVM.sub_title = apiData.message;
    }
    return emptyVM;
}

-(DDEmptyViewModel*)checkAndGetEmptyViewModelForReferAFriend:(DDFriendsAPI*)apiData {
    DDEmptyViewModel *emptyVM = [DDEmptyViewModel new];
    emptyVM.title = @"Refer a friend to get the Entertainer and earn 2500 smiles";
    emptyVM.sub_title = @"Once they’ve purchase any of our products, you’ll get 2500 smiles to buy back more offers. ";
    emptyVM.btn_title = @"Share Your Link";
    emptyVM.image = @"referAFriend.png";
    if (apiData.message.length > 0) {
        emptyVM.title = apiData.title;
        emptyVM.sub_title = apiData.message;
    }
    return emptyVM;
}


-(void)showFamilyInviationReceivedFrom: (DDPendingNotificatiosModel*)data  onController:(UIViewController *)controller {
    DDCustomeActionSheetM * model = [[DDCustomeActionSheetM alloc] init];
    model.title =  data.pending_invite.title;
    model.subtitle = data.pending_invite.message;
    model.Image = data.family_image_url;
    model.btnsArray = @[@"Join".localized,@"Not right now".localized];
    [DDCustomActionSheet showWithData:model withCompletion:^(int index) {
        if (index == 0){
            [self openMyFamilyVC:controller];
        }
    }];
}

- (void) openMyFamilyVC : (UIViewController *)controller {
    [[DDWebManager  shared] openURL:@"entertainer://myfamily" title:@"" onController:controller];
}

-(void)showMyFamilyFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    
    [self showControllerFrom:controller
                  route_link:DD_Nav_MY_Family
                  transition:DDUITransitionPush
                   animation:YES
                        data:data
          controllerCallBack:controllerCallBack];
}

-(void)showFamilyMemberDetailFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    
    [self showControllerFrom:controller
                  route_link:DD_Nav_Family_Member_Details
                  transition:DDUITransitionPush
                   animation:YES
                        data:data
          controllerCallBack:controllerCallBack];
}

-(void)showAddNewFamilyMemeberFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    
    [self showControllerFrom:controller
                  route_link:DD_Nav_Add_New_Family_Member
                  transition:DDUITransitionPush
                   animation:YES
                        data:data
          controllerCallBack:controllerCallBack];
}

-(void)showTempVCFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    
    [self showControllerFrom:controller
                  route_link:DD_Nav_Family_Temp
                  transition:DDUITransitionPush
                   animation:YES
                        data:data
          controllerCallBack:controllerCallBack];
}


-(void)showMyFriendsFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    
    [self showControllerFrom:controller
                  route_link:DD_Nav_My_Friends
                  transition:DDUITransitionPush
                   animation:YES
                        data:data
          controllerCallBack:controllerCallBack];
}

-(void)showMyFriendsLeaderBoardFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    
    [self showControllerFrom:controller
                  route_link:DD_Nav_My_Friends_LeaderBoard
                  transition:DDUITransitionPush
                   animation:YES
                        data:data
          controllerCallBack:controllerCallBack];
}

-(void)showReferAFriendFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    
    [self showControllerFrom:controller
                  route_link:DD_Nav_Refer_A_Friend
                  transition:DDUITransitionPush
                   animation:YES
                        data:data
          controllerCallBack:controllerCallBack];
}

-(void)showFriendDetailsFrom:(UIViewController*)controller withData:(id _Nullable)data andControllerCallBack:(ControllerCallBack)controllerCallBack {
    
    [self showControllerFrom:controller
                  route_link:DD_Nav_Friend_Details
                  transition:DDUITransitionPush
                   animation:YES
                        data:data
          controllerCallBack:controllerCallBack];
}

-(void)showControllerFrom:(UIViewController*)controller
               route_link:(NSString* _Nonnull)route_link
               transition:(DDUITransition)transition
                animation:(BOOL)animation
                     data:(id _Nullable)data
       controllerCallBack:(ControllerCallBack)controllerCallBack {
    
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = route_link;
    route.transition = transition;
    route.is_animated = animation;
    if (data) route.data = data;
    if (controllerCallBack) route.callback = controllerCallBack;
    [DDUIRouterManager.shared navigateTo:@[route] onController:controller];

}




@end
