//
//  DDFamilyPendingInvitesVC.h
//  DDFamilyUI
//
//  Created by Awais Shahid on 03/02/2020.
//

#import <UIKit/UIKit.h>
#import "DDFamilyBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDFamilyPendingInvitesVC : DDFamilyBaseVC
@property (nonatomic, copy) void (^ _Nullable familyVCCallBack)(id _Nullable data);
@end

NS_ASSUME_NONNULL_END
