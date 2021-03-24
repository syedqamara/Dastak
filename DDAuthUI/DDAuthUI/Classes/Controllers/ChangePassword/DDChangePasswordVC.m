//
//  DDChangePasswordVC.m
//  DDAuthUI
//
//  Created by Syed Qamar Abbas on 23/07/2020.
//

#import "DDChangePasswordVC.h"
#import "DDGradientButton.h"
#import "DDAuthUIThemeManager.h"
#import "DDHomeManager.h"
#import "DDAuthManager.h"
@interface DDChangePasswordVC ()
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *newpasswordTF;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *confirmPasswordTF;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *passwordTF;
@property (unsafe_unretained, nonatomic) IBOutlet DDGradientButton *submitBtn;

@end

@implementation DDChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Change Password".localized;
    [self addBackArrowNavigtaionItemWithtitle:@""];
    // Do any additional setup after loading the view from its nib.
}
-(void)designUI {
    self.newpasswordTF.font = [UIFont DDRegularFont:17];
    self.confirmPasswordTF.font = [UIFont DDRegularFont:17];
    self.passwordTF.font = [UIFont DDRegularFont:17];
    self.newpasswordTF.textColor = AUTH_THEME.text_black_40.colorValue;
    self.confirmPasswordTF.textColor = AUTH_THEME.text_black_40.colorValue;
    self.passwordTF.textColor = AUTH_THEME.text_black_40.colorValue;
    self.newpasswordTF.placeholder = @"New password".localized;
    self.confirmPasswordTF.placeholder = @"Confirm new password".localized;
    self.passwordTF.placeholder = @"Current password".localized;
    self.submitBtn.titleLabel.font = [UIFont DDSemiBoldFont:17];
    [self.submitBtn setTitleColor:AUTH_THEME.text_white.colorValue forState:(UIControlStateNormal)];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.submitBtn.cornerR = 12;
    [self.submitBtn setTitle:@"Submit".localized forState:UIControlStateNormal];
    [self.submitBtn setClipsToBounds:YES];
    [self.submitBtn addTarget:self action:@selector(didTapSubmitBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        
}
    -(void)didTapSubmitBtn:(UIButton *)button {
        if (self.passwordTF.text.length < 6) {
            [DDAlertUtils showOkAlertWithTitle:@"Error" subtitle:@"Enter minimum 6 characters" completion:nil];
            return;
        }
        if (self.newpasswordTF.text.length < 6) {
            [DDAlertUtils showOkAlertWithTitle:@"Error" subtitle:@"Enter minimum 6 characters" completion:nil];
            return;
        }
        if (self.confirmPasswordTF.text.length < 6) {
            [DDAlertUtils showOkAlertWithTitle:@"Error" subtitle:@"Enter minimum 6 characters" completion:nil];
            return;
        }
        
        if (![self.confirmPasswordTF.text.lowercaseString isEqualToString:self.confirmPasswordTF.text.lowercaseString]) {
            [DDAlertUtils showOkAlertWithTitle:@"Error" subtitle:@"Confirm Password didn't matched" completion:nil];
            return;
        }
        DDBaseRequestModel *req = [DDBaseRequestModel new];
        [req addCustomParams:@{
            @"new_password": self.newpasswordTF.text,
            @"current_password": self.passwordTF.text,
        }];
        [DDAuthManager.shared changePassword:req showHUD:YES onCompletion:^(DDBaseApiModel * _Nullable model, NSError * _Nullable error) {
            if (model.message.length > 0) {
                [DDAlertUtils showOkAlertWithTitle:@"" subtitle:model.message completion:nil];
            }
            if (error != nil) {
                [DDAlertUtils showOkAlertWithTitle:@"" subtitle:error.localizedDescription completion:nil];
            }
        }];
    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Auth_Change_Password andModuleName:@"DDAuthUI" withClassRef:self];
}
@end
