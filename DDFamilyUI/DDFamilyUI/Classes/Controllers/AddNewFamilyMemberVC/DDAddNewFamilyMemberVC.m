//
//  DDAddNewFamilyMemberVC.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 22/01/2020.
//

#import "DDAddNewFamilyMemberVC.h"


@interface DDAddNewFamilyMemberVC ()

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *emailTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *nickRelationTF;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;

@end

@implementation DDAddNewFamilyMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)designUI {
    
    self.title = ADD_MEMBER.localized;
    
    self.descLabel.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.descLabel.font = [UIFont DDBoldFont:17];
    self.descLabel.text = ADD_FAMILY_MEMBER_SCREEN_DESC.localized;
    
    self.emailTF.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.emailTF.placeholder = EMAIL_ADDRESS.localized;
    self.emailTF.placeHolderColor = DDFamilyThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.emailTF.font = [UIFont DDRegularFont:17];
    self.emailTF.keyboardType = UIKeyboardTypeEmailAddress;
    
    self.nickRelationTF.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.nickRelationTF.placeholder = NICK_RELATION.localized;
    self.nickRelationTF.placeHolderColor = DDFamilyThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.nickRelationTF.font = [UIFont DDRegularFont:17];
    self.nickRelationTF.keyboardType = UIKeyboardTypeDefault;
    
    [self setupFamilyThemedBtn:self.bottomButton withTitle:ADD_MEMBER];
}


- (IBAction)addMemberButtonAction:(UIButton *)sender {
    NSString *email = self.emailTF.text.trimmedString;
    if (!email.isValidEmail) {
        [DDAlertUtils showOkAlertWithTitle:@"" subtitle:EMAIL_INPUT_ERROR completion:nil];
        return;
    }
    NSString *nick = self.nickRelationTF.text.trimmedString;
    if (nick.length == 0) {
        [DDAlertUtils showOkAlertWithTitle:@"" subtitle:ALL_INPUT_ERROR completion:nil];
        return;
    }
    
    [self.view endEditing:YES];
    
    DDFamilyRequestM *request = [DDFamilyRequestM new];
    request.nick_name = nick;
    request.email = email;
    
    __weak typeof(self) weakSelf = self;
    [DDFamilyManager.shared addFamilyMemberWithRequestModel:request completion:^(DDFamilyApiModel * _Nullable model, NSURLResponse * _Nullable response , NSError * _Nullable error) {
        if (model) {
            if (model.success.boolValue) {
                [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:^{
                    [weakSelf goBackWithCompletion:nil];
                }];
            }
            else {
                [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:nil];
            }
        }
        else {
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
        }
    }];
    
}

@end
