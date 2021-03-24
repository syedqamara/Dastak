//
//  DDFriendDetailsVC.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 26/03/2020.
//

#import "DDFriendDetailsVC.h"
#import "DDAccountManager.h"

@interface DDFriendDetailsVC ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UILabel *memberDetailsHeaderLbl;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *memberSinceTF;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;

@property (weak, nonatomic) IBOutlet UIView *savingsView;
@property (weak, nonatomic) IBOutlet UIView *smilesView;
@property (weak, nonatomic) IBOutlet UILabel *savingsLbl;
@property (weak, nonatomic) IBOutlet UILabel *currencyLbl;
@property (weak, nonatomic) IBOutlet UILabel *smilesLbl;
@property (weak, nonatomic) IBOutlet UILabel *savingsTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *smilesTitleLbl;

@property (strong, nonatomic) DDFriend *friend;

@end

@implementation DDFriendDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BOOL dataFound = [self.navigation.routerModel.data isKindOfClass:[DDFriend class]];
    if (dataFound) {
        self.friend = (DDFriend*)self.navigation.routerModel.data;
    }
    else {
        [DDAlertUtils showOkAlertWithTitle:@"" subtitle:MEMBER_DETAILS_NOT_FOUND completion:^{
            [self goBackWithCompletion:nil];
        }];
        return;
    }
    
    [self setupInitals];
    [self setApiData];
    [self standardNavigationBar];
}

-(void)setupInitals {
    self.profileImgView.image = nil;
    self.emailLbl.text = nil;
    self.nameLbl.text = nil;
    self.removeBtn.hidden = ![DDFamilyManager.shared canRemoveFriend:self.friend];
}


-(void)setApiData {
    self.title = DETAILS.localized;
    
    self.nameLbl.text = self.friend.name;
    self.emailLbl.text = @"";
    self.memberSinceTF.text = @"";
    
    self.memberSinceTF.userInteractionEnabled = NO;
    
    UIImage *placeHolder = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:DUMMY_PLACEHOLDER];
    [self.profileImgView loadImageWithString:self.friend.profile_image withPlaceHolderImage:placeHolder forClass:self.class];
    [self setupTiles];
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
    self.memberSinceTF.font = [UIFont DDRegularFont:13];
    self.memberSinceTF.keyboardType = UIKeyboardTypeDefault;
    
    [self setupFamilyThemedBtn:self.removeBtn withTitle:REMOVE_FROM_LEADERBOARD];
    
    
}


-(void)setupTiles {
    
    self.emailLbl.text = self.friend.email;
    
    self.savingsView.cornerR = 10;
    self.smilesView.cornerR = 10;
    
    self.savingsView.backgroundColor = FAMILY_THEME.bg_tile_blue.colorValue;
    self.smilesView.backgroundColor = FAMILY_THEME.bg_tile_orange.colorValue;
    
    self.savingsTitleLbl.text = @"Savings".localized;
    self.savingsTitleLbl.textColor = FAMILY_THEME.text_white.colorValue;
    self.savingsTitleLbl.font = [UIFont DDBoldFont:15];
    
    self.savingsLbl.text = self.friend.savings.stringValue;
    self.savingsLbl.textColor = FAMILY_THEME.text_white.colorValue;
    self.savingsLbl.font = [UIFont DDBoldFont:28];
    
    self.currencyLbl.text = self.friend.currency;
    self.currencyLbl.textColor = FAMILY_THEME.text_white.colorValue;
    self.currencyLbl.font = [UIFont DDBoldFont:15];
    
    self.smilesTitleLbl.text = @"Smiles".localized;
    self.smilesTitleLbl.textColor = FAMILY_THEME.text_white.colorValue;
    self.smilesTitleLbl.font = [UIFont DDBoldFont:15];
    
    BOOL getSmiles = NO;
    if (self.friend.family_member && self.friend.family_member.boolValue){
        if ([DDAccountManager shared].smiles != nil){
            self.smilesLbl.text = [NSString stringWithFormat:@"%@",[DDAccountManager shared].smiles.current_smiles ?: @0.0];
            getSmiles = YES;
        }
    }
    if (!getSmiles){
        if (self.friend.smiles){
            self.smilesLbl.text = self.friend.smiles.stringValue;
        }else{
            self.smilesLbl.text = @"0";
        }
    }
    self.smilesLbl.textColor = FAMILY_THEME.text_white.colorValue;
    self.smilesLbl.font = [UIFont DDBoldFont:28];
    
    if (self.friend.member_since && self.friend.member_since.length){
         self.memberSinceTF.text = self.friend.member_since;
    }else{
        self.memberSinceTF.text = @"";
    }
}

- (IBAction)bottomBtnAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    [DDAlertUtils showAlertWithTitle:DELETE_A_FRIEND_TITLE subtitle:DELETE_A_FRIEND_SUBTITLE buttonNames:@[CANCEL, CONTINUE] onClick:^(int index) {
        if (index == 1) {
            DDFamilyRequestM *req = [DDFamilyRequestM new];
            req.friend_id = weakSelf.friend.user_id;
            [DDFamilyManager.shared removeFriendFromLeaderBoard:req completion:^(DDFriendsAPI * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (model) {
                    if (model.successfulApi) {
                        [DDAlertUtils showOkAlertWithTitle:nil subtitle:model.data.unfriend_status completion:^{
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
    }];
}


@end
