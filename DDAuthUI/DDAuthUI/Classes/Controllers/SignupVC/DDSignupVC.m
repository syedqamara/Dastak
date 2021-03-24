//
//  DDSignupVC.m
//  DDAuth
//
//  Created by M.Jabbar on 07/01/2020.
//

#import "DDSignupVC.h"
#import "NimbusKitAttributedLabel.h"
#import <DDConstants/DDConstants.h>
#import "DDAuthUIThemeManager.h"
#import "DDAuthUIManager.h"
#import "DDAuthUIConstants.h"
#import <DDCommons/DDCommons.h>

@interface DDSignupVC ()<UITextFieldDelegate>{
    UIBarButtonItem *skipButton;
}
@property (nonatomic) DDSignupRequestM *signUp;
@property (weak, nonatomic) IBOutlet UILabel *welcomeBackLbl;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *alreadyRegisterLbl;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *emailTxt;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *firstNameTxt;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *lastNameTxt;
@property (weak, nonatomic) IBOutlet UIButton *privacyPolicyCheckBox;
@property (weak, nonatomic) IBOutlet UIView *nextBtnOverlyView;
@property (weak, nonatomic) IBOutlet UIButton *agrrementCheckBox;
@property (weak, nonatomic) IBOutlet NIAttributedLabel *endUserLicenseAgreementLabel;
@property (weak, nonatomic) IBOutlet NIAttributedLabel *privacyPolicyLabel;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *nationalityTextField;
@property (weak, nonatomic) IBOutlet UIImageView *nationalityDropDownImageView;

@property (strong, nonatomic) NSMutableArray<DDCountryM*> * _Nonnull countries;
@property (nonatomic) DDCountryM *selectedNationality;
@property (nonatomic) DDNationalityPicker * _Nonnull nationalityPicker;

@end

@implementation DDSignupVC
@synthesize signUp;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackArrowNavigtaionItemWithtitle:@""];
    signUp = [[DDSignupRequestM alloc]init];
//    skipButton = [[UIBarButtonItem alloc] initWithTitle:SKIP.localized style:UIBarButtonItemStyleDone target:self action:@selector(skipButtonTapped:)];
//    skipButton.tintColor = DDAuthUIThemeManager.shared.selected_theme.text_theme.colorValue;

    [self.navigationItem setRightBarButtonItem:skipButton animated:NO];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    [self.emailTxt addTarget:self action:@selector(textFieldDidChangeText:) forControlEvents:(UIControlEventEditingChanged)];
    [self.firstNameTxt addTarget:self action:@selector(textFieldDidChangeText:) forControlEvents:(UIControlEventEditingChanged)];
    [self.lastNameTxt addTarget:self action:@selector(textFieldDidChangeText:) forControlEvents:(UIControlEventEditingChanged)];
    [self.nationalityTextField addTarget:self action:@selector(textFieldDidChangeText:) forControlEvents:(UIControlEventEditingChanged)];
    [self checkAndHideNextButtonOverlay];
   _countries =  [[NSMutableArray alloc] initWithArray:[DDUserManager countries]];
    [self setnationality];
}

