//
//  DDRegistrationDemographicsVC.m
//  DDExpress
//
//  Created by Hafiz Aziz on 01/07/2019.
//

#import "DDRegistrationDemographicsVC.h"
#import "DDCountryM.h"
#import "DDAuthUIManager.h"
#import "DDAuthUIThemeManager.h"
#import "DDAuth.h"
@interface DDRegistrationDemographicsVC ()<UITextFieldDelegate> {
    UIDatePicker *dbDatePicker;
}
@property (weak, nonatomic) IBOutlet UIView *crossButtonContainerView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lbl_heading;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lbl_subHeading;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *txt_country;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *txt_gender;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *txt_dob;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *img_arrow;

@property (unsafe_unretained, nonatomic) IBOutlet UITextField *countryPlaceholder;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *genderPlaceholder;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *dobPlaceholder;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *genderViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dobViewHeightConstraint;
@property (retain, nonatomic) NSArray *nationalityDataArray;
@property (strong, nonatomic) DDCountryM *selectedCountry;
@property (weak, nonatomic) IBOutlet UIImageView *crossImageView;

    
@end

@implementation DDRegistrationDemographicsVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [DDUserManager shared].isDemographicScreenShownOnce = YES;
}

#pragma MARK :- Uitility Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"textfield : %@", textField.text);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == self.txt_dob){
        [self setUIDataPicker];
        return NO;
        
    }
    return YES;
}
-(void)designUI {
    self.lbl_heading.text = @"Tell us about you".localized;
    self.lbl_subHeading.text = @"This will help us provide you better offerfs.\nDon’t worry, this is just a one time setup".localized;
    self.btnRegister.backgroundColor = [DDAuthUIThemeManager shared].selected_theme.app_theme.colorValue;
    [self.btnRegister setTitle:@"Done".localized forState:UIControlStateNormal];
    
    [self setTransparentNavigationBar];
    self.lbl_heading.font = [UIFont DDBoldFont:28.0];
    self.lbl_subHeading.font = [UIFont DDRegularFont:15];
    self.txt_country.font = [UIFont DDRegularFont:17.0];
    self.txt_gender.font = [UIFont DDRegularFont:17.0];
    self.txt_dob.font = [UIFont DDRegularFont:17.0];
    self.countryPlaceholder.font = [UIFont DDRegularFont:13];
    self.genderPlaceholder.font = [UIFont DDRegularFont:13];
    self.dobPlaceholder.font = [UIFont DDRegularFont:13];
    self.txt_dob.delegate = self;
    
    self.countryPlaceholder.hidden = YES;
    self.genderPlaceholder.hidden = YES;
    self.dobPlaceholder.hidden = YES;
    self.countryPlaceholder.textColor = AUTH_THEME.text_grey_199.colorValue;
    self.genderPlaceholder.textColor = AUTH_THEME.text_grey_199.colorValue;
    self.dobPlaceholder.textColor = AUTH_THEME.text_grey_199.colorValue;
    
    self.lbl_heading.textColor = AUTH_THEME.text_black_40.colorValue;
    self.lbl_subHeading.textColor = AUTH_THEME.text_black_40.colorValue;
    self.txt_country.textColor = AUTH_THEME.text_black_40.colorValue;
    self.txt_gender.textColor = AUTH_THEME.text_black_40.colorValue;
    self.txt_dob.textColor = AUTH_THEME.text_black_40.colorValue;
    [self.btnRegister.layer setCornerRadius:7];
    [self.btnRegister setClipsToBounds:YES];
    self.crossImageView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"filter_cross.png"];
    for (UIImageView *imageView in self.img_arrow) {
        imageView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icArrowDown.png"];
    }
    [self viewWillLayoutSubviews];
}

-(void)setUIDataPicker {
    __weak typeof(self) weakSelf = self;
    [DDAuthUIManager setupDatePicker:self.view selectedDate:NSDate.date minDate:nil maxDate:NSDate.date onSelectionDone:^(NSDate * _Nonnull date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        weakSelf.txt_dob.text = [dateFormatter stringFromDate:date];
        weakSelf.dobPlaceholder.hidden = NO;
    }];
}
- (IBAction)btnGenderAction:(id)sender {
    NSArray *dataArray = [[NSArray alloc] initWithObjects:@"Male",@"Female", nil];
    __weak typeof(self) weakSelf = self;
    
    [DDAuthUIManager showPickerWithDataSource:dataArray onController:self WithcallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        NSString *gender = (NSString*)data;
        weakSelf.genderPlaceholder.hidden = NO;
        weakSelf.txt_gender.text = [NSString stringWithFormat:@"%@",gender];
    }];
    
//    [DDAuthUIManager setupListPicker:self.view dataArray:dataArray sheetTitle:@"" onSelectionDone:^(NSInteger selectedIndex) {
//        weakSelf.genderPlaceholder.hidden = NO;
//        weakSelf.txt_gender.text = [NSString stringWithFormat:@"%@",dataArray[selectedIndex]];
//    }];
}
- (IBAction)btnCountryOfResidenceAction:(id)sender {
    NSArray *dataArray = [self getNationalityStringArray];
    if (dataArray.count > 0){
        __weak typeof(self) weakSelf = self;
        [DDAuthUIManager showPickerWithDataSource:dataArray onController:self WithcallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
            DDCountryM *country = (DDCountryM*)data;
            weakSelf.selectedCountry = country;
            weakSelf.txt_country.text = weakSelf.selectedCountry.name;
            weakSelf.countryPlaceholder.hidden = NO;
        }];
//        [DDNationalityPicker showPicker:@"" selectedNationality:weakSelf.selectedCountry countries:DDCountryM.countries selectionBlock:^(DDCountryM * _Nonnull selectedNationality) {
//            weakSelf.selectedCountry = selectedNationality;
//            weakSelf.txt_country.text = weakSelf.selectedCountry.name;
//            weakSelf.countryPlaceholder.hidden = NO;
//        } hideBlock:^{}];
    }
}
-(NSArray *)getNationalityStringArray{
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    dataArray = DDCountryM.countries.mutableCopy;
    return dataArray;
}

- (IBAction)btnRegisterAction:(id)sender {
   [self.view endEditing:YES];
    // validation
    if (self.txt_dob.text.length == 0 || self.txt_gender.text.length == 0 || self.txt_country.text.length == 0) {
        [DDAlertUtils showOkAlertWithTitle:nil subtitle:@"Fill all the fields".localized completion:^{}];
    }else {
//        DDUserM *user = [[DDUserM alloc] init];
//        if (DDUserManager.shared.currentUser) {
//            user = DDUserManager.shared.currentUser;
//            user.gender = self.txt_gender.text;
//            user.nationality = self.selectedCountry.shortname;
//            user.date_of_birth = self.txt_dob.text;
//        }else {
//            user.gender = self.txt_gender.text;
//            user.nationality = self.selectedCountry.shortname;
//            user.date_of_birth = self.txt_dob.text;
//        }
//
//        __weak typeof(self) weakSelf = self;
//        DDUserProfileRequestM *req = [DDUserProfileRequestM new];
//        req.user = user;
//        [DDAuthManager.shared updateProfileInfo:req andCompletion:^(DDAuthLoginM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            if (model.successfulApi && model.data.user) {
//                [weakSelf didTapCrossButton:nil];
//            }
//        }];
    }
    
}

- (IBAction)didTapCrossButton:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigation.routerModel sendDataCallback:nil withData:nil withController:self];
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Auth_Demographics andModuleName:@"DDAuthUI" withClassRef:self.class];
}
@end
