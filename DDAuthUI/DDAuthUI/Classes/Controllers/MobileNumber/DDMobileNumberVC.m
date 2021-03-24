//
//  DDSignupVC.m
//  DDAuth
//
//  Created by M.Jabbar on 07/01/2020.
//

#import "DDMobileNumberVC.h"
#import "NimbusKitAttributedLabel.h"
#import <DDConstants/DDConstants.h>
#import "DDAuthUIThemeManager.h"
#import "DDAuthUIManager.h"
#import "DDAuthUIConstants.h"
#import <DDCommons/DDCommons.h>

@interface DDMobileNumberVC ()<UITextFieldDelegate>{
    UIBarButtonItem *skipButton;
    DDCountryM *selectedCountry;
}

@property (weak, nonatomic) IBOutlet UILabel *welcomeBackLbl;
@property (weak, nonatomic) IBOutlet UIView *nextBtnOverlyView;
@property (weak, nonatomic) IBOutlet UIImageView *dropdownImageView;
@property (weak, nonatomic) IBOutlet UILabel *countryCodeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *countryImageView;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *phoneNumberTF;
@property (nonatomic) DDSignupRequestM *signUp;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) NSMutableArray<DDCountryM*> * _Nonnull countries;
@property (nonatomic) DDCountryM *selectedNationality;
@property (nonatomic) DDNationalityPicker * _Nonnull nationalityPicker;

@end

@implementation DDMobileNumberVC
@synthesize signUp;

- (void)viewDidLoad {
    [super viewDidLoad];
    signUp = [[DDSignupRequestM alloc]init];
//    skipButton = [[UIBarButtonItem alloc] initWithTitle:SKIP.localized style:UIBarButtonItemStyleDone target:self action:@selector(skipButtonTapped:)];
//    skipButton.tintColor = DDAuthUIThemeManager.shared.selected_theme.text_theme.colorValue;
    DDCountrySectionM *country = DDAuthManager.shared.config.data.supported_countries.firstObject;
    selectedCountry = country.phone_codes.firstObject;
    [self.navigationItem setRightBarButtonItem:skipButton animated:NO];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self checkAndHideNextOverlay];
}

//You must need to set the Color Themes Here
-(void)designUI {
    self.welcomeBackLbl.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.welcomeBackLbl.font = [UIFont DDBoldFont:28];
    self.welcomeBackLbl.text = WHATS_YOUR_MOBILE_NUMBER.localized;
    
    [self.phoneNumberTF addTarget:self action:@selector(textFieldDidChangeText:) forControlEvents:(UIControlEventEditingChanged)];
    
    self.phoneNumberTF.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.phoneNumberTF.placeHolderColor = DDAuthUIThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.phoneNumberTF.font = [UIFont DDRegularFont:17];
    self.phoneNumberTF.placeholder = PHONE_TF_PLACEHOLDER.localized;
    [self.phoneNumberTF setKeyboardType:(UIKeyboardTypeNumberPad)];
    self.countryCodeLabel.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.countryCodeLabel.font = [UIFont DDRegularFont:17];


    [self.nextBtn setTitleColor:DDAuthUIThemeManager.shared.selected_theme.text_white.colorValue forState:(UIControlStateNormal)] ;
    self.nextBtn.backgroundColor = [DDAuthUIThemeManager.shared.selected_theme leftToRightAppThemeGradientForBound:self.nextBtn.frame];
    self.nextBtn.titleLabel.font = [UIFont DDBoldFont:17];
    [self.nextBtn setTitle:NEXT.localized forState:UIControlStateNormal];
   

    self.view.backgroundColor = DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue;
    
    self.navigationController.navigationBar.barTintColor = DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue;
    self.navigationController.navigationBar.tintColor = DDAuthUIThemeManager.shared.selected_theme.text_theme.colorValue;
    
    self.dropdownImageView.image =  [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icArrowDown.png"];
//    self.countryImageView.image =  [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icArrowDown.png"];
    
    
    
//    [self.agrrementCheckBox setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"uncheckbox"] forState:UIControlStateNormal];
//    [self.agrrementCheckBox setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"checkbox"] forState:UIControlStateSelected];
//    [self.agrrementCheckBox setTintColor:DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue];
//
//    [self.privacyPolicyCheckBox setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"uncheckbox"] forState:UIControlStateNormal];
//    [self.privacyPolicyCheckBox setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"checkbox"] forState:UIControlStateSelected];
//    [self.privacyPolicyCheckBox setTintColor:DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue];
    
    
}
-(void)textFieldDidChangeText:(UITextField *)textField {
    [self checkAndHideNextOverlay];
}
-(void)checkAndHideNextOverlay {
    [self.nextBtnOverlyView setHidden:self.phoneNumberTF.text.length != 0];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(IBAction)skipButtonTapped:(id)sender
{
    DDUserManager.shared.isSkipped = YES;
    [self.navigation.routerModel sendDataCallback:DD_CI_Auth_Login_Skip withData:nil withController:self];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)didTapNextButton:(id)sender {
    NSString *validateInfo = [self validateInfo];
    if (validateInfo.length == 0) {
        [DDAuthManager.shared sendOTPWithRequestModel:signUp WithCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (model.http_code.integerValue == 200) {
                [DDAuthUIManager showVerifyMobileNumber:self withData:signUp WithcallBack:self.navigation.routerModel.callback];
            }
        }];
    }else {
        [DDAlertUtils showOkAlertWithTitle:validateInfo subtitle:nil completion:nil];
    }
}

-(void)signUpUser {
    [DDAuthUIManager showRegisterPasswordScreenOnController:self withData:signUp withcallBack:self.navigation.routerModel.callback];
}
-(NSString *)validateInfo {
    NSString *errorMessage = @"";
    if (self.phoneNumberTF.text.length > 0) {
        signUp.phone_number = self.phoneNumberTF.text;
    }
    if (self.countryCodeLabel.text.length > 0) {
        if ([self.countryCodeLabel.text containsString:@"+"]) {
            signUp.country_code = [NSString stringWithFormat:@"%@",self.countryCodeLabel.text];
        }else {
            signUp.country_code = [NSString stringWithFormat:@"+%@",self.countryCodeLabel.text];
        }
    }
    
    
    return errorMessage;
}

- (IBAction)didTapCountryButton:(id)sender {
    [self openCountries];
}
-(void)openCountries {
    __weak typeof(self) weakSelf = self;
    DDCountrySectionM *country = DDAuthManager.shared.config.data.supported_countries.firstObject;
    [DDAuthUIManager showCountryCodePicker:self withCountries:country.phone_codes withSelectedCountryCode:selectedCountry.code WithcallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        DDCountryM *country = data;
        self->selectedCountry = country;
        [controller dismissViewControllerAnimated:YES completion:nil];
        self.countryCodeLabel.text = self->selectedCountry.code;
    }];
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Auth_Mobile_Number andModuleName:@"DDAuthUI" withClassRef:self.class];
}
@end