//You must need to set the Color Themes Here
-(void)designUI {
   
    self.emailTxt.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.emailTxt.placeHolderColor = DDAuthUIThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.emailTxt.font = [UIFont DDRegularFont:17];
    self.emailTxt.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailTxt.placeholder = EMAIL_PLACEHOLDER.localized;
    
    self.firstNameTxt.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.firstNameTxt.placeHolderColor = DDAuthUIThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.firstNameTxt.font = [UIFont DDRegularFont:17];
    self.firstNameTxt.placeholder = FIRST_NAME.localized;


    self.nationalityTextField.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.nationalityTextField.placeHolderColor = DDAuthUIThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.nationalityTextField.font = [UIFont DDRegularFont:17];
    self.nationalityTextField.placeholder = PASSWORD.localized;
    [self.nationalityTextField setSecureTextEntry:YES];
    
    
    self.lastNameTxt.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.lastNameTxt.placeHolderColor = DDAuthUIThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.lastNameTxt.font = [UIFont DDRegularFont:17];
    self.lastNameTxt.placeholder = LAST_NAME.localized;

    
    self.welcomeBackLbl.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.welcomeBackLbl.font = [UIFont DDBoldFont:28];
    self.welcomeBackLbl.text = CREATE_YOUR_ACCOUNT.localized;

    [self.nextBtn setTitleColor:DDAuthUIThemeManager.shared.selected_theme.text_white.colorValue forState:(UIControlStateNormal)] ;
    self.nextBtn.backgroundColor = [DDAuthUIThemeManager.shared.selected_theme leftToRightAppThemeGradientForBound:self.nextBtn.frame];
    self.nextBtn.titleLabel.font = [UIFont DDBoldFont:17];
    [self.nextBtn setTitle:NEXT.localized forState:UIControlStateNormal];
   
    [self.loginBtn setTitleColor:DDAuthUIThemeManager.shared.selected_theme.text_theme.colorValue forState:(UIControlStateNormal)] ;
    self.loginBtn.titleLabel.font = [UIFont DDBoldFont:17];
   
    self.alreadyRegisterLbl.font = [UIFont DDRegularFont:17];
    self.alreadyRegisterLbl.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.alreadyRegisterLbl.text = ALREADY_REGISTERD.localized;

    self.view.backgroundColor = DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue;
    
    self.navigationController.navigationBar.barTintColor = DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue;
    self.navigationController.navigationBar.tintColor = DDAuthUIThemeManager.shared.selected_theme.text_theme.colorValue;
    
    self.loginBtn.titleLabel.font = [UIFont DDBoldFont:15];
    [self.loginBtn setTitle:LOG_IN.localized forState:UIControlStateNormal];
    
    self.nationalityDropDownImageView.image =  [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icArrowDown"];
    
    UIImage *checkBox = [[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"checkbox"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIImage *unCheckBox = [[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"uncheckbox"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    [self.agrrementCheckBox setImage:unCheckBox forState:UIControlStateNormal];
    
    [self.agrrementCheckBox setImage:checkBox forState:UIControlStateSelected];
    [self.agrrementCheckBox setTintColor:DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue];
    
    [self.privacyPolicyCheckBox setImage:unCheckBox forState:UIControlStateNormal];
    [self.privacyPolicyCheckBox setImage:checkBox forState:UIControlStateSelected];
    [self.privacyPolicyCheckBox setTintColor:DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue];
    
    
//    [self.agrrementCheckBox setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"uncheckbox"] forState:UIControlStateNormal];
//    [self.agrrementCheckBox setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"checkbox"] forState:UIControlStateSelected];
//    [self.agrrementCheckBox setTintColor:DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue];
//
//    [self.privacyPolicyCheckBox setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"uncheckbox"] forState:UIControlStateNormal];
//    [self.privacyPolicyCheckBox setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"checkbox"] forState:UIControlStateSelected];
//    [self.privacyPolicyCheckBox setTintColor:DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue];
    
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
    [_privacyPolicyLabel setFont:[UIFont DDMediumFont:13.0] ];
    [_privacyPolicyLabel addLink:[NSURL URLWithString:[NSString stringWithFormat:@"privacyPolicy"]] range:[_privacyPolicyLabel.text rangeOfString:[PRIVACY_TEXT localized]]];
    [_privacyPolicyLabel setFont:[UIFont DDMediumFont:13.0] range:[_privacyPolicyLabel.text rangeOfString:[PRIVACY_TEXT localized]]];
    [_privacyPolicyLabel setTextColor:[UIColor blackColor]];
    [_privacyPolicyLabel setTextColor:DDAuthUIThemeManager.shared.selected_theme.text_theme.colorValue range:[_privacyPolicyLabel.text rangeOfString:[PRIVACY_TEXT localized]]];
    [_privacyPolicyLabel setLinkColor:DDAuthUIThemeManager.shared.selected_theme.text_theme.colorValue];
    [_privacyPolicyLabel setVerticalTextAlignment:NIVerticalTextAlignmentMiddle];
    
}
-(void)textFieldDidChangeText:(UITextField *)textField {
    if (textField == self.emailTxt) {
        signUp.email = textField.text;
    }
    if (textField == self.firstNameTxt) {
        signUp.first_name = textField.text;
    }
    if (textField == self.lastNameTxt) {
        signUp.last_name = textField.text;
    }
    if (textField == self.nationalityTextField) {
        signUp.password = textField.text;
    }
    [self checkAndHideNextButtonOverlay];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
-(void)setnationality{
    
    __weak __typeof(self) weakSelf = self;

    self.nationalityPicker = [DDNationalityPicker loadPicker];
    self.nationalityPicker.onSelection = ^(DDCountryM * _Nonnull selectedNationality) {
        weakSelf.signUp.country_of_residence = [NSString stringWithFormat:@"%@",selectedNationality.shortname];
        weakSelf.nationalityTextField.text = selectedNationality.name;
    };
    self.nationalityPicker.countries = self.countries;
    self.nationalityPicker.selectedNationality = [DDUserManager country:signUp.country_of_residence ?: @"AED"  countries:self.countries];
    self.nationalityTextField.delegate = self;
    
//    self.nationalityTextField.inputView = self.nationalityPicker;
}
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    [textField reloadInputViews];
//    if (textField == _nationalityTextField) {
//        [self.nationalityPicker selectCountry:self.nationalityPicker.selectedNationality.country_id ?: @(18)];
//    }
//    return YES;
//}
-(IBAction)loginButtonTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)skipButtonTapped:(id)sender
{
    DDUserManager.shared.isSkipped = YES;
    [self.navigation.routerModel sendDataCallback:DD_CI_Auth_Login_Skip withData:nil withController:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)btnToggleAction:(UIButton*)sender{
     [self.view endEditing:YES];
    sender.selected = !sender.selected;
    
    if (sender.tag == 10){
        
        [self.agrrementCheckBox setSelected:sender.selected];
        signUp.is_user_agreement_accepted = [NSNumber numberWithBool:sender.selected];
        
    }else if (sender.tag == 11){
        [self.privacyPolicyCheckBox setSelected:sender.selected];
        signUp.is_privacy_policy_accepted = [NSNumber numberWithBool:sender.selected];
    }
    
}

-(void)checkAndHideNextButtonOverlay {
//    [self.nextBtnOverlyView setHidden:[self validateInfo].length == 0];
    [self.nextBtnOverlyView setHidden:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didTapnationalityTextField:(id)sender {
    
    
//    [DDNationalityPicker showPicker:@"Nationality" selectedNationality:self.selectedNationality countries:_countries selectionBlock:^(DDCountryM * _Nonnull selectedNationality) {
//        self.selectedNationality = selectedNationality;
//        self->signUp.country_of_residence = [NSString stringWithFormat:@"%@",selectedNationality.country_id];
//        [self.nationalityTextField setTitle:selectedNationality.name forState:UIControlStateSelected];
//        [self.nationalityTextField setSelected:YES];
//
//    } hideBlock:^{
//
//    }];

}
- (IBAction)didTapNextButton:(id)sender {
    NSString *validateInfo = [self validateInfo];
    if (validateInfo.length == 0) {
        
        [[DDAuthManager shared] signUpEmailValidate:signUp andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error != nil){
                [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
            }else{
                DDAuthSignupResponseM *validationM = (DDAuthSignupResponseM*)model;
                if (validationM != nil && validationM.data != nil ) {
                    [self signUpUser];
                }else {
                    NSString *message = model.message;
                    if (message == nil || message.length < 1){
                        message = @"Something went wrog";
                    }
                    [DDAlertUtils showOkAlertWithTitle:nil subtitle:message completion:nil];
                }
            }
        }];
    }else {
        [DDAlertUtils showOkAlertWithTitle:validateInfo subtitle:nil completion:nil];
    }
}
-(void)openMobileNumberVC {
    [DDAuthUIManager showMobileNumber:self WithcallBack:self.navigation.routerModel.callback];
}
-(void)signUpUser {
    [self dismissViewControllerAnimated:NO completion:^{
        [self.navigation.routerModel sendDataCallback:nil withData:nil withController:nil];
    }];
}
-(NSString *)validateInfo {
    NSString *errorMessage = @"";
    
    if (signUp.first_name == nil || signUp.first_name.length == 0) {
        errorMessage = @"Enter first name".localized;
    }
    else if (signUp.last_name == nil || signUp.last_name.length == 0) {
        errorMessage = @"Enter last name".localized;
    }
    else if (signUp.email == nil || signUp.email.length == 0 || !signUp.email.isValidEmail) {
        errorMessage = INVALID_EMAIL_MESSAGE.localized;
    }
    else if (signUp.password.length == 0) {
        errorMessage = @"Enter Password".localized;
    }
    return errorMessage;
}

- (void)attributedLabel:(NIAttributedLabel *)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
    NSString *termsCopyURL = @"";
    NSString *title = @"";
    if(attributedLabel.tag == 101){
        termsCopyURL = [[DDCAppConfigManager.shared.app_config.END_USER_LIS_AGR add:@"?language="] add:NSString.deviceLanguage];
        title = [EULA_TEXT localized];
    }else{
        termsCopyURL = [[DDCAppConfigManager.shared.app_config.PRIVACY_POLICY_URL add:@"?language="] add:NSString.deviceLanguage];
        title = [PRIVACY_TEXT localized];
    }
    [self openGeneralWebController:termsCopyURL screenTitle:title];
}

-(void)openGeneralWebController:(NSString *)webUrl screenTitle:(NSString *)screenTitle  {
   
    [DDWebManager.shared openURL:webUrl title:screenTitle onController:self];
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Auth_Sign_Up andModuleName:@"DDAuthUI" withClassRef:self.class];
}
@end
