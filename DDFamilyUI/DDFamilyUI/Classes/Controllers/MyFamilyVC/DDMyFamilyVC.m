//
//  DDMyFamilyVC.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 03/02/2020.
//

#import "DDMyFamilyVC.h"
#import "DDFamilyMembersListingVC.h"
#import "DDFamilyPendingInvitesVC.h"
#import <DDAuth/DDAuth.h>


@interface DDMyFamilyVC ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) DDFamilyMembersListingVC *membersListingVC;
@property (strong, nonatomic) DDFamilyPendingInvitesVC *pendingInvitesVC;

@end

@implementation DDMyFamilyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContainerChildren];
    [self fetchUserFamily];
}
//-(void)fetchMyFamily {
//    if (DDUserManager.shared.currentUser.is_primary.boolValue) {
//        [self fetchUserFamily];
//    }
//    else {
//        [self fetchPendingInvites];
//    }
//}

-(void)fetchUserFamily {
    __weak typeof(self) weakSelf = self;
    [DDFamilyManager.shared fetchMyFamilyWithRequestModel:nil WithCompletion:^(DDFamilyApiModel * _Nullable model, NSURLResponse * _Nullable response , NSError * _Nullable error) {
        if (error) {
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
        }
        else if (model) {
            if (model.successfulApi) {
                if (model.data.pending_invites_section != nil) {
                    [weakSelf display:weakSelf.pendingInvitesVC];
                    [weakSelf.pendingInvitesVC setupScreenFromData:model];
                }
                else {
                    [weakSelf display:weakSelf.membersListingVC];
                    [weakSelf.membersListingVC setupScreenFromData:model];
                }
            }
            else {
                [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:nil];
            }
        }
    }];
}

//-(void)fetchPendingInvites {
//    __weak typeof(self) weakSelf = self;
//    [DDFamilyManager.shared fetchFamilyPendingInvitesWithRequestModel:nil completion:^(DDFamilyApiModel * _Nullable model, NSURLResponse * _Nullable response , NSError * _Nullable error) {
//        if (error) {
//            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
//        }
//        else if (model) {
//            if (model.success.boolValue) {
//                [weakSelf display:weakSelf.pendingInvitesVC];
//                [weakSelf.pendingInvitesVC setupScreenFromData:model];
//            }
//            else {
//                [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:nil];
//            }
//        }
//    }];
//}


-(void)callBackFromMemberListing:(id _Nullable)data {
    [self fetchUserFamily];
}

-(void)callBackPendingInvites:(id _Nullable)data {
    [self fetchUserFamily];
}

#pragma mark - Container

-(void)setupContainerChildren {
    __weak typeof(self) weakSelf = self;
    
    self.membersListingVC = [[DDFamilyMembersListingVC alloc] initWithNibName:NSStringFromClass(DDFamilyMembersListingVC.class) forClass:DDFamilyMembersListingVC.class];
    self.membersListingVC.familyVCCallBack = ^(id _Nullable data) {
        [weakSelf callBackFromMemberListing:data];
    };
    
    self.pendingInvitesVC = [[DDFamilyPendingInvitesVC alloc] initWithNibName:NSStringFromClass(DDFamilyPendingInvitesVC.class) forClass:DDFamilyPendingInvitesVC.class];
    self.pendingInvitesVC.familyVCCallBack = ^(id _Nullable data) {
        [weakSelf callBackPendingInvites:data];
    };
}

-(void)display:(UIViewController*)vc {
    [self addChild:vc];
    if ([vc isKindOfClass:DDFamilyMembersListingVC.class]) {
        [self removeChild:self.pendingInvitesVC];
    }
    else {
        [self removeChild:self.membersListingVC];
    }
}

-(void)addChild:(UIViewController*)child {
    [self addChildViewController:child];
    [self.containerView addSubview:child.view];
    child.view.frame = self.containerView.frame;
    child.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [child didMoveToParentViewController:self];
}

-(void)removeChild:(UIViewController*)child {
    [child willMoveToParentViewController:nil];
    [child.view removeFromSuperview];
    [child removeFromParentViewController];
}


#pragma mark ---- Other

- (void)designUI {
    self.title = MY_FAMILY;
}

+(NSArray<DDUIRouterM *> *)deeplinkRoutes {
    DDUIRouterM *family = [[DDUIRouterM alloc]init];
    family.route_link = DD_Nav_MY_Family;
    family.should_embed_in_nav = YES;
    family.transition = DDUITransitionPush;
    return @[family];
}



@end
