//
//  DDSharePingsVC.m
//  DDPingsUI
//
//  Created by Hafiz Aziz on 23/01/2020.
//

#import "DDSharePingsVC.h"
#import "DDSharePingsTVC.h"
#import "DDPingsUIManager.h"
#import <DDModels/DDModels.h>
#import "DDPingsShareTableHFV.h"
#import <DDAuth/DDUserManager.h>

@interface DDSharePingsVC () <UITableViewDelegate, UITableViewDataSource, DDDraggableNavigationControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate>{
    
    DDMerchantDetailM *merchant;
    DDOutletM *selectedOutlet;
    DDMerchantOfferM *offerSection;
    DDMerchantDetailSectionM *section;
    
    NSMutableArray <DDMerchantOfferM*> *offerSectionsWithAvailabeOffers;
    NSInteger allowedPingsCount;
    DDPingRequestM *pingModel;
    BOOL isEditing;
}
@property (weak, nonatomic) IBOutlet UIView *shareEmailMainContainerView;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIButton *btnSendInvitation;
@property (weak, nonatomic) IBOutlet DDUIShadowView *emailContainerView;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITableView *tblPings;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderMessage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tfBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@end

@implementation DDSharePingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [PING_SHARE_LISTING localized];
    _txtEmail.delegate = self;
    DDMerchantOffersLocalDataM *model  = self.navigation.routerModel.data;
    offerSection = model.offerSection;
    section = model.section;
    merchant = model.merchant;
    selectedOutlet = model.selectedOutlet;
    allowedPingsCount = [merchant numberofOffersRemainingtoPing];
    
    __block BOOL hasOffers;
    [[DDPingsManager shared] offerSectionsWithAvailabeOffers:section.offers.mutableCopy andCompletion:^(id  _Nonnull filterdOffers, BOOL hasPingableOffers) {
        self->offerSectionsWithAvailabeOffers = (NSMutableArray <DDMerchantOfferM*> *) filterdOffers;
        hasOffers = hasPingableOffers;
    }];
    
    if (allowedPingsCount < 1 || offerSectionsWithAvailabeOffers.count < 1 || !hasOffers){
        [self showEmptyView];
        _shareEmailMainContainerView.hidden = YES;
    }else
        self.emptyView.hidden = TRUE;
   
    [self setUpTableView];
    if ([self.navigationController isKindOfClass:[DDDraggableNavigationController class]]) {
        [(DDDraggableNavigationController*)self.navigationController setPanModelDelegate:self];
        [self.navigationController setDelegate:self];
    }
    if (IS_IPHONE_WITH_NOTCH_DEVICES){
        self.tfBottomConstraint.constant = UIScreen.mainScreen.bounds.size.height - self.navigation.routerModel.panModelHeight+20;
    }else{
        self.tfBottomConstraint.constant = UIScreen.mainScreen.bounds.size.height - self.navigation.routerModel.panModelHeight;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardStateChange:) name:UIKeyboardDidChangeFrameNotification object:nil];

    [self setWhiteDragableNavigationBar];
    
    [self addNavigationItemWithTitle:CANCEL identifier:CANCEL tintColor:DDPingsThemeManager.shared.selected_theme.text_theme.colorValue direction:DDNavigationItemDirectionLeft];
}

-(void)isdragableViewPresentedInFullScreen:(BOOL)fullScreen {
    DDUIBaseViewController *vc = (DDUIBaseViewController*)self.navigationController.visibleViewController;
    UIColor *itemsColor = fullScreen ? DDPingsThemeManager.shared.selected_theme.text_white.colorValue : DDPingsThemeManager.shared.selected_theme.text_theme.colorValue;
    for (DDNavigationItem *item in vc.navigationItems) {
        item.tintColor = itemsColor;
    }
    if (fullScreen){
        [self setThemeNavigationBar];
    } else {
        [self setWhiteDragableNavigationBar];
    }
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    DDUIBaseViewController *vc = (DDUIBaseViewController*)viewController;
    UIColor *itemsColor = vc.isPanInFullScreen ? DDPingsThemeManager.shared.selected_theme.text_white.colorValue : DDPingsThemeManager.shared.selected_theme.text_theme.colorValue;
    for (DDNavigationItem *item in vc.navigationItems) {
        item.tintColor = itemsColor;
    }
}



