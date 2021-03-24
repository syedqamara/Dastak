//
//  DDGamificationShareNotification.h
//  TheEntertainer
//
//  Created by Raheel Ahmad on 10/14/15.
//  Copyright © 2015 THE DDERTAINER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DDUI/DDUI.h>

@interface DDGamificationShareNotification : DDUIBaseViewController

@property (nonatomic, weak) IBOutlet UILabel *notificMsgLbl;
@property (nonatomic, weak) IBOutlet UILabel *notificNameLbl;
@property (nonatomic, weak) IBOutlet UIButton *shareButton;
@property (nonatomic, strong) IBOutlet UIImageView *notificImgView;

@property (nonatomic, assign) BOOL isLevel;

-(void) setDetailWithShareButtonEnable:(NSString *) url name:(NSString *) name message:(NSString *) message shareMessage:(NSString *) shareMessage reward_id:(NSString *) reward_id levelBadgeId:(NSNumber *) levelBadgeId ;

@end
