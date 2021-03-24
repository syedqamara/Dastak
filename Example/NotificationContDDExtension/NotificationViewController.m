//
//  NotificationViewController.m
//  NotificationContentExtension
//
//  Created by Zubair Ahmad on 09/05/2020.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <AppboyPushStory/AppboyPushStory.h>

@implementation NotificationViewController

- (void)didReceiveNotification:(UNNotification *)notification {
    self.dataSource = [[ABKStoriesViewDataSource alloc] initWithNotification:notification
                                                                 storiesView:self.storiesView
                                                                    appGroup:@"group.com.theentertainerme.TheEntertainer"];
}

- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response
                     completionHandler:(void (^)(UNNotificationContentExtensionResponseOption option))completion {
    UNNotificationContentExtensionResponseOption option = [self.dataSource didReceiveNotificationResponse:response];
    completion(option);
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.dataSource viewWillDisappear];
    [super viewWillDisappear:animated];
}

@end
