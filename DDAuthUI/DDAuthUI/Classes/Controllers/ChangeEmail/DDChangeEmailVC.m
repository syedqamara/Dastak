//
//  DDChangeEmailVC.m
//  DDAuthUI
//
//  Created by Syed Qamar Abbas on 23/07/2020.
//
#import "DDHomeManager.h"
#import "DDChangeEmailVC.h"
#import "DDCommons.h"
#import "DDGradientButton.h"
#import "DDAuthUIThemeManager.h"
#import "DDAuth.h"
#import "DDUserManager.h"
@interface DDChangeEmailVC ()
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *newemailTF;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *confirmEmailTF;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *passwordTF;
@property (unsafe_unretained, nonatomic) IBOutlet DDGradientButton *submitBtn;

@end

@implementation DDChangeEmailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Change Email".localized;
    
    [self addBackArrowNavigtaionItemWithtitle:@""];
    // Do any additional setup after loading the view from its nib.
}
-(void)designUI {
    self.newemailTF.font = [UIFont DDRegularFont:17];
    self.confirmEmailTF.font = [UIFont DDRegularFont:17];
    self.passwordTF.font = [UIFont DDRegularFont:17];
    self.newemailTF.textColor = AUTH_THEME.text_black_40.colorValue;
    self.confirmEmailTF.textColor = AUTH_THEME.text_black_40.colorValue;
    self.passwordTF.textColor = AUTH_THEME.text_black_40.colorValue;
    self.newemailTF.placeholder = @"New email".localized;
    self.confirmEmailTF.placeholder = @"Confirm new email".localized;
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
    if (!self.newemailTF.text.isValidEmail) {
        [DDAlertUtils showOkAlertWithTitle:@"Error" subtitle:@"Invalid Email" completion:nil];
        return;
    }
    if (!self.confirmEmailTF.text.isValidEmail) {
        [DDAlertUtils showOkAlertWithTitle:@"Error" subtitle:@"Invalid Email" completion:nil];
        return;
    }
    
    if (![self.confirmEmailTF.text.lowercaseString isEqualToString:self.newemailTF.text.lowercaseString]) {
        [DDAlertUtils showOkAlertWithTitle:@"Error" subtitle:@"Confirm Password didn't matched" completion:nil];
        return;
    }
    if (self.passwordTF.text.length < 6) {
        [DDAlertUtils showOkAlertWithTitle:@"Error" subtitle:@"Enter minimum 6 characters" completion:nil];
        return;
    }
    DDBaseRequestModel *req = [DDBaseRequestModel new];
    [req addCustomParams:@{
        @"email": self.newemailTF.text,
        @"current_email": DDUserManager.shared.currentUser.email,
        @"current_password": self.passwordTF.text,
    }];
    [DDAuthManager.shared changeEmail:req showHUD:YES onCompletion:^(DDBaseApiModel * _Nullable model, NSError * _Nullable error) {
        if (model.successfulApi) {
            DDUserManager.shared.currentUser.email = self.newemailTF.text;
            DDUserManager.shared.currentUser = DDUserManager.shared.currentUser;
        }
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
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Auth_Change_Email andModuleName:@"DDAuthUI" withClassRef:self];
}
@end
