
//
//  DDGamificationShareNotification.m
//  TheEntertainer
//
//  Created by Raheel Ahmad on 10/14/15.
//  Copyright © 2015 THE DDERTAINER. All rights reserved.
//

#import "DDGamificationShareNotification.h"
#import "DDGamificationManager.h"
#import <DDCommons/DDCommons.h>

@interface DDGamificationShareNotification (){
    NSString *shareMessageText;
    NSURL *shareMessageURL;
    NSURL *imageURL;
    NSNumber *levelBadgeId;
}

@end

@implementation DDGamificationShareNotification

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shareButton.layer.cornerRadius = 1.0;
    self.shareButton.layer.borderColor = UIColorFromRGB(0x4fa4cd).CGColor;
    self.shareButton.layer.borderWidth = 1;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setDetailWithShareButtonEnable:(NSString *) url name:(NSString *) name message:(NSString *) message shareMessage:(NSString *) shareMessage reward_id:(NSString *) reward_id levelBadgeId:(NSNumber *) levelBadgeIdTemp {
    levelBadgeId = levelBadgeIdTemp;
    shareMessageText = shareMessage;
    //    shareMessageURL = [NSURL URLWithString:url];
    NSString *newUrl = self.isLevel ? [NSString stringWithFormat:[DDGamificationManager sharedManager].LEVEL_URL, reward_id,NSString.deviceLanguage] : [NSString stringWithFormat:[DDGamificationManager sharedManager].BADGE_URL, reward_id,NSString.deviceLanguage];
    shareMessageURL = [NSURL URLWithString:newUrl];
    imageURL = [NSURL URLWithString:url];
    //[self.notificImgView sd_setImageWithURL:shareMessageURL];
    [self.notificMsgLbl setText:message];
    [self.notificNameLbl setText:name];
    [self.notificImgView sd_setImageWithURL:[NSURL URLWithString:url]];
    
    
    
    
    NSMutableDictionary* appBoyDic = [[NSMutableDictionary alloc]init];
    [appBoyDic setValue:[NSDate date] forKey:@"Leveldate"];
    [appBoyDic setValue:name forKey:@"LevelName"];
//    [[Appboy sharedInstance] logCustomEvent:@"New Level" withProperties:appBoyDic];
//    [[DDAppboyEventManager sharedInstance] addEventWithTitle:@"New Level" andParam:appBoyDic];
}


-(IBAction) shareButtonAction:(id)sender{
/*
    DDShareType type = self.isLevel ? DDShareLevel : DDShareBadge;

    if(type == DDShareLevel)
        [[DDCustomAppAnalytics defaultAnalytics]googleTagManagerPushDatawithScreenName:[NSString stringWithFormat:@"%@ - notifications - level",[[DDUserManager sharedManager] getSelectedLocation].name] event:@"level_share"];
    if(type == DDShareBadge)

        [[DDCustomAppAnalytics defaultAnalytics]googleTagManagerPushDatawithScreenName:[NSString stringWithFormat:@"%@ - notifications - badges",[[DDUserManager sharedManager] getSelectedLocation].name] event:@"badge_share"];

    [[KGModal sharedInstance] hideAnimated:YES withCompletionBlock:^{

        
        [self showShareViewController:type text:self.notificNameLbl.text image:imageURL.absoluteString contentURL:shareMessageURL.absoluteString];
        //[[DDSocialShareUtil sharedManager] showShareDialogWithText:shareMessageText url:shareMessageURL];
    }];
    */
}
/*
-(void) showShareViewController:(DDShareType) type text:(NSString *)text image:(NSString *) image contentURL:(NSString *) contentURL{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

    DDSocialShareViewController *controller =  [storyboard instantiateViewControllerWithIdentifier:@"DDSocialShareViewController"];
    controller.message = [[DDSocialShareUtil sharedManager] getShareText:type text:text merchantNameInCasePostRedemption:@""];
    controller.contenturl = contentURL;
    controller.image = image;
    controller.shareType = type;
    controller.common_id = levelBadgeId;
    //[controller applyAnimationSettings];
    
    
    if ([controller respondsToSelector:@selector(setTransitioningDelegate:)]){
        controller.transitioningDelegate = self.transitioningDelegate;  // this is important for the animation to work
    }

  //  [[KGModal sharedInstance] showWithContentViewController:controller];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    [[self topMostController] presentViewController:controller animated:YES completion:nil];

}
 */
- (IBAction)dismissPopup:(id)sender {
    [[KGModal sharedInstance] hideAnimated:YES];
}

-(UIViewController*) topMostController{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
