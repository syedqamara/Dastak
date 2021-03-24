//
//  NotificationViewController.h
//  NotificationContentExtension
//
//  Created by Zubair Ahmad on 09/05/2020.
//

#import <UIKit/UIKit.h>
#import <AppboyPushStory/AppboyPushStory.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController : UIViewController <UNNotificationContentExtension>

@property (nonatomic) IBOutlet ABKStoriesView *storiesView;
@property (nonatomic) ABKStoriesViewDataSource *dataSource;

@end

