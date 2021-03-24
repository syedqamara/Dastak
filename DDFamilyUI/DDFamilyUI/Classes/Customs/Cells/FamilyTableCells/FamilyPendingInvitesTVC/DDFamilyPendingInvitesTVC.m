//
//  DDFamilyPendingInvitesTVC.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 03/02/2020.
//

#import "DDFamilyPendingInvitesTVC.h"

@interface DDFamilyPendingInvitesTVC ()

@property (weak, nonatomic) IBOutlet UIView *mainContainer;
@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;

@property (weak, nonatomic) IBOutlet UIView *leftBtnContainer;
@property (weak, nonatomic) IBOutlet UIView *rightBtnContainer;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (nonatomic, strong) DDPendingInviteInfoM *invite; //strong : required updated obj in VC

@property (weak, nonatomic) IBOutlet UIView *cheersInstructionsView;

@property (weak, nonatomic) IBOutlet DDCheckbox *confirmCheckBox;
@property (weak, nonatomic) IBOutlet UILabel *confirmCheersLbl;

@property (weak, nonatomic) IBOutlet DDCheckbox *dontConfirmCheckBox;
@property (weak, nonatomic) IBOutlet UILabel *dontConfirmCheersLbl;


@end

@implementation DDFamilyPendingInvitesTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(id)data {
    self.invite = (DDPendingInviteInfoM*)data;
    if (self.invite == nil) return;
    
    self.nameLbl.text = self.invite.name;
    self.emailLbl.text = self.invite.email;
    UIImage *placeHolder = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:DUMMY_PLACEHOLDER];
    [self.profileImgView loadImageWithString:self.invite.profile_img withPlaceHolderImage:placeHolder forClass:self.class];
    [self setupCheers];
    [super setData:data];
}

-(void)setupCheers {
    self.cheersInstructionsView.hidden = !self.invite.isAlcohalAllowed;
    self.confirmCheersLbl.text = self.invite.restriction_message;
    self.dontConfirmCheersLbl.text = self.invite.restriction_message_no_cheers_message;
    [self normalCheers];
    
    __weak typeof(self) weakSelf = self;
    self.confirmCheckBox.stateChanged = ^(BOOL checked, DDCheckbox * _Nonnull checkbox) {
        [weakSelf normalCheers];
        weakSelf.dontConfirmCheckBox.checked = NO;
    };
    self.dontConfirmCheckBox.stateChanged = ^(BOOL checked, DDCheckbox * _Nonnull checkbox) {
        [weakSelf normalCheers];
        weakSelf.confirmCheckBox.checked = NO;
    };
}


-(void)normalCheers {
    UIColor *blackColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.confirmCheersLbl.textColor = blackColor;
    self.confirmCheckBox.borderW = 0;
    self.dontConfirmCheersLbl.textColor = blackColor;
    self.dontConfirmCheckBox.borderW = 0;
}

-(void)warnCheers {
    UIColor *redColor = DDFamilyThemeManager.shared.selected_theme.text_red_39.colorValue;
    self.confirmCheersLbl.textColor = redColor;
    self.confirmCheckBox.borderColor = redColor;
    self.confirmCheckBox.borderW = 1;
    self.dontConfirmCheersLbl.textColor = redColor;
    self.dontConfirmCheckBox.borderColor = redColor;
    self.dontConfirmCheckBox.borderW = 1;
}


- (void)designUI {
    
    self.mainContainer.cornerR = 4;
    self.mainContainer.borderW = 1;
    self.mainContainer.borderColor = DDFamilyThemeManager.shared.selected_theme.border_grey_199.colorValue;
    self.mainContainer.clipsToBounds = YES;
    
    self.profileImgView.circle = YES;
    self.profileImgView.clipsToBounds = YES;
    
    self.nameLbl.font = [UIFont DDBoldFont:17];
    self.nameLbl.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.emailLbl.font = [UIFont DDLightFont:15];
    self.nameLbl.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.leftBtnContainer.borderW = 1;
    self.leftBtnContainer.borderColor = DDFamilyThemeManager.shared.selected_theme.border_grey_227.colorValue;
    self.leftBtnContainer.backgroundColor = DDFamilyThemeManager.shared.selected_theme.bg_grey_244.colorValue;
    
    self.confirmCheersLbl.font = [UIFont DDLightFont:15];
    self.dontConfirmCheersLbl.font = [UIFont DDLightFont:15];
    
    self.leftBtn.borderW = 1;
    self.leftBtn.cornerR = 8;
    self.leftBtn.borderColor = DDFamilyThemeManager.shared.selected_theme.border_grey_227.colorValue;
    self.leftBtn.clipsToBounds = YES;
    self.leftBtn.backgroundColor = DDFamilyThemeManager.shared.selected_theme.bg_white.colorValue;
    self.leftBtn.titleLabel.font = [UIFont DDMediumFont:15];
    [self.leftBtn setTitleColor:DDFamilyThemeManager.shared.selected_theme.text_theme.colorValue forState:UIControlStateNormal];
    
    self.rightBtnContainer.borderW = 1;
    self.rightBtnContainer.borderColor = DDFamilyThemeManager.shared.selected_theme.border_grey_227.colorValue;
    self.rightBtnContainer.backgroundColor = DDFamilyThemeManager.shared.selected_theme.bg_grey_244.colorValue;
    
    self.rightBtn.cornerR = 8;
    self.rightBtn.clipsToBounds = YES;
    self.rightBtn.backgroundColor = DDFamilyThemeManager.shared.selected_theme.app_theme.colorValue;
    self.rightBtn.titleLabel.font = [UIFont DDMediumFont:15];
    [self.rightBtn setTitleColor:DDFamilyThemeManager.shared.selected_theme.text_white.colorValue forState:UIControlStateNormal];

}


#pragma mark - Actions

-(IBAction)rejectAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    [DDAlertUtils showAlertWithTitle:nil subtitle:DECLINE_INVITE_MSG buttonNames:@[CANCEL, CONTINUE] onClick:^(int index) {
        if (index == 1 && [weakSelf.delegate respondsToSelector:@selector(rejectAction:)]) {
            [weakSelf.delegate rejectAction:weakSelf.invite];
        }
    }];
}

-(IBAction)acceptAction:(id)sender {
    BOOL cheersValidated = [self cheersValidation];
    if (cheersValidated) {
        if ([self.delegate respondsToSelector:@selector(acceptAction:)]) {
            [self.delegate acceptAction:self.invite];
        }
    }
}

-(BOOL)cheersValidation {
    if (!self.invite.isAlcohalAllowed || self.confirmCheckBox.checked || self.dontConfirmCheckBox.checked) {
        self.invite.is_confirm_checkbox_selected = @(self.confirmCheckBox.checked);
        self.invite.is_donnot_wantcheers_checkbox_selected = @(self.dontConfirmCheckBox.checked);
        return YES;
    }
    [self warnCheers];
    [DDAlertUtils showOkAlertWithTitle:@"" subtitle:CHEERS_DECIDE_MSG completion:nil];
    return NO;
}

@end
