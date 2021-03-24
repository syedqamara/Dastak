//
//  DDAccountViewController.m
//  DDAccountsUI
//
//  Created by M.Jabbar on 11/03/2020.
//

#import "DDAccountViewController.h"
#import "DDUIThemeTableViewCell.h"
#import <DDAccounts/DDAccounts.h>
#import <DDCommons/DDCommons.h>
#import "DDAccountUIThemeManager.h"
#import "DDAuthUI.h"
#import <DDUI/DDUI.h>
#import <DDModels/DDModels.h>

@import Photos;

@interface DDAccountViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *editLabel;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *emailTextField;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *dateOfBirthTextField;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *nationalityTextField;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *countryTextField;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *mobileTextField;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *currencyTextField;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *memberOfTextField;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (strong, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *memberShipViewHight;
@property (strong, nonatomic) IBOutlet UIView *memberShipView;



@property(nonatomic) DDUserM *user;

@property(nonatomic) NSArray<DDCountryM*>* countries;
@property(nonatomic) BOOL isEditing;
@property (nonatomic) DDCountryM *selectedNationality;
@property (nonatomic) DDCountryM *countryOfResidence;

@property (nonatomic) DDCurrencyPickerView *currencyPicker;
@property (nonatomic) DDNationalityPicker * _Nonnull nationalityPicker;
@property (nonatomic) DDNationalityPicker * _Nonnull countryOfResidencePicker;
@property (nonatomic) DDDatePicker *datePicker;

@end

@implementation DDAccountViewController
@synthesize user;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"My Account";
    self.user =  [DDUserManager shared].currentUser;

    self.countries = [DDUserManager countries];
    
    [self setnationality];
    [self setCurrency];
    [self setCountryOfResidence];
    [self setDateOfBirthPicker];
    [self updateUI];
    [self disableEditing];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
-(void)designUI{
    
    self.editLabel.superview.backgroundColor = [DDAccountUIThemeManager shared].selected_theme.text_black_40.colorValue;
    self.editLabel.textColor = [DDAccountUIThemeManager shared].selected_theme.text_white.colorValue;
    self.nameLabel.textColor = [DDAccountUIThemeManager shared].selected_theme.text_black_40.colorValue;
    self.emailLabel.textColor = [DDAccountUIThemeManager shared].selected_theme.text_black_40.colorValue;

    self.editLabel.font = [UIFont DDMediumFont:11];
    self.nameLabel.font = [UIFont DDBoldFont:20];
    self.emailLabel.font = [UIFont DDLightFont:15];

    self.firstNameTextField.font = [UIFont DDLightFont:15];
    self.lastNameTextField.font = [UIFont DDLightFont:15];
    self.emailTextField.font = [UIFont DDLightFont:15];
    self.dateOfBirthTextField.font = [UIFont DDLightFont:15];
    self.nationalityTextField.font = [UIFont DDLightFont:15];
    self.countryTextField.font = [UIFont DDLightFont:15];
    self.currencyTextField.font = [UIFont DDLightFont:15];
    self.mobileTextField.font = [UIFont DDLightFont:15];
    
    self.firstNameTextField.textColor = [DDAccountUIThemeManager shared].selected_theme.text_black.colorValue;
    self.lastNameTextField.textColor = [DDAccountUIThemeManager shared].selected_theme.text_black.colorValue;
    self.emailTextField.textColor = [DDAccountUIThemeManager shared].selected_theme.text_black.colorValue;
    self.dateOfBirthTextField.textColor = [DDAccountUIThemeManager shared].selected_theme.text_black.colorValue;
    self.nationalityTextField.textColor = [DDAccountUIThemeManager shared].selected_theme.text_black.colorValue;
    
    self.editButton.titleLabel.font = [UIFont DDBoldFont:17];
    
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.view.backgroundColor =  [DDAccountUIThemeManager shared].selected_theme.bg_grey_240.colorValue;
}
-(void)updateUI{
    
    __weak __typeof(self) weakSElf = self;

    self.selectedNationality = [DDUserManager country:user.nationality ?: @""  countries:self.countries];
    if (self.selectedNationality) {
        self.nationalityTextField.text =  self.selectedNationality.name;
    }
    self.countryOfResidence = [DDUserManager country:user.country_of_residence ?: @""  countries:self.countries];
    if (self.countryOfResidence) {
        self.countryTextField.text = self.countryOfResidence.name;
    }
    self.nameLabel.text = user.name;
    self.emailLabel.text = user.email;
    self.firstNameTextField.text = user.first_name;
    self.lastNameTextField.text = user.last_name;
    self.emailTextField.text = user.email;
    if (user.date_of_birth != nil && ![user.date_of_birth isEqualToString:@"None"]){
        if ([user.date_of_birth containsString:@"-"]){
            self.dateOfBirthTextField.text = [user.date_of_birth getDayMonthYearDateStringWithSlashes];
        }else{
            self.dateOfBirthTextField.text = user.date_of_birth;
        }
    }
    self.mobileTextField.text = user.mobile_phone;
    self.currencyTextField.text = self.currencyPicker.selectedCurrency.currencyId;
    if (user.membership_expiration_date != nil && ![user.membership_expiration_date isEqualToString:@"None"]){
         self.memberOfTextField.text = [[user.membership_expiration_date componentsSeparatedByString:@" "] firstObject];
    }else{
        self.memberOfTextField.text = @"";
        self.memberShipViewHight.constant = 0;
        self.memberShipView.hidden = YES;
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSElf.stackView insertArrangedSubview:weakSElf.editView atIndex:weakSElf.user.isDemographicsUpdated ? 6 : 1];
    });
    
    
    [self.profileImageView loadImageWithString:user.profile_image withPlaceHolderImage:nil forClass:self.class completion:^(UIImage * _Nullable image) {
        
        weakSElf.profileImageView.image = image;
        weakSElf.profileImageView.superview.placeHolder = NO;
        
    }];
    
}
-(void)disableEditing{
    
    self.nameLabel.userInteractionEnabled = NO;
    self.emailLabel.userInteractionEnabled = NO;
    self.firstNameTextField.userInteractionEnabled = NO;
    self.lastNameTextField.userInteractionEnabled = NO;
    self.emailTextField.userInteractionEnabled = NO;
    self.dateOfBirthTextField.userInteractionEnabled = NO;
    self.nationalityTextField.userInteractionEnabled = NO;
    self.countryTextField.userInteractionEnabled = NO;
    self.mobileTextField.userInteractionEnabled = NO;
    self.currencyTextField.userInteractionEnabled = NO;
    self.memberOfTextField.userInteractionEnabled = NO;
    self.isEditing = NO;
}
-(void)enableEditing{
    if([DDUserManager shared].currentUser.isDemographicsUpdated){
        self.countryTextField.userInteractionEnabled = YES;
        self.mobileTextField.userInteractionEnabled = YES;
        self.currencyTextField.userInteractionEnabled = YES;
        [self.currencyPicker selectCurrency:user.currency];

    }else{
        self.dateOfBirthTextField.userInteractionEnabled = YES;
        self.nationalityTextField.userInteractionEnabled = YES;
        self.countryTextField.userInteractionEnabled = YES;
        self.mobileTextField.userInteractionEnabled = YES;
        self.currencyTextField.userInteractionEnabled = YES;
    }
    
}
-(void)setCurrency{
    self.currencyPicker = [DDCurrencyPickerView loadPicker];
    self.currencyPicker.currencies = DDUserManager.currencie;
    [self.currencyPicker selectCurrency:user.currency];
    self.currencyTextField.delegate = self;
   
    __weak __typeof(self) weakSElf = self;

    self.currencyPicker.onSelection = ^(DDCurrencyM * _Nonnull selectedCurrency) {
        weakSElf.user.currency = selectedCurrency.currencyId;
        weakSElf.currencyTextField.text = selectedCurrency.currencyId;
    };
    self.currencyPicker.onHide = ^{
        
    };
    self.currencyTextField.inputView = self.currencyPicker;
}
-(void)setnationality{
    
    __weak __typeof(self) weakSelf = self;

    self.nationalityPicker = [DDNationalityPicker loadPicker];
    
    self.nationalityPicker.countries = self.countries;
    self.nationalityPicker.selectedNationality = [DDUserManager country:user.nationality ?: @"BH"  countries:self.countries];

    self.nationalityPicker.onSelection = ^(DDCountryM * _Nonnull selectedNationality) {
        weakSelf.nationalityTextField.text = selectedNationality.name;
        weakSelf.user.nationality = selectedNationality.shortname;

    };
    self.nationalityTextField.inputView = self.nationalityPicker;
    self.nationalityTextField.delegate = self;
}
-(void)setCountryOfResidence{
    
    __weak __typeof(self) weakSelf = self;

    self.countryOfResidencePicker = [DDNationalityPicker loadPicker];
    
    self.countryOfResidencePicker.countries = self.countries;
    self.countryOfResidencePicker.selectedNationality = [DDUserManager country:user.country_of_residence ?: @"BH"  countries:self.countries];

    self.countryOfResidencePicker.onSelection = ^(DDCountryM * _Nonnull selectedNationality) {
        weakSelf.countryTextField.text = selectedNationality.name;
        weakSelf.user.country_of_residence = selectedNationality.shortname;
    };
    self.countryTextField.inputView = self.countryOfResidencePicker;
    self.countryTextField.delegate = self;
}

