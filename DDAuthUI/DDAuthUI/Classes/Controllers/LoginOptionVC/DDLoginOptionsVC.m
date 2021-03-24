//
//  DDLoginOptionsVC.m
//  DDAuthUI
//
//  Created by Syed Qamar Abbas on 16/06/2020.
//


#import "DDLoginOptionsVC.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "Autolayout.h"
#import "DDAuth.h"
#import "DDAuthUIConstants.h"
#import "DDAuthUIManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

@interface DDLoginOptionsVC ()<ASAuthorizationControllerPresentationContextProviding,ASAuthorizationControllerDelegate, FBSDKLoginButtonDelegate, GIDSignInDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *facebookIcon;
@property (weak, nonatomic) IBOutlet UILabel *facebookLbl;
@property (weak, nonatomic) IBOutlet UIImageView *googleIcon;
@property (weak, nonatomic) IBOutlet UILabel *googleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *separatorImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *appleBtnContainerView;

@property (unsafe_unretained, nonatomic) IBOutlet FBSDKLoginButton *facebookBtn;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *facebookBtnOuter;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *googleBtn;

@property (unsafe_unretained, nonatomic) IBOutlet DDGradientButton *loginWithEmail;

@property (strong, nonatomic) DDSignupRequestM *signup;

@end

@implementation DDLoginOptionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].presentingViewController = self;
    [self checkAndAddAppleLoginButton];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarHidden:YES animated:NO];
}
-(void)designUI {
    self.titleLabel.textColor = THEME.text_black.colorValue;
    self.subtitleLabel.textColor = THEME.text_black.colorValue;
    self.titleLabel.font = [UIFont DDSemiBoldFont:20];
    self.subtitleLabel.font = [UIFont DDRegularFont:15];
    self.loginWithEmail.titleLabel.font = [UIFont DDSemiBoldFont:17];
    self.googleLbl.font = [UIFont DDSemiBoldFont:17];
    self.googleLbl.textColor = THEME.text_black.colorValue;
    
    self.facebookLbl.font = [UIFont DDSemiBoldFont:17];
    self.facebookLbl.textColor = THEME.text_white.colorValue;

    [self.loginWithEmail setTitleColor:THEME.text_white.colorValue forState:(UIControlStateNormal)];
    [self.loginWithEmail setTitle:CONTINUE_WITH_EMAIL.localized forState:(UIControlStateNormal)];
    
//    [self.googleBtn setTitleColor:THEME.text_black.colorValue forState:(UIControlStateNormal)];
    self.googleLbl.text = CONTINUE_WITH_GOOGLE.localized;
    self.facebookLbl.text = CONTINUE_WITH_FACEBOOK.localized;
    
    [self.googleIcon loadImageWithString:@"ic-google.png" forClass:self.class];
    [self.facebookIcon loadImageWithString:@"ic-facebook.png" forClass:self.class];
    [self.facebookBtn setHidden:YES];
    
    
    self.googleBtn.backgroundColor = THEME.text_grey_238.colorValue;
    self.googleBtn.cornerR = 12;
    self.facebookBtn.cornerR = 12;
    
    self.titleLabel.text = LOGIN_OPTION_TITLE.localized;
    self.subtitleLabel.text = LOGIN_OPTION_SUB_TITLE.localized;
    self.separatorImageView.backgroundColor = THEME.bg_grey_199.colorValue;
    self.separatorImageView.cornerR = 3;
    self.facebookBtnOuter.backgroundColor = @"3d5a96".colorValue;
    self.facebookBtn.permissions = @[@"public_profile", @"email"];
    self.facebookBtn.delegate = self;
    [self.googleBtn addTarget:self action:@selector(didTapLoginWithGoogle) forControlEvents:(UIControlEventTouchUpInside)];
    [self.separatorImageView setClipsToBounds:YES];
    [[GIDSignIn sharedInstance] restorePreviousSignIn];
    if ([FBSDKAccessToken currentAccessToken]) {
       //
    }
}
- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(nullable FBSDKLoginManagerLoginResult *)result
              error:(nullable NSError *)error; {
    
    if (!result.isCancelled) {
        __block FBSDKGraphRequest *req = [FBSDKGraphRequest.alloc initWithGraphPath:@"me" parameters:@{@"fields":@"email,name,first_name,middle_name,last_name"}];
        [UIApplication showDDLoaderAnimation];
        [req startWithCompletionHandler:^(FBSDKGraphRequestConnection * _Nullable connection, id  _Nullable resultObj, NSError * _Nullable error) {
            [UIApplication dismissDDLoaderAnimation];
            DDSignupRequestM *req = [((NSDictionary *)resultObj) decodeTo:DDSignupRequestM.class];
            req.third_party_id = result.token.userID;
            req.login_type = @"facebook";
            [FBSDKLoginManager.new logOut];
            [self createAndProceedUser:req];
        }];
    }
}
- (BOOL)loginButtonWillLogin:(FBSDKLoginButton *)loginButton {
    return YES;
}
-(void)createAndProceedUser:(DDSignupRequestM *)req {
//    if(req.canProceedThirdPartyLogin) {
        [DDAuthManager.shared signUpEmailValidate:req  andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (DDUserManager.shared.isLoggedIn) {
                [self dismissViewControllerAnimated:YES completion:^{
                    [self.navigation.routerModel sendDataCallback:nil withData:nil withController:self];
                }];
            }else {
                NSString *str = model.message;
                if (str.length > 0) {
                    str = error.localizedDescription;
                }
                [DDAlertUtils showOkAlertWithTitle:nil subtitle:str completion:nil];
            }
            
        }];
