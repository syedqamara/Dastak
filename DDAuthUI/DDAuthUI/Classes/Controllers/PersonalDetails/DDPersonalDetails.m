//
//  DDPersonalDetails.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 25/07/2020.
//

#import "DDPersonalDetails.h"
#import "DDAuthUIThemeManager.h"
#import "DDUserManager.h"
@interface DDPersonalDetails ()

@property (unsafe_unretained, nonatomic) IBOutlet UISegmentedControl *genderSegmentControl;
@property (weak, nonatomic) IBOutlet DDGradientButton *saveBtn;
@property (strong, nonatomic) DDUserM *currentUser;
@end

@implementation DDPersonalDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [DDUserManager.shared.currentUser.toDictionary decodeTo:DDUserM.class];
    self.title = @"Personal Details".localized;
    [self setNavigationBarBackgroundColor:UIColor.whiteColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self addBackArrowNavigtaionItemWithtitle:nil];
    [self filledAvailableData];
    // Do any additional setup after loading the view from its nib.
}

-(void)filledAvailableData {
    self.emailTF.text = self.currentUser.email;
    self.firstNameTF.text = self.currentUser.first_name;
    self.lastNameTF.text = self.currentUser.last_name;
    self.phoneNumTF.text = self.currentUser.completeMobileNumber;
    self.dobTF.text = self.currentUser.date_of_birth;
    self.genderSegmentControl.selectedSegmentIndex = self.currentUser.genderType;
}
-(void)checkAndHideAccsoryView {
    [self.emailCrossBtn.superview setHidden:YES];
    [self.firstNameCrossBtn.superview setHidden:YES];
    [self.lastNameCrossBtn.superview setHidden:YES];
    [self.phoneNumCrossBtn.superview setHidden:YES];
    if (self.emailTF.shouldDisplayAccessoryView) {
        [self.emailCrossBtn.superview setHidden:NO];
    }
    if (self.firstNameTF.shouldDisplayAccessoryView) {
        [self.firstNameCrossBtn.superview setHidden:NO];
    }
    if (self.lastNameTF.shouldDisplayAccessoryView) {
        [self.lastNameCrossBtn.superview setHidden:NO];
    }
    if (self.phoneNumTF.shouldDisplayAccessoryView) {
        [self.phoneNumCrossBtn.superview setHidden:NO];
    }
}
-(void)designUI {
    //Disabled Email & Phone Number
    [self.emailTF setUserInteractionEnabled:NO];
    [self.phoneNumTF setUserInteractionEnabled:NO];
    
    
    [self.emailInfoLabel setHidden:YES];
    [self.firstNameInfoLabel setHidden:YES];
    [self.lastNameInfoLabel setHidden:YES];
    [self.phoneNumInfoLabel setHidden:YES];
    [self.dobInfoLabel setHidden:YES];
    
    
    [self checkAndHideAccsoryView];
    
    self.emailTF.enabled = NO;
    self.emailTF.font = [UIFont DDRegularFont:17];
    self.emailInfoLabel.font = [UIFont DDRegularFont:13];
    self.firstNameTF.font = [UIFont DDRegularFont:17];
    self.firstNameInfoLabel.font = [UIFont DDRegularFont:13];
    self.lastNameTF.font = [UIFont DDRegularFont:17];
    self.lastNameInfoLabel.font = [UIFont DDRegularFont:13];
    self.phoneNumTF.font = [UIFont DDRegularFont:17];
    self.phoneNumInfoLabel.font = [UIFont DDRegularFont:13];
    self.dobTF.font = [UIFont DDRegularFont:17];
    self.dobInfoLabel.font = [UIFont DDRegularFont:13];
    self.emailTF.textColor = AUTH_THEME.text_black_40.colorValue;
    self.emailInfoLabel.textColor = AUTH_THEME.text_black_40.colorValue;
    self.firstNameTF.textColor = AUTH_THEME.text_black_40.colorValue;
    self.firstNameInfoLabel.textColor = AUTH_THEME.text_black_40.colorValue;
    self.lastNameTF.textColor = AUTH_THEME.text_black_40.colorValue;
    self.lastNameInfoLabel.textColor = AUTH_THEME.text_black_40.colorValue;
    self.phoneNumTF.textColor = AUTH_THEME.text_black_40.colorValue;
    self.phoneNumInfoLabel.textColor = AUTH_THEME.text_black_40.colorValue;
    self.dobTF.textColor = AUTH_THEME.text_black_40.colorValue;
    self.dobInfoLabel.textColor = AUTH_THEME.text_black_40.colorValue;
    self.emailLineView.backgroundColor = AUTH_THEME.text_grey_238.colorValue;
    self.emailLineView.tintColor = AUTH_THEME.text_grey_238.colorValue;
    self.firstNameLineView.backgroundColor = AUTH_THEME.text_grey_238.colorValue;
    self.firstNameLineView.tintColor = AUTH_THEME.text_grey_238.colorValue;
    self.lastNameLineView.backgroundColor = AUTH_THEME.text_grey_238.colorValue;
    self.lastNameLineView.tintColor = AUTH_THEME.text_grey_238.colorValue;
    self.phoneNumLineView.backgroundColor = AUTH_THEME.text_grey_238.colorValue;
    self.phoneNumLineView.tintColor = AUTH_THEME.text_grey_238.colorValue;
    self.dobLineView.backgroundColor = AUTH_THEME.text_grey_238.colorValue;
    self.dobLineView.tintColor = AUTH_THEME.text_grey_238.colorValue;
    self.emailInfoLabel.text = @"";
    self.firstNameInfoLabel.text = @"";
    self.lastNameInfoLabel.text = @"";
    self.phoneNumInfoLabel.text = @"";
    self.dobInfoLabel.text = @"";
    [self.genderSegmentControl setTitle:@"Male".localized forSegmentAtIndex:0];
    [self.genderSegmentControl setTitle:@"Female".localized forSegmentAtIndex:1];
    [self.saveBtn setTitle:@"Save".localized forState:(UIControlStateNormal)];
    self.emailTF.placeholder = @"Email".localized;
    self.emailTF.placeHolderColor = AUTH_THEME.text_grey_199.colorValue;
    self.firstNameTF.placeholder = @"First name".localized;
    self.firstNameTF.placeHolderColor = AUTH_THEME.text_grey_199.colorValue;
    self.lastNameTF.placeholder = @"Last name".localized;
    self.lastNameTF.placeHolderColor = AUTH_THEME.text_grey_199.colorValue;
    self.phoneNumTF.placeholder = @"Phone number".localized;
    self.phoneNumTF.placeHolderColor = AUTH_THEME.text_grey_199.colorValue;
    self.dobTF.placeholder = @"Date of birth (optional)".localized;
    self.dobTF.placeHolderColor = AUTH_THEME.text_grey_199.colorValue;
    
    [self.emailCrossBtn loadImageWithString:@"cross.png" forClass:self.class];
    [self.firstNameCrossBtn loadImageWithString:@"cross.png" forClass:self.class];
    [self.lastNameCrossBtn loadImageWithString:@"cross.png" forClass:self.class];
    [self.phoneNumCrossBtn loadImageWithString:@"cross.png" forClass:self.class];
    [self.dobCrossBtn loadImageWithString:@"calendar.png" forClass:self.class];
    
    [self.emailTF addTarget:self action:@selector(didChangeText) forControlEvents:UIControlEventEditingChanged];
    [self.firstNameTF addTarget:self action:@selector(didChangeText) forControlEvents:UIControlEventEditingChanged];
    [self.lastNameTF addTarget:self action:@selector(didChangeText) forControlEvents:UIControlEventEditingChanged];
    [self.phoneNumTF addTarget:self action:@selector(didChangeText) forControlEvents:UIControlEventEditingChanged];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.dobTF setInputView:datePicker];
    
}
-(void)updateTextField:(id)sender
{
  UIDatePicker *picker = (UIDatePicker*)self.dobTF.inputView;
  self.dobTF.text = [NSString stringWithFormat:@"%@",[picker.date stringWithFormat:@"yyyy-dd-MM"]];
}
-(void)didChangeText {
    [self checkAndHideAccsoryView];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTapEmailCrossBtn:(id)sender {
    
}
- (IBAction)didChangeGender:(id)sender {
    [self.currentUser setGenderType:self.genderSegmentControl.selectedSegmentIndex];
}
- (IBAction)didTapSaveBtn:(id)sender {
    self.currentUser.first_name = self.firstNameTF.text;
    self.currentUser.last_name = self.lastNameTF.text;
    self.currentUser.date_of_birth = self.dobTF.text;
    DDBaseRequestModel *req = [DDBaseRequestModel new];
    [req addCustomParams:self.currentUser.toDictionary];
    
    [DDAuthManager.shared updateProfileInfo:req andCompletion:^(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (model.http_code.integerValue == 200 && model.data.user != nil) {
            model.data.user.session_token = DDUserManager.shared.currentUser.session_token;
            DDUserManager.shared.currentUser = model.data.user;
            [DDAlertUtils showOkAlertWithTitle:@"Profile Update" subtitle:@"Profile info is updated successfully" completion:^{
                [self goBackWithCompletion:nil];
            }];
        }else {
            NSString *errorMessage = model.message;
            if (errorMessage.length == 0) {
                errorMessage = error.localizedDescription;
            }
            if (errorMessage.length == 0) {
                [DDAlertUtils showOkAlertWithTitle:@"" subtitle:errorMessage completion:nil];
            }
        }
    }];
    
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Accounts_My_Account andModuleName:@"DDAuthUI" withClassRef:self.class];
}
@end