-(void)setDateOfBirthPicker{
    __weak __typeof(self) weakSelf = self;

    self.datePicker = [[DDDatePicker alloc] init];
    self.datePicker.selectedDateBlock = ^(NSString * _Nonnull selectedDate) {
           weakSelf.user.date_of_birth = selectedDate;
           weakSelf.dateOfBirthTextField.text = selectedDate;
       };
    self.datePicker.dateFormat = @"dd/MM/yyyy";
    NSDate *selectedDateTemp = [DDExtraUtil getMaxBirthdayDate];
    self.datePicker.maximumDate = selectedDateTemp;
    if (user.date_of_birth != nil && ![user.date_of_birth isEqualToString:@"None"]){
        NSString *dob = @"";
        if ([user.date_of_birth containsString:@"-"]){
            dob = [user.date_of_birth getDayMonthYearDateStringWithSlashes];
        }else{
            dob = user.date_of_birth;
        }
        [self.datePicker setupDateOfBirth:dob dateFormate:@"dd/MM/yyyy"];
    }else{
        NSString *dateString = [[NSDate new] stringWithFormat:@"dd/MM/yyyy"];
        self.dateOfBirthTextField.text = @"";
        [self.datePicker setupDateOfBirth:dateString dateFormate:@"dd/MM/yyyy"];
    }
    
    self.dateOfBirthTextField.inputView = self.datePicker;
    self.dateOfBirthTextField.delegate = self;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [textField reloadInputViews];
    if (textField == _nationalityTextField) {
        [self.nationalityPicker selectCountry:self.nationalityPicker.selectedNationality.country_id ?: @(18)];
    }else if(textField == _countryTextField){
        [self.countryOfResidencePicker selectCountry:self.countryOfResidencePicker.selectedNationality.country_id ?: @(18)];
    }
    return YES;
}

