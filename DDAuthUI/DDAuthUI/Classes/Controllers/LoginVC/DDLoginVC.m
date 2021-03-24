//
//  DDLoginVC.m
//  DDAuth
//
//  Created by M.Jabbar on 26/12/2019.
//

#import "DDLoginVC.h"
#import "DDAuthConstants.h"
#import <DDConstants/DDConstants.h>
#import "DDAuthUIThemeManager.h"
#import "NimbusKitAttributedLabel.h"
#import "DDWebManager.h"
#import "DDAuthUIManager.h"
#import "DDAuthUIConstants.h"

@interface DDLoginVC () {
    DDLoginRequestM *login;
}
@property (weak, nonatomic) IBOutlet UILabel *dontHaveAccountLabel;

@property (weak, nonatomic) IBOutlet UILabel *welcomeBackLbl;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordBtn;
@property (weak, nonatomic) IBOutlet UIButton *createAccountBtn;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *emailTxt;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *passwordTxt;
@property (weak, nonatomic) IBOutlet UIButton *privacyPolicyCheckBox;
@property (weak, nonatomic) IBOutlet UIButton *agrrementCheckBox;
@property (weak, nonatomic) IBOutlet UIButton *showPasswordBtn;
@property (weak, nonatomic) IBOutlet NIAttributedLabel *endUserLicenseAgreementLabel;
@property (weak, nonatomic) IBOutlet NIAttributedLabel *privacyPolicyLabel;

@end

