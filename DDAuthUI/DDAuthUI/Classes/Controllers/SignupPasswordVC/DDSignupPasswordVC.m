//
//  DDSignupPasswordVC.m
//  DDAuth
//
//  Created by M.Jabbar on 07/01/2020.
//

#import "DDSignupPasswordVC.h"
#import "NimbusKitAttributedLabel.h"
#import "DDAuthConstants.h"
#import <DDConstants/DDConstants.h>
#import "DDAuthUIThemeManager.h"
#import "DDRegexTableViewCell.h"
#import "DDModels/DDModels.h"
#import "DDAuthUIManager.h"
#import "DDAuthUIConstants.h"
#import "Appboy.h"
#import <DDAnalyticsManager.h>

@interface DDSignupPasswordVC ()<UITableViewDelegate, UITableViewDataSource>{
    DDSignupRequestM *signUp;
    UIBarButtonItem *skipButton;
    
}
@property (weak, nonatomic) IBOutlet UILabel *welcomeBackLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *passwordTxt;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *confirmPasswordTxt;
@property (weak, nonatomic) IBOutlet UIButton *showPasswordBtn;
@property (weak, nonatomic) IBOutlet UIButton *showConfirmPasswordBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

@end

@implementation DDSignupPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerCellWithNibNames:@[@"DDRegexTableViewCell"] forClass:self.class withIdentifiers:@[@"DDRegexTableViewCell"]];
    [self.tableView setSeparatorColor:UIColor.clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setScrollEnabled:NO];
    [self.tableView reloadData];
    signUp = (DDSignupRequestM*)self.navigation.routerModel.data;
    if (signUp == nil ) {
        signUp = [[DDSignupRequestM alloc] init];
    }
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    [self.passwordTxt addTarget:self action:@selector(textFieldDidChangeText:) forControlEvents:(UIControlEventEditingChanged)];
    [self.confirmPasswordTxt addTarget:self action:@selector(textFieldDidChangeText:) forControlEvents:(UIControlEventEditingChanged)];
    [self calculateAndSetPasswordRulesTableViewHeight];
}
-(void)calculateAndSetPasswordRulesTableViewHeight {
    [self.view layoutIfNeeded];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
//You must need to set the Color Themes Here
-(void)designUI {
   
    self.passwordTxt.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.passwordTxt.placeHolderColor = DDAuthUIThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.passwordTxt.font = [UIFont DDRegularFont:17];
    self.passwordTxt.secureTextEntry = YES;
    self.passwordTxt.placeholder = PASSWORD_TF_PLACEHOLDER.localized;

    self.confirmPasswordTxt.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.confirmPasswordTxt.placeHolderColor = DDAuthUIThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.confirmPasswordTxt.font = [UIFont DDRegularFont:17];
    self.confirmPasswordTxt.secureTextEntry = YES;
    self.confirmPasswordTxt.placeholder = PASSWORD_CONFIRM_TF_PLCAEHOLDER.localized;

    [self.showPasswordBtn setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"eye"] forState:UIControlStateNormal];
    [self.showPasswordBtn setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"cross_eye"] forState:UIControlStateSelected];

    [self.showConfirmPasswordBtn setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"eye"] forState:UIControlStateNormal];
    [self.showConfirmPasswordBtn setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"cross_eye"] forState:UIControlStateSelected];

    
    self.welcomeBackLbl.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.welcomeBackLbl.font = [UIFont DDBoldFont:28];
    self.welcomeBackLbl.text = YOU_NEED_PASSWORD.localized;

    self.messageLbl.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.messageLbl.font = [UIFont DDRegularFont:15];
    self.messageLbl.text = PASSWORD_LENGHT_MESSAGE.localized;
    
   
    [self.registerBtn setTitleColor:DDAuthUIThemeManager.shared.selected_theme.text_white.colorValue forState:(UIControlStateNormal)];
    self.registerBtn.backgroundColor = DDAuthUIThemeManager.shared.selected_theme.app_theme.colorValue;
    self.registerBtn.titleLabel.font = [UIFont DDBoldFont:17];
    [self.registerBtn setTitle:REGISTER.localized forState:UIControlStateNormal];

    self.view.backgroundColor = DDAuthUIThemeManager.shared.selected_theme.bg_white.colorValue;
    
    [self addBackArrowNavigtaionItemWithtitle:BACK tintColor:DDAuthUIThemeManager.shared.selected_theme.text_theme.colorValue];
    [self updateRegisterButton];
    
}
-(void)textFieldDidChangeText:(UITextField *)textField {
    signUp.password = self.passwordTxt.text;
    signUp.confirm_password = self.confirmPasswordTxt.text;
    if (textField == self.passwordTxt) {
        [self passwordTextDidChange:textField];
    }
    [self updateRegisterButton];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)passwordEyeBtnAction:(UIButton*)sender {
    sender.selected = !sender.selected;
    sender.selected ? (self.passwordTxt.secureTextEntry = NO):(self.passwordTxt.secureTextEntry = YES);
    
}
- (IBAction)confirmPasswordEyeBtnAction:(UIButton*)sender {
    sender.selected = !sender.selected;
    sender.selected ? (self.confirmPasswordTxt.secureTextEntry = NO):(self.confirmPasswordTxt.secureTextEntry = YES);
    
}
-(void)passwordTextDidChange:(UITextField *)textField {
    NSString *text = textField.text;
    
    [self.tableView reloadData];
}