- (IBAction)editButtonTapped:(id)sender {
    if (self.isEditing) {
        [self updateProfileInfo];
    }else{
        self.isEditing = YES;
        [self enableEditing];
        [self.editButton setTitle:@"Done" forState:UIControlStateNormal];
    }
}

-(void)updateUserImage : (UIImage*)image {
    DDUserProfileRequestM *req = [DDUserProfileRequestM new];
    DDUserM *user = [[DDUserM alloc] init];
    user.user_id = self.user.user_id;
    user.country = self.user.country;
    req.user = user;
    req.profile_image = image;
    [DDAuthManager.shared updateUserImage:req andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable resp, NSError * _Nullable err) {
        if (err != nil){
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:err.localizedDescription completion:nil];
        }else {
            DDEditProfileAPIM *apiM = (DDEditProfileAPIM *)model;
            if (apiM.data && apiM.data.profile_image.length) {
                DDUserManager.shared.currentUser.profile_image = apiM.data.profile_image;
                self.user.profile_image = apiM.data.profile_image;
                [self updateUI];
                [UIApplication refreshAppWithParams:nil];
            }else {
                self.user = DDUserManager.shared.currentUser;
                self.isEditing = NO;
                [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
                [DDAlertUtils showOkAlertWithTitle:nil subtitle:model.message completion:nil];
            }
        }
        
    }];
}

