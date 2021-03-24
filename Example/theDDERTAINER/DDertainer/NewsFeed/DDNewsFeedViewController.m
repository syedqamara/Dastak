//
//  DDNewsFeedViewController.m
//  theDDERTAINER_Example
//
//  Created by Zubair Ahmad on 25/02/2020.
//

#import "DDNewsFeedViewController.h"
#import "DDNewsFeedTableViewController.h"


@interface DDNewsFeedViewController () <UIScrollViewDelegate>
@property (nonatomic ,strong) ABKNewsFeedTableViewController *newsFeed;
//@property (nonatomic ,strong) DDNewsFeedTableViewController *newsFeed;
@end

@implementation DDNewsFeedViewController

-(UITabBarItem *)tabBarItem {
    return [[UITabBarItem alloc]initWithTitle:@"Notifications" image:[UIImage imageNamed:@"icInactiveNotifications"] tag:3];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Notifications".localized;
        [self initAppBoyNews];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self setThemeNavigationBar];
    [self largeNavigationBar];
    
}

-(void) initAppBoyNews{
//    self.newsFeed = [[DDNewsFeedTableViewController alloc] init];
    self.newsFeed = [ABKNewsFeedTableViewController getNavigationFeedViewController];
    [self addChildViewController:self.newsFeed inContainerView:self.view];
}

@end