@implementation DDLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    login = [[DDLoginRequestM alloc]init];
    [self addBackArrowNavigtaionItemWithtitle:@""];

    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    [self.emailTxt addTarget:self action:@selector(textFieldDidChangeText:) forControlEvents:(UIControlEventEditingChanged)];
    [self.passwordTxt addTarget:self action:@selector(textFieldDidChangeText:) forControlEvents:(UIControlEventEditingChanged)];

    self.passwordTxt.secureTextEntry = YES;
}
//You must need to set the Color Themes Here
-(void)designUI {
    self.emailTxt.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.emailTxt.placeHolderColor = DDAuthUIThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.emailTxt.font = [UIFont DDRegularFont:17];
    self.emailTxt.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailTxt.placeholder = [EMAIL_TF_PLACEHOLDER localized];

    self.passwordTxt.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.passwordTxt.placeHolderColor = DDAuthUIThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.passwordTxt.font = [UIFont DDRegularFont:17];
    self.passwordTxt.placeholder = [PASSWORD_TF_PLACEHOLDER localized];
    

    self.welcomeBackLbl.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    if (UIApplication.isRightToLeftDeviceSettings) {
        self.welcomeBackLbl.font = [UIFont DDBoldFont:24];
    }else {
        self.welcomeBackLbl.font = [UIFont DDBoldFont:28];
    }
    
    self.welcomeBackLbl.text = [HELLO_AGAIN localized];
    self.dontHaveAccountLabel.text = [DONOT_HAVE_ACCOUNT localized];
    
    

    [self.loginBtn setTitle:LOG_IN.localized forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:DDAuthUIThemeManager.shared.selected_theme.text_white.colorValue forState:(UIControlStateNormal)] ;
    self.loginBtn.backgroundColor = [DDAuthUIThemeManager.shared.selected_theme leftToRightAppThemeGradientForBound:self.loginBtn.frame];
    self.loginBtn.titleLabel.font = [UIFont DDBoldFont:17];
    
    self.view.backgroundColor = DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue;
    
    self.navigationController.navigationBar.barTintColor = DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue;
    self.navigationController.navigationBar.tintColor = DDAuthUIThemeManager.shared.selected_theme.text_theme.colorValue;
    
    self.createAccountBtn.titleLabel.font = [UIFont DDBoldFont:15];
    self.forgotPasswordBtn.titleLabel.font = [UIFont DDBoldFont:15];
    self.dontHaveAccountLabel.font = [UIFont DDRegularFont:15];
    self.dontHaveAccountLabel.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black.colorValue;
    
    
    
    [self.createAccountBtn setTitle:CREATE_AN_ACCOUNT.localized forState:UIControlStateNormal];
    [self.forgotPasswordBtn setTitle:FORGOT_PASSWORD.localized forState:UIControlStateNormal];
    [self.createAccountBtn setTitleColor:DDAuthUIThemeManager.shared.selected_theme.text_theme.colorValue forState:UIControlStateNormal];
    [self.forgotPasswordBtn setTitleColor:DDAuthUIThemeManager.shared.selected_theme.text_theme.colorValue forState:UIControlStateNormal];
    
    [self.showPasswordBtn setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"eye"] forState:UIControlStateNormal];
    [self.showPasswordBtn setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"cross_eye"] forState:UIControlStateSelected];

    
    UIImage *checkBox = [[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"checkbox"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIImage *unCheckBox = [[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"uncheckbox"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    [self.agrrementCheckBox setImage:unCheckBox forState:UIControlStateNormal];
    
    [self.agrrementCheckBox setImage:checkBox forState:UIControlStateSelected];
    [self.agrrementCheckBox setTintColor:DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue];
    
    [self.privacyPolicyCheckBox setImage:unCheckBox forState:UIControlStateNormal];
    [self.privacyPolicyCheckBox setImage:checkBox forState:UIControlStateSelected];
    [self.privacyPolicyCheckBox setTintColor:DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue];
    
    [_endUserLicenseAgreementLabel setDelegate:self];
    [_endUserLicenseAgreementLabel setDelegate:self];
    [_endUserLicenseAgreementLabel setText:[NSString stringWithFormat:@"%@.",EULA_TEXT_SDDANCE.localized]];
    [_endUserLicenseAgreementLabel setFont:[UIFont DDMediumFont:13.0] ];
    [_endUserLicenseAgreementLabel addLink:[NSURL URLWithString:[NSString stringWithFormat:@"endUserLicenseagreement"]] range:[_endUserLicenseAgreementLabel.text rangeOfString:[EULA_TEXT localized]]];
    [_endUserLicenseAgreementLabel setFont:[UIFont DDMediumFont:13.0] range:[_endUserLicenseAgreementLabel.text rangeOfString:[EULA_TEXT localized]]];
    [_endUserLicenseAgreementLabel setTextColor:[UIColor blackColor]];
    [_endUserLicenseAgreementLabel setLinkColor:DDAuthUIThemeManager.shared.selected_theme.text_theme.colorValue];
    [_endUserLicenseAgreementLabel setVerticalTextAlignment:NIVerticalTextAlignmentMiddle];
    _endUserLicenseAgreementLabel.tag = 101;
    
    [_privacyPolicyLabel setDelegate:self];
    _privacyPolicyLabel.tag = 102;
    [_privacyPolicyLabel setText:[NSString stringWithFormat:@"%@.",PRIVACY_TEXT_SDDANCE.localized]];
    [_privacyPolicyLabel setFont:[UIFont DDMediumFont:13.0]];
    [_privacyPolicyLabel addLink:[NSURL URLWithString:[NSString stringWithFormat:@"privacyPolicy"]] range:[_privacyPolicyLabel.text rangeOfString:[PRIVACY_TEXT localized]]];
    [_privacyPolicyLabel setFont:[UIFont DDMediumFont:13.0] range:[_privacyPolicyLabel.text rangeOfString:[PRIVACY_TEXT localized]]];
    [_privacyPolicyLabel setTextColor:[UIColor blackColor]];
    [_privacyPolicyLabel setTextColor:DDAuthUIThemeManager.shared.selected_theme.text_theme.colorValue range:[_privacyPolicyLabel.text rangeOfString:[PRIVACY_TEXT localized]]];
    [_privacyPolicyLabel setLinkColor:DDAuthUIThemeManager.shared.selected_theme.text_theme.colorValue];
    [_privacyPolicyLabel setVerticalTextAlignment:NIVerticalTextAlignmentMiddle];
    
}
-(void)textFieldDidChangeText:(UITextField *)textField {
    if (textField == self.emailTxt) {
        login.email = textField.text;
    }
    if (textField == self.passwordTxt) {
        login.password = textField.text;
    }
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
-(IBAction)createAccountButtonTapped:(id)sender
{
    [DDAuthUIManager showRegisterScreenOnController:self WithcallBack:^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
        if ([DDUserManager shared].isLoggedIn) {
            [self.navigation.routerModel sendDataCallback:identifier withData:data withController:controller];
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}
-(IBAction)forgetPasswordButtonTapped:(id)sender
{
    [DDAuthUIManager showForgotPasswordScreenOnController:self WithcallBack:nil];
}
-(IBAction)skipButtonTapped:(id)sender
{
    DDUserManager.shared.isSkipped = YES;
    [self.navigation.routerModel sendDataCallback:DD_CI_Auth_Login_Skip withData:nil withController:self];
}
-(IBAction)btnToggleAction:(UIButton*)sender{
     [self.view endEditing:YES];
    sender.selected = !sender.selected;
    if (sender.tag == 10){
        
        [self.agrrementCheckBox setSelected:sender.selected];
        login.is_user_agreement_accepted = [NSNumber numberWithBool:sender.selected];
        
    }else if (sender.tag == 11){
        [self.privacyPolicyCheckBox setSelected:sender.selected];
        login.is_privacy_policy_accepted = [NSNumber numberWithBool:sender.selected];
    }
}


- (IBAction)passwordEyeBtnAction:(UIButton*)sender {
    sender.selected = !sender.selected;
    sender.selected ? (self.passwordTxt.secureTextEntry = NO):(self.passwordTxt.secureTextEntry = YES);
    [self.showPasswordBtn setSelected:sender.selected];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didTapLoginButton:(id)sender {
    NSString *errorMessage = [self validateInfo];
    if (errorMessage.length == 0) {
        [DDAuthManager.shared loginUser:login andCompletion:^(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (model.successfulApi) {
                [self userDidLoggedIn];
            }else if(model.message.length > 0){
                [DDAlertUtils showOkAlertWithTitle:nil subtitle:model.message completion:nil];
            }
            else if(error.localizedDescription.length > 0){
                [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
            }
        }];
    }else{
        [DDAlertUtils showOkAlertWithTitle:errorMessage subtitle:nil completion:nil];
    }
   
}
-(void)userDidLoggedIn {
    [NSNotificationCenter.defaultCenter postNotificationName:DD_USER_LOGIN_NOTIFICATION object:nil];
    self.navigation.routerModel.is_animated = NO;
    [self goBackWithCompletion:^{
       [self.navigation.routerModel sendDataCallback:DD_CI_Auth_Login_Success withData:nil withController:self];
    }];
}
-(void)resendAtEmail:(NSString *)email {
    [DDAuthManager.shared resendEmail:email withCompletion:^(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (model.data.isSent && model.data.message.length > 0) {
//            [DDAlertUtils showOkAlertWithTitle:nil subtitle:model.data.message completion:nil];
//        }
    }];
}
-(NSString *)validateInfo {
    return login.validationError;
}

- (void)attributedLabel:(NIAttributedLabel *)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
    NSString *termsCopyURL = @"";
    NSString *title = @"";
    if(attributedLabel.tag == 101){
        termsCopyURL = [NSString stringWithFormat:DDCAppConfigManager.shared.app_config.END_USER_LIS_AGR,NSString.deviceLanguage];
        title = [EULA_TEXT localized];
    }else{
        termsCopyURL = [NSString stringWithFormat:DDCAppConfigManager.shared.app_config.PRIVACY_POLICY_URL,NSString.deviceLanguage];
        title = [PRIVACY_TEXT localized];
    }
    [self openGeneralWebController:termsCopyURL screenTitle:title];
}

-(void)openGeneralWebController:(NSString *)webUrl screenTitle:(NSString *)screenTitle  {
   
    if (webUrl.length == 0) {
        return;
    }
    [DDWebManager.shared openURL:webUrl title:screenTitle onController:self];

//    DDUIRouterM *route = [[DDUIRouterM alloc]init];
//    route.route_link = DD_Nav_UI_Web_View;
//    route.transition = DDUITransitionPresent;
//    route.is_animated = YES;
//    route.should_embed_in_nav = YES;
//
//    DDUIWebViewVM *webViewModel = [[DDUIWebViewVM alloc] init];
//    webViewModel.title = screenTitle;
//    webViewModel.webNavType = DDTRNavWithWhiteBG;
//    webViewModel.webCompletion = ^(NSNumber * _Nullable order_id, UIViewController * _Nullable controller) {
//
//    };
//    webViewModel.webViewCloseCompletion = ^(UIViewController * _Nonnull controller) {
//
//    };
//    webViewModel.request = [NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]];
//    route.data = webViewModel;
//
//    [DDUIRouterManager.shared navigateTo:@[route] onController:self];
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
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Auth_Login andModuleName:@"DDAuthUI" withClassRef:self.class];
}
@end