-(void) updateProfileInfo {
    DDUserProfileRequestM *req = [DDUserProfileRequestM new];
    self.user.mobile_phone = self.mobileTextField.text;
    self.user.date_of_birth  = self.dateOfBirthTextField.text;
    req.user = self.user;
    [DDAuthManager.shared updateProfileInfo:req andCompletion:^(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil){
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
        }else{
            if (model.data != nil && model.data.user != nil) {
                self.user = model.data.user;
                self.isEditing = NO;
                [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
            } else {
                [DDAlertUtils showOkAlertWithTitle:nil subtitle:model.message completion:nil];
            }
        }
    }];
}

#pragma mark - UIImagePickerController

- (IBAction)editImageTapped:(id)sender {
    [self openSelectProfilePicture];
}

-(void)openSelectProfilePicture {
    NSArray *buttonTexts = @[@"Take Photo", @"Choose Photo"];
    __weak typeof(self) weakSelf = self;
    [DDAlertUtils showCancelActionSheetWithTitle:nil message:nil buttonTexts:buttonTexts completion:^(int index) {
        [weakSelf didClickedButtonAtIndex:index];
    }];
}

-(PHAuthorizationStatus)shouldOpenPhotoLibrary {
    return [PHPhotoLibrary authorizationStatus];
}

-(AVAuthorizationStatus)shouldOpenCamera {
    return [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];;
}

-(void)openSettingPermissionFor:(NSString *)permissionType {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"Turn on %@ Permission from Settings to allow \"DDERTAINER\" to access your %@",permissionType, permissionType] preferredStyle:(UIAlertControllerStyleAlert)];
    [controller addAction:[UIAlertAction actionWithTitle:@"Settings" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"Cancel" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)openPhotoLibraryWithStatus:(PHAuthorizationStatus)status {
    if (status == PHAuthorizationStatusAuthorized) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                   [self openPhotoLibraryWithStatus:status];
                });
            }
        }];
    }
    else {
        [self openSettingPermissionFor:@"Photos"];
    }
}

-(void)openCameraWithStatus:(AVAuthorizationStatus)status {
    if (status == AVAuthorizationStatusAuthorized) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing=TRUE;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else if (status == AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self openCameraWithStatus:AVAuthorizationStatusAuthorized];
                });
            }
        }];
    }else {
        [self openSettingPermissionFor:@"Camera"];
    }
}

-(void) didClickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self openPhotoLibraryWithStatus:[self shouldOpenPhotoLibrary]];
    } else if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self openCameraWithStatus:[self shouldOpenCamera]];
        }
    }
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!img) img = [info objectForKey:UIImagePickerControllerOriginalImage];
    img=[self imageWithImage:img scaledToSize:CGSizeMake(800, 800)];
    [self.profileImageView setImage:img];

    if (self.profileImageView.image) {
        [self updateUserImage:self.profileImageView.image];
    }
}




+(NSArray<DDUIRouterM *> *)deeplinkRoutes {
    DDUIRouterM *route = [DDUIRouterM new];
    route.route_link = DD_Nav_Accounts_My_Account;
    route.should_embed_in_nav = YES;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.auth_permission = DDUIRouterAuthPermissionTypeAsk;
    return @[route];
}

@end
