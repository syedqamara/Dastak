//
//  DDFamilyMemberDetailsVC.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 22/01/2020.
//

#import "DDFamilyMemberDetailsVC.h"
#import "DDAccountManager.h"

@interface DDFamilyMemberDetailsVC ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UILabel *memberDetailsHeaderLbl;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *memberSinceTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *nickRelationTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *emailTF;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;
@property (weak, nonatomic) IBOutlet UIButton *resendBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *savingsSmilesContainerViewH;
@property (weak, nonatomic) IBOutlet UIView *savingsView;
@property (weak, nonatomic) IBOutlet UIView *smilesView;
@property (weak, nonatomic) IBOutlet UILabel *savingsLbl;
@property (weak, nonatomic) IBOutlet UILabel *currencyLbl;
@property (weak, nonatomic) IBOutlet UILabel *smilesLbl;
@property (weak, nonatomic) IBOutlet UILabel *savingsTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *smilesTitleLbl;

@property (strong, nonatomic) DDFamilyMemberM *familyMember;
@property (strong, nonatomic) DDFamilyMemberDetailInfoM *familyMemberDetails;

@end

@implementation DDFamilyMemberDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.familyMember = (DDFamilyMemberM*)self.navigation.routerModel.data;
    if (self.familyMember == nil) {
        [DDAlertUtils showOkAlertWithTitle:@"" subtitle:MEMBER_DETAILS_NOT_FOUND completion:^{
            [self goBackWithCompletion:nil];
        }];
        return;
    }
    [self setupInitals];
    [self fetchMemberDetails];
}

-(void)setupInitals {
    self.profileImgView.image = nil;
    self.emailLbl.text = nil;
    self.nameLbl.text = nil;
    self.resendBtn.hidden = YES;
    self.removeBtn.hidden = YES;
    self.emailTF.superview.hidden = YES;
    [self setupTiles];
}