-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)keyboardStateChange:(NSNotification *)notification {
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    if (!isEditing){
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (IS_IPHONE_WITH_NOTCH_DEVICES){
            self.tfBottomConstraint.constant = keyboardRect.size.height-30;
        }else{
            self.tfBottomConstraint.constant = keyboardRect.size.height;
        }
        [self.view layoutIfNeeded];
    });
}

-(void)showEmptyView{
    self.emptyView.hidden = FALSE;
    DDEmptyViewModel *model = [DDPingsUIManager.shared checkAndGetEmptyViewModelForInvitePings:nil];
    [DDEmptyView showAndReturnInConatiner:self.emptyView withEmptyViewModel:model completion:^{
        // button action for buy smiles 
    }];
}
- (void)dragableViewTopOffset:(CGFloat)topOffset {
    if (isEditing){
        return;
    }
    self.tfBottomConstraint.constant = topOffset;
    [self.view layoutIfNeeded];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tblPings reloadData];
    
    self.lblHeaderMessage.text = [merchant getTopViewMessageToSendPings];
}

- (void) setUpTableView {
    self.tblPings.dataSource = self;
    self.tblPings.delegate = self;
    NSArray *headerViews = @[DDPingsShareTableHFView];
    NSArray *tableCells = @[DDSharePingsTableCell];
    [self.tblPings registerHeaderFooterWithNibNames:headerViews forClass:self.class withIdentifiers:headerViews];
    [self.tblPings registerCellWithNibNames:tableCells forClass:self.class withIdentifiers:tableCells];
    
    self.tblPings.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    self.tblPings.sectionHeaderHeight = 50;
    self.tblPings.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tblPings.rowHeight = 150.0;
}

-(void) designUI {
    
    pingModel = [[DDPingRequestM alloc] init];
    self.view.backgroundColor = DDPingsThemeManager.shared.selected_theme.bg_white.colorValue;
    self.headerView.backgroundColor = DDPingsThemeManager.shared.selected_theme.app_header_messageBG.colorValue;
    self.lblHeaderMessage.font = [UIFont DDMediumFont:15.0];
    self.lblHeaderMessage.textColor = DDPingsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.emailContainerView.layer.cornerRadius = 12.0f;
    self.emailContainerView.layer.borderColor = [DDPingsThemeManager.shared.selected_theme.border_grey_227.colorValue CGColor];
    self.emailContainerView.layer.borderWidth = 1.0f;
    self.emailContainerView.clipsToBounds = YES;
    self.txtEmail.font = [UIFont DDRegularFont:15];
    self.txtEmail.textColor = DDPingsThemeManager.shared.selected_theme.text_black_40.colorValue;
         
     [self.btnShare setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icShareWithInactive"] forState:UIControlStateNormal];
    [self.btnShare setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icShareWithActive"] forState:UIControlStateSelected];
     [self.btnSendInvitation setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icSendInactive"] forState:UIControlStateNormal];
    [self.btnSendInvitation setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icSendActive"] forState:UIControlStateSelected];
}

- (void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    if ([sender.identifier isEqualToString:CANCEL]) {
        [self goBackWithCompletion:nil];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    isEditing = YES;
    [self panTransiotionToFullScreen];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    isEditing = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tfBottomConstraint.constant = 0;
        [self.view layoutIfNeeded];
    });
}

-(IBAction)btnShareAction:(id)sender{
    [self.txtEmail endEditing:YES];
    [self.view endEditing:YES];
    pingModel.offer_id = [merchant getSelectedOffersIdsArray];
    pingModel.customer_id = DDUserManager.shared.currentUser.user_id;
    if (pingModel.offer_id.count > 0){
        [[DDPingsUIManager shared] goToAnotherViewController:self withPingsModel:pingModel routeLink:DD_Nav_Pings_Leaderboard andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
            [self.navigation.routerModel sendDataCallback:identifier withData:data withController:controller];
            if ([identifier isEqualToString:PING_SDD_CALLBACK_MESSAGE]){
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }else{
        [DDAlertUtils showOkAlertWithTitle:nil subtitle:pingModel.validationErrorMessageForSendPing completion:nil];
    }
}
-(IBAction)btnSendPingRequestAction:(id)sender{
    [self.txtEmail endEditing:YES];
    [self.view endEditing:YES];
    pingModel.offer_id = [merchant getSelectedOffersIdsArray];
    pingModel.customer_id = DDUserManager.shared.currentUser.user_id;
    pingModel.email = self.txtEmail.text;
    NSString *errorMessage = [self validateInfo];
    if (errorMessage.length == 0 && errorMessage == nil) {
        __weak typeof(self) weakSelf = self;
        [DDPingsManager.shared sendPingRequest:pingModel andCompletion:^(DDPingApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * error) {
            if (error == nil) {
                if (model.data.status && model.data.status.boolValue){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [DDAlertUtils showOkAlertWithTitle:nil subtitle:model.data.message completion:^{
                            [weakSelf goBackWithCompletion:nil];
                        }];
                    });
                    [self.navigation.routerModel sendDataCallback:PING_SDD_CALLBACK_MESSAGE withData:model withController:self];
                }else {
                    NSString *string = @"";
                    if (model.data.message && model.data.message.length){
                        string = model.data.message;
                    }else{
                        string = @"Something went wrong";
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [DDAlertUtils showOkAlertWithTitle:nil subtitle:string completion:nil];
                    });
                }
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
                });
            }
        }];
    }else{
        [DDAlertUtils showOkAlertWithTitle:[NSString stringWithFormat:@"Email".localized,allowedPingsCount] subtitle:errorMessage completion:nil];
    }
}
-(NSString *)validateInfo {
    if (!DDUserManager.shared.currentUser){
        return @"sender id missing";
    }
    if ([pingModel.email isEqualToString:DDUserManager.shared.currentUser.email]) {
        return @"You cannot ping any offers to yourself.".localized;
    }
    return pingModel.validationErrorMessageForSendPing;
}

