//
//  DDTempVC.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 06/02/2020.
//

#import "DDTempVC.h"

@interface DDTempVC ()

@end

@implementation DDTempVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)openMyfamilyAction:(id)sender {
    [DDFamilyUIManager.shared showMyFamilyFrom:self withData:nil andControllerCallBack:nil];
}

- (IBAction)logout:(id)sender {
    [DDUserManager.shared logout];
}


@end