-(void)fetchMemberDetails {
    __weak typeof(self) weakSelf = self;
    DDFamilyRequestM *request = [DDFamilyRequestM new];
    request.identifier = self.familyMember.identifier;
    [DDFamilyManager.shared fetchMemberDetailsWithRequestModel:request completion:^(DDFamilyApiModel * _Nullable model, NSURLResponse * _Nullable response , NSError * _Nullable error) {
        if (model) {
            if (model.success.boolValue) {
                weakSelf.familyMemberDetails = model.data.member_detail;
                [weakSelf setApiData];
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

-(void)setApiData {
    
    self.title = [DDFamilyManager.shared familyMemberDetailScreenTitleFromMemberDetailInfo:self.familyMemberDetails];
    NSString *imgString = self.familyMemberDetails.profile_img.length ? self.familyMemberDetails.profile_img : self.familyMember.profile_img;
    UIImage *placeHolder = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:DUMMY_PLACEHOLDER];
    [self.profileImgView loadImageWithString:imgString withPlaceHolderImage:placeHolder forClass:self.class];
    
    self.nameLbl.text = self.familyMemberDetails.name.length ? self.familyMemberDetails.name : self.familyMember.name;
    self.emailLbl.text = self.familyMemberDetails.email;
    self.emailTF.text = self.familyMemberDetails.email;
    self.memberSinceTF.text = self.familyMemberDetails.member_since_date;
    self.nickRelationTF.text = self.familyMemberDetails.nick_name;
    
    [self.removeBtn setTitle:self.familyMemberDetails.button_title forState:UIControlStateNormal];
    [self.resendBtn setTitle:self.familyMemberDetails.button_resend_title forState:UIControlStateNormal];
    [self.resendBtn setBackgroundColor:FAMILY_THEME.app_theme.colorValue];
    
    if (self.familyMemberDetails.isPending) {
        [self.removeBtn setBackgroundColor:UIColor.clearColor];
        [self.removeBtn setTitleColor:FAMILY_THEME.text_theme.colorValue forState:(UIControlStateNormal)];
    }
    else {
        [self.removeBtn setBackgroundColor:FAMILY_THEME.app_theme.colorValue];
        [self.removeBtn setTitleColor:FAMILY_THEME.text_white.colorValue forState:(UIControlStateNormal)];
    }
    
    [self setupTiles];
    [self configureScreenAccordingToStatus];
}

-(void) configureScreenAccordingToStatus {
    if (self.familyMemberDetails.isFamilyMember) {
        [self configureMember];
    }
    else {
        [self configureNonMember];
    }
    
    if (self.familyMemberDetails.isPending || self.familyMemberDetails.isRejected) {
        [self configurePendingMember];
    } else {
        self.resendBtn.hidden = YES;
    }
}

-(void) configurePendingMember {
    self.removeBtn.hidden = NO;
    self.resendBtn.hidden = NO;
    self.emailTF.superview.hidden = NO;
    self.emailLbl.hidden = YES;
    self.nickRelationTF.userInteractionEnabled = YES;
}

-(void) configureMember {
    [self.memberSinceTF.superview setHidden:NO];
    [self.nickRelationTF setUserInteractionEnabled:YES];
    self.removeBtn.hidden = NO;
}

-(void) configureNonMember {
    [self.memberSinceTF.superview setHidden:YES];
    [self.nickRelationTF setUserInteractionEnabled:NO];
}

-(void)setupTiles {
    
    self.savingsView.cornerR = 10;
    self.smilesView.cornerR = 10;
    
    if (self.familyMemberDetails.savings_title.length == 0) self.familyMemberDetails.savings_title = @"Savings";
    if (self.familyMemberDetails.smiles_title.length == 0) self.familyMemberDetails.smiles_title = @"Smiles";
    if (self.familyMemberDetails.savings_currency.length == 0) self.familyMemberDetails.savings_currency = @"USD";
    if (self.familyMemberDetails.smiles == nil) self.familyMemberDetails.smiles = @(0);
    if (self.familyMemberDetails.savings == nil) self.familyMemberDetails.savings = @(0);

    self.savingsView.backgroundColor = FAMILY_THEME.bg_tile_blue.colorValue;
    self.smilesView.backgroundColor = FAMILY_THEME.bg_tile_orange.colorValue;
    
    self.savingsTitleLbl.text = self.familyMemberDetails.savings_title;
    self.savingsTitleLbl.textColor = FAMILY_THEME.text_white.colorValue;
    self.savingsTitleLbl.font = [UIFont DDBoldFont:15];
    
    self.savingsLbl.text = self.familyMemberDetails.savings.stringValue;
    self.savingsLbl.textColor = FAMILY_THEME.text_white.colorValue;
    self.savingsLbl.font = [UIFont DDBoldFont:28];
    
    self.currencyLbl.text = self.familyMemberDetails.savings_currency;
    self.currencyLbl.textColor = FAMILY_THEME.text_white.colorValue;
    self.currencyLbl.font = [UIFont DDBoldFont:15];
    
    self.smilesTitleLbl.text = self.familyMemberDetails.smiles_title;
    self.smilesTitleLbl.textColor = FAMILY_THEME.text_white.colorValue;
    self.smilesTitleLbl.font = [UIFont DDBoldFont:15];
    if ([DDAccountManager shared].smiles != nil){
        self.smilesLbl.text = [NSString stringWithFormat:@"%@",[DDAccountManager shared].smiles.current_smiles ?: @0.0];
    }else {
        self.smilesLbl.text = self.familyMemberDetails.smiles.stringValue;
    }
    self.smilesLbl.textColor = FAMILY_THEME.text_white.colorValue;
    self.smilesLbl.font = [UIFont DDBoldFont:28];
    
    if (self.familyMemberDetails.isFamilyMember){
        self.savingsSmilesContainerViewH.constant = 117;
        self.savingsView.hidden = NO;
        self.smilesView.hidden = NO;
    }else{
        self.savingsSmilesContainerViewH.constant = 0;
        self.savingsView.hidden = YES;
        self.smilesView.hidden = YES;
    }
    [self.view layoutSubviews];
    [self.view layoutIfNeeded];
}

- (void)designUI {
    
    self.nameLbl.font = [UIFont DDBoldFont:20];
    self.nameLbl.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.emailLbl.font = [UIFont DDRegularFont:15];
    self.emailLbl.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.memberDetailsHeaderLbl.font = [UIFont DDBoldFont:20];
    self.memberDetailsHeaderLbl.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.memberSinceTF.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.memberSinceTF.placeholder = MEMBER_SINCE.localized;
    self.memberSinceTF.placeHolderColor = DDFamilyThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.memberSinceTF.font = [UIFont DDRegularFont:17];
    self.memberSinceTF.keyboardType = UIKeyboardTypeDefault;
    self.memberSinceTF.userInteractionEnabled = NO;
    
    self.nickRelationTF.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.nickRelationTF.placeholder = NICK_RELATION.localized;
    self.nickRelationTF.placeHolderColor = DDFamilyThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.nickRelationTF.font = [UIFont DDRegularFont:17];
    self.nickRelationTF.keyboardType = UIKeyboardTypeDefault;
    
    self.emailTF.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.emailTF.placeholder = EMAIL_ADDRESS.localized;
    self.emailTF.placeHolderColor = DDFamilyThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.emailTF.font = [UIFont DDRegularFont:17];
    self.emailTF.keyboardType = UIKeyboardTypeEmailAddress;
    
    [self setupFamilyThemedBtn:self.removeBtn withTitle:REMOVE_FROM_FAMILY];
    [self setupFamilyThemedBtn:self.resendBtn withTitle:RESEND_INVITATIOM];
}

- (IBAction)removeFamilyMemberAction:(UIButton *)sender {
    NSString *msg = self.familyMemberDetails.cancel_message;
    if ([DDFamilyManager.shared canRemoveFamilyMember:self.familyMember] && msg.length) {
        __weak typeof(self) weakSelf = self;
        [DDAlertUtils showAlertWithTitle:nil subtitle:msg buttonNames:@[CANCEL, CONTINUE] onClick:^(int index) {
            if (index == 1) {
                DDFamilyRequestM *request = [DDFamilyRequestM new];
                request.identifier = self.familyMember.identifier;
                [DDFamilyManager.shared removeFamilyMemberWithRequestModel:request completion:^(DDFamilyApiModel * _Nullable model,  NSURLResponse * _Nullable response ,NSError * _Nullable error) {
                    if (model) {
                        //refresh family
                        [weakSelf goBackWithCompletion:nil];
                    }
                    else {
                        [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
                    }
                }];
            }
        }];
    }
    else {
        [self cancelInvitationAction:sender];
    }
}

- (IBAction)cancelInvitationAction:(UIButton *)sender {
    NSString *msg = self.familyMemberDetails.cancel_message;
    if (msg.length) {
        __weak typeof(self) weakSelf = self;
        [DDAlertUtils showAlertWithTitle:nil subtitle:msg buttonNames:@[CANCEL, CONTINUE] onClick:^(int index) {
            if (index == 1) {
                DDFamilyRequestM *request = [DDFamilyRequestM new];
                request.identifier = weakSelf.familyMember.identifier;
                [DDFamilyManager.shared cancelInvitationWithRequestModel:request completion:^(DDFamilyApiModel * _Nullable model, NSURLResponse * _Nullable response , NSError * _Nullable error) {
                    if (model) {
                        //refresh family
                        [weakSelf goBackWithCompletion:nil];
                    }
                    else {
                        [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
                    }
                }];
            }
        }];
    }
}

- (IBAction)resendInvitationAction:(UIButton *)sender {
    
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
    
    DDFamilyRequestM *request = [DDFamilyRequestM new];
    request.nick_name = nick;
    request.email = email;
    request.identifier = self.familyMember.identifier;
    
    [self.view endEditing:YES];
    
    [DDFamilyManager.shared resendInvitationWithRequestModel:request completion:^(DDFamilyApiModel * _Nullable model, NSURLResponse * _Nullable response , NSError * _Nullable error) {
        if (model) {
            if (model.success.boolValue) {
                [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:nil];
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