#pragma mark - UI-TABLE-VIEW

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return offerSectionsWithAvailabeOffers.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DDMerchantOfferM *offers = offerSectionsWithAvailabeOffers[section];
    return offers.offers_to_display.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    DDMerchantOfferM *offers = offerSectionsWithAvailabeOffers[section];
    DDPingsShareTableHFV *view = [self.tblPings dequeueReusableHeaderFooterViewWithIdentifier:DDPingsShareTableHFView];
    [view setData:offers.section_name];
    return view;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DDMerchantOfferM *offerSection = offerSectionsWithAvailabeOffers[indexPath.section];
    DDMerchantOfferToDisplay *offersToDisplay = offerSection.offers_to_display[indexPath.row];
    DDSharePingsTVC *cell = [self.tblPings dequeueReusableCellWithIdentifier:DDSharePingsTableCell];
    DDMerchantOffersLocalDataM *model = [[DDMerchantOffersLocalDataM alloc] init];
    model.merchant = merchant;
    model.selectedOutlet = selectedOutlet;
    model.offerSection = offerSection;
    model.offerToDisplay = offersToDisplay;
    [cell setData:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDMerchantOfferM *offerSection = offerSectionsWithAvailabeOffers[indexPath.section];
    DDMerchantOfferToDisplay *offersToDisplay = offerSection.offers_to_display[indexPath.row];
    int leftCount = [merchant numberofOffersRemainingtoPing];
    if(leftCount > 0 || offersToDisplay.isSelectedForPing){
        if([offersToDisplay isPingable]){
            [offersToDisplay setSelectedForPing:offersToDisplay.isSelectedForPing ? NO : YES];
            [self.tblPings reloadData];
            
        }
    }else{
        [DDAlertUtils showOkAlertWithTitle:@"Sorry" subtitle:@"Sorry, You cannot select more offers to ping." completion:nil];
    }
    if ([merchant selectedOffersForPing].count > 0){
        self.btnSendInvitation.selected = TRUE;
        self.btnShare.selected = TRUE;
    }else{
        self.btnSendInvitation.selected = FALSE;
        self.btnShare.selected = FALSE;
    }
}

@end
