//
//  DDPingsFriendsTVC.h
//  DDPingsUI
//
//  Created by Zubair Ahmad on 15/04/2020.
//

#import "DDPingBaseTVC.h"
#import <DDModels/DDModels.h>
#import "DDPingsThemeManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPingsFriendsTVC : DDPingBaseTVC
@property (weak, nonatomic) IBOutlet UIImageView *selectionImgV;
@property (weak, nonatomic) IBOutlet UIButton *selectionBtn;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@end

NS_ASSUME_NONNULL_END
