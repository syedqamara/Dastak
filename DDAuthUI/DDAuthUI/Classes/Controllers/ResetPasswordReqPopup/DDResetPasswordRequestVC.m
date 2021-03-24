//
//  DDResetPasswordRequestVC.m
//  DDAuthUI
//
//  Created by Zubair Ahmad on 21/05/2020.
//

#import "DDResetPasswordRequestVC.h"
#import "DDAuthConstants.h"
#import <DDConstants/DDConstants.h>
#import "DDAuthUIThemeManager.h"
#import "DDAuthUIManager.h"
#import "DDAuthUIConstants.h"

@interface DDResetPasswordRequestVC ()
{
    DDAuthResetPasswordSectionM *data;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;
@property (weak, nonatomic) IBOutlet UITextField *emailTField;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIButton *crossBtn;
@property (weak, nonatomic) IBOutlet UIImageView *lockImage;
@property (weak, nonatomic) IBOutlet UIView *mainContainerV;

@end

@implementation DDResetPasswordRequestVC

- (void)viewDidLoad {
    [super viewDidLoad];
     data = (DDAuthResetPasswordSectionM *)self.navigation.routerModel.data;
    [self setUIData];
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    return self;
}
-(UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverCurrentContext;
}

-(void)setUIData {
//    self.titleLbl.text = data.title;
//    self.messageLbl.text = data.message;
//    [self.lockImage sd_setImageWithURL:[NSURL URLWithString:data.image]];
    self.emailTField.text = @"";
}

-(void)designUI{
    self.titleLbl.font = [UIFont DDMediumFont:17];
    self.titleLbl.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.messageLbl.font = [UIFont DDRegularFont:15];
    self.messageLbl.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.lockImage.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"reset-password.png"];
    
    self.emailTField.cornerR = 8;
    self.emailTField.clipsToBounds = YES;
    self.emailTField.font = [UIFont DDMediumFont:15];
    self.emailTField.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.emailTField.placeholder = @"Email".localized;
    self.emailTField.borderColor = DDAuthUIThemeManager.shared.selected_theme.border_grey_199.colorValue;
    self.emailTField.borderW = 1;
    
    self.doneBtn.titleLabel.font = [UIFont DDMediumFont:15];
    [self.doneBtn setTitle:@"Reset Now".localized forState:UIControlStateNormal];
    self.doneBtn.backgroundColor = DDAuthUIThemeManager.shared.selected_theme.app_theme.colorValue;
    [self.doneBtn setTitleColor:DDAuthUIThemeManager.shared.selected_theme.text_white.colorValue forState:(UIControlStateNormal)];
    self.doneBtn.cornerR = 8;
    self.doneBtn.clipsToBounds = YES;
    
    self.crossBtn.titleLabel.font = [UIFont DDMediumFont:15];
    [self.crossBtn setTitle:@"Cancel".localized forState:UIControlStateNormal];
    [self.crossBtn setTitleColor:DDAuthUIThemeManager.shared.selected_theme.app_theme.colorValue forState:(UIControlStateNormal)];
    
    self.mainContainerV.cornerR = 12;
    self.mainContainerV.clipsToBounds = YES;
}

- (IBAction)doneBtnAction:(id)sender {
    if (self.emailTField.text.length == 0 || !self.emailTField.text.isValidEmail) {
        [DDAlertUtils showAlertWithTitle:@"" subtitle:INVALID_EMAIL_MESSAGE.localized buttonNames:@[OK.localized] onClick:nil];
    }else {
        __weak typeof(self) weakSelf = self;
        DDBaseRequestModel *reqM = [DDBaseRequestModel new];
        reqM.custom_parameters = @{ @"email" : self.emailTField.text, @"reset_password":@"true"}.mutableCopy;
        
    }
}

- (IBAction)crossBtnAction:(id)sender {
    [self goBackWithCompletion:^{
        [self.navigation.routerModel sendDataCallback:@"cancel" withData:nil withController:self];
    }];
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Auth_Reset_password_Popup andModuleName:@"DDAuthUI" withClassRef:self.class];
}

@end