//    }
//    else {
//        [DDAlertUtils.shared showLoginWithThirdPartyResult:req.email andFirstName:req.first_name andLastName:req.last_name withCompletion:^(NSString * _Nullable email, NSString * _Nullable firstName, NSString * _Nullable lastName) {
//            if (email.length > 0 && firstName.length > 0) {
//                req.email = email;
//                req.first_name = firstName;
//                req.last_name = lastName;
//                [self createAndProceedUser:req];
//            }
//        }];
//    }
}
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
  if (error != nil) {
    if (error.code == kGIDSignInErrorCodeHasNoAuthInKeychain) {
      NSLog(@"The user has not signed in before or they have since signed out.");
    } else {
      NSLog(@"%@", error.localizedDescription);
    }
    return;
  }
    DDSignupRequestM *req = [DDSignupRequestM new];
    req.email = user.profile.email;
    req.third_party_id = user.userID;
    req.first_name = user.profile.givenName;
    req.last_name = user.profile.familyName;
    req.login_type = @"google";
    [self createAndProceedUser:req];
    [GIDSignIn.sharedInstance signOut];
}
-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
}
- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
  // Perform any operations when the user disconnects from app here.
  // ...
}
-(void)checkAndAddAppleLoginButton {
    
    if (@available(iOS 13.0, *)) {
        ASAuthorizationAppleIDButton *btn = [ASAuthorizationAppleIDButton.alloc initWithAuthorizationButtonType:(ASAuthorizationAppleIDButtonTypeSignIn) authorizationButtonStyle:(ASAuthorizationAppleIDButtonStyleBlack)];
        btn.cornerRadius = 12;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(didTapAppleLogin) forControlEvents:(UIControlEventTouchUpInside)];
        [self.appleBtnContainerView addSubview:btn];
        [Autolayout addConstrainsToParentView:self.appleBtnContainerView andChildView:btn withConstraintTypeArray:@[@(AutolayoutTop), @(AutolayoutBottom), @(AutolayoutLeft), @(AutolayoutRight)] andValues:@[@(0),@(0),@(0),@(0)]];
    } else {
        [self.appleBtnContainerView setHidden:YES];
        // Fallback on earlier versions
    }
}
-(void)didTapAppleLogin {
    if (@available(iOS 13.0, *)) {
        
        ASAuthorizationAppleIDProvider *provider = [ASAuthorizationAppleIDProvider.alloc init];
        ASAuthorizationAppleIDRequest *request = provider.createRequest;
        request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        ASAuthorizationController *controller = [ASAuthorizationController.alloc initWithAuthorizationRequests:@[request]];
        controller.presentationContextProvider = self;
        controller.delegate = self;
        [controller performRequests];
    }
}
-(IBAction)didTapLoginWithEmail {
    [self dismissViewControllerAnimated:YES completion:^{
        [DDAuthUIManager showLoginScreenOnController:UIApplication.topMostController WithcallBack:self.navigation.routerModel.callback];
    }];
}
-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error  API_AVAILABLE(ios(13.0)){
    NSLog(@"");
}
-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization  API_AVAILABLE(ios(13.0)){
    NSMutableString *mStr = [NSMutableString string];
//    mStr = [appleIDLoginInfoTextView.text mutableCopy];
    NSLog(@"Apple_Login_Success");
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        // ASAuthorizationAppleIDCredential
        ASAuthorizationAppleIDCredential *appleIDCredential = authorization.credential;
        NSString *user = appleIDCredential.user;
        self.signup = [DDSignupRequestM new];
        self.signup.third_party_id = appleIDCredential.user;
        self.signup.email = appleIDCredential.email;
        self.signup.first_name = appleIDCredential.fullName.givenName;
        self.signup.last_name = appleIDCredential.fullName.familyName;
        self.signup.login_type = @"apple";
        [self createAndProceedUser:self.signup];

    } else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
//        ASPasswordCredential *passwordCredential = authorization.credential;
//        NSString *user = passwordCredential.user;
//        NSString *password = passwordCredential.password;
//        NSString *user = passwordCredential.user;
//        self.signup.email = passwordCredential.email;
//        self.signup.first_name = passwordCredential.fullName.givenName;
//        self.signup.last_name = passwordCredential.fullName.familyName;
        
    } else {
//         mStr = [@"check" mutableCopy];
//        appleIDLoginInfoTextView.text = mStr;
    }
}
-(void)didTapLoginWithGoogle {
    [GIDSignIn.sharedInstance signIn];
}
-(ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller  API_AVAILABLE(ios(13.0)){
    return DDUIRouterManager.shared.applicationsWindow;
}
-(CGFloat)dragableHeight {
    [self.view layoutIfNeeded];
    return self.view.subviews.firstObject.frame.size.height;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTapLoginWithFacebookBtn:(id)sender {
    [self.facebookBtn sendActionsForControlEvents:(UIControlEventTouchUpInside)];
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Auth_Options andModuleName:@"DDAuthUI" withClassRef:self.class];
}
@end
