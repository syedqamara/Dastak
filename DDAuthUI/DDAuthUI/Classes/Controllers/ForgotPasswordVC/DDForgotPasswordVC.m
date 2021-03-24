//
//  ForgotPasswordVC.m
//  DDAuth
//
//  Created by M.Jabbar on 06/01/2020.
//

#import "DDForgotPasswordVC.h"
#import <DDAuth/DDAuth.h>
#import "DDAuthConstants.h"
#import "DDAuthUIThemeManager.h"
#import "DDAuthUIConstants.h"

@interface DDForgotPasswordVC ()

@property (weak, nonatomic) IBOutlet ACFloatingTextField *emailTxt;
@property (weak, nonatomic) IBOutlet UILabel *welcomeBackLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation DDForgotPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackArrowNavigtaionItemWithtitle:@""];
}

-(void)designUI {
  
    self.emailTxt.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.emailTxt.font = [UIFont DDRegularFont:17];
    self.emailTxt.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailTxt.placeholder = EMAIL_TF_PLACEHOLDER.localized;

    self.view.backgroundColor = DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue;
   
    self.welcomeBackLbl.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.welcomeBackLbl.font = [UIFont DDBoldFont:28];
    self.welcomeBackLbl.text = FORGOT_PASSWORD.localized;

    self.messageLbl.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.messageLbl.font = [UIFont DDRegularFont:15];
    self.messageLbl.text = FORGOT_PASSWORD_MESSAGE.localized;

    [self.submitBtn setTitleColor:DDAuthUIThemeManager.shared.selected_theme.text_white.colorValue forState:(UIControlStateNormal)] ;
    self.submitBtn.titleLabel.font = [UIFont DDBoldFont:17];
    [self.submitBtn setTitle:SUBMIT.localized forState:UIControlStateNormal];
}
-(void)forgotPassword {
    DDBaseRequestModel *reqM = [DDBaseRequestModel new];
    reqM.custom_parameters = @{@"email":self.emailTxt.text}.mutableCopy;
    [DDAuthManager.shared forgotPassword:reqM andCompletion:^(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (model.message.length > 0) {
            [DDAlertUtils showOkAlertWithTitle:@"" subtitle:model.message completion:nil];
        }else {
            [DDAlertUtils showOkAlertWithTitle:@"" subtitle:error.localizedDescription completion:nil];
        }
    }];
}
- (IBAction)submitButtonTapped:(id)sender {
    if (self.emailTxt.text.length > 0 && self.emailTxt.text.isValidEmail) {
        [self forgotPassword];
    } else {
        [DDAlertUtils showOkAlertWithTitle:INVALID_EMAIL_MESSAGE.localized subtitle:nil completion:nil];
    }
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Auth_Forgot_Password andModuleName:@"DDAuthUI" withClassRef:self.class];
}
@end
