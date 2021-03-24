//
//  DDThemeViewController.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//

#import "DDUIThemeViewController.h"
#import "DDUIThemeManager.h"

@interface DDUIThemeViewController ()

@end

@implementation DDUIThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(reloadAllScreens) name:DDUIThemeManager.theme_changed_notification_name object:nil];
    [self designUI];
    // Do any additional setup after loading the view.
}
-(void)reloadAllScreens {
    [self designUI];
}
-(void)designUI {
    
}
-(void)didAddedToWindow {
    
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