-(void)updateRegisterButton {
    NSString *validateInfo = [self validateInfo];
    if (validateInfo.length == 0) {
        self.registerBtn.enabled = YES;
        [self.registerBtn setTitleColor:DDAuthUIThemeManager.shared.selected_theme.text_white.colorValue forState:(UIControlStateNormal)];
    }else {
        self.registerBtn.enabled = NO;
        [self.registerBtn setTitleColor:[DDAuthUIThemeManager.shared.selected_theme.text_white.colorValue colorWithAlphaComponent:0.5] forState:(UIControlStateNormal)];
    }
}

#pragma TableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;//passwordRegex.password_rules.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDRegexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DDRegexTableViewCell"];
//    DDRegexM *regex = passwordRegex.password_rules[indexPath.row];
//    cell.titleLabel.text = regex.info_text;
//    cell.titleLabel.textColor = regex.titleColor;
//    cell.titleLabel.font = [UIFont DDRegularFont:13];
//    [cell.validationImageView sd_setImageWithURL:regex.imageURL.URLValue completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        cell.validationImageView.image = image;
//    }];
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PASSWORD_RULES_ROW_HEIGHT;
}
- (IBAction)didTapRegisterButton:(id)sender {
    NSString *validateInfo = [self validateInfo];
    if (validateInfo.length == 0) {
        [self signUpUser];
    } else {
        [DDAlertUtils showOkAlertWithTitle:nil subtitle:validateInfo completion:nil];
    }
}
-(NSString*)validateInfo{
    NSString *errorMessage = @"";
    if (signUp.password == nil || signUp.password.length == 0) {
        errorMessage = @"Enter Password".localized;
    }
    else if (!signUp.password.isValidNewPassword) {
        errorMessage = PASSWORD_ERROR_MESSAGE.localized;
    }
    else if (signUp.confirm_password == nil || signUp.confirm_password.length == 0) {
        errorMessage = @"Enter Confirm Password".localized;
    }
   else if (!signUp.confirm_password.isValidNewPassword) {
       errorMessage = @"Confirm password is invalid".localized;
    }
    else if (![signUp.confirm_password isEqualToString:signUp.password]) {
        errorMessage = @"Password and  Confirm password not match".localized;
    }
    return errorMessage;
}
-(void)signUpUser {
    [DDAuthManager.shared signUpUser:signUp andCompletion:^(DDAuthSignupResponseM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (model != nil) {
            if (model.message != nil) {
                BOOL isLoggedIn = NO;
                if (model.data != nil){
                    DDAuthLoginDataM *loginModel = model.data;
                }
                if (!isLoggedIn){
                    [DDAlertUtils showOkAlertWithTitle:nil subtitle:model.message completion:nil];
                }
            }
        }else {
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
        }
    }];
}

-(void) trackRegisterEvents:(NSNumber *) userId email:(NSString *) email {
    
    if (userId && email){
        [APP_ANALYTICS trackEvent:APPBOY_EVDD_REGISTRATION_COMPLETE withType:DDEventTypeBraze andParam:@{} andEventDescription:@""];
    }
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Auth_Sign_Up_Password andModuleName:@"DDAuthUI" withClassRef:self.class];
}
@end
