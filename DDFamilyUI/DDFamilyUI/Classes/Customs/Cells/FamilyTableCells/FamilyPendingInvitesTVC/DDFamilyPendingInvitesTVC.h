//
//  DDFamilyPendingInvitesTVC.h
//  DDFamilyUI
//
//  Created by Awais Shahid on 03/02/2020.
//

#import <UIKit/UIKit.h>
#import "DDFamilyBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN


@protocol DDFamilyPendingInvitesTVCDelegate <NSObject>
-(void)rejectAction:(DDPendingInviteInfoM*)invite;
-(void)acceptAction:(DDPendingInviteInfoM*)invite;
@end

@interface DDFamilyPendingInvitesTVC : DDFamilyBaseTVC
@property (weak, nonatomic) id<DDFamilyPendingInvitesTVCDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
