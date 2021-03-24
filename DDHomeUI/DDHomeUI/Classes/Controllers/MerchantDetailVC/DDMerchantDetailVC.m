//
//  DDMerchantDetailVC.m
//  DDHomeUI
//
//  Created by Syed Qamar Abbas on 21/07/2020.
//
//FeedHeader
#import "DDMerchantDetailVC.h"
#import "DDMunchMerchantDetailHeaderView.h"
#import <DDHome.h>
#import "DDMerchantVM.h"
#import "DDMerchantDeliveryInfoTHFV.h"
#import "DDMerchantAttributeTHFV.h"
#import "DDMunchMerchantMenuView.h"
#import "DDItemsTVC.h"
#import "DDMerchantDeliveryMenuItemM.h"
#import "DDHomeUIManager.h"
#import "DDBasketManager.h"
#import "DDLocations.h"
#import "DDAuth.h"
@interface DDMerchantDetailVC ()<UITableViewDelegate, UITableViewDataSource, DDMunchMerchantMenuViewDelegate, DDItemsTVCDelegate, DDMunchMerchantDetailHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewBasketContainerView;
@property (weak, nonatomic) IBOutlet DDGradientButton *viewBasketButton;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DDMunchMerchantDetailHeaderView *headerView;
@property (strong, nonatomic) DDMerchantApiM *apiModel;
@property (strong, nonatomic) NSMutableArray <DDMerchantVM *> *sections;
@end

@implementation DDMerchantDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [DDBasketManager.shared setMerchant:nil];
    [self updateViewBasketCount];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self addNavigationItemWithImage:@"ic-back.png" identifier:BACK_BTN_IDDDIFIER_CUSTOM tintColor:nil direction:(DDNavigationItemDirectionLeft)];
    
    [self checkAndChooseNavigationBar];
    [self loadMerchantDetail];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateViewBasketCount];
}
-(BOOL)hidesBottomBarWhenPushed {
    return YES;
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.headerView setNeedsLayout];
    [self.headerView layoutIfNeeded];
    
    CGFloat height = [self.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    CGRect frame = self.headerView.frame;
    frame.size.height = 257;
    self.headerView.frame = frame;
    
    self.tableView.tableHeaderView = self.headerView;
}
-(void)designUI {
    [self.tableView registerCells:@[@"DDItemsTVC"] forClass:self.class];
    [self.tableView registerTHFV:@[@"DDMunchMerchantMenuView", @"DDMerchantAttributeTHFV", @"DDMerchantDeliveryInfoTHFV"] forClass:self.class];
    self.headerView = [DDMunchMerchantDetailHeaderView nibInstanceOfClass:DDMunchMerchantDetailHeaderView.class];
    self.tableView.tableHeaderView = self.headerView;
    
    self.headerView.delegate = self;
    self.headerView.navHeight = 80;
    self.tableView.estimatedSectionHeaderHeight = 46;
    self.tableView.estimatedRowHeight = 112;
    
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.priceLabel.font = [UIFont DDMediumFont:15];
    self.priceLabel.textColor = HOME_THEME.text_white.colorValue;
    self.countLabel.font = [UIFont DDMediumFont:13];
    self.countLabel.textColor = HOME_THEME.app_theme.colorValue;
    self.viewBasketButton.titleLabel.font = [UIFont DDSemiBoldFont:17];
    [self.viewBasketButton setTitleColor:HOME_THEME.text_white.colorValue forState:(UIControlStateNormal)];
    [self.viewBasketButton setTitle:@"View Basket".localized forState:UIControlStateNormal];
    
}
-(void)updateViewBasketCount {
    if (DDBasketManager.shared.basketIsAllowedToEdit && DDBasketManager.shared.count > 0) {
        self.countLabel.text = [NSString stringWithFormat:@"%ld",DDBasketManager.shared.count];
        self.priceLabel.text = [NSString stringWithFormat:@"%@ %.2f",self.apiModel.data.merchant.currency, DDBasketManager.shared.totalPrice];
        [self.viewBasketContainerView setHidden:NO];
    }else {
        [self.viewBasketContainerView setHidden:YES];
    }
    [self.tableView reloadData];
}
-(void)loadMerchantDetail {
    DDMerchantRM *req = self.navigation.routerModel.data;
    req.selected_delivery_lat = DDLocationsManager.shared.selectedCashlessDeliveryLocation.latitude;
    req.selected_delivery_lng = DDLocationsManager.shared.selectedCashlessDeliveryLocation.longitude;
    [DDHomeManager.shared fetchMerchantDetailWithReq:req showHUD:YES onCompletion:^(DDMerchantApiM * _Nullable model, NSError * _Nullable error) {
        [DDBasketManager.shared setMerchant:model.data.merchant];
        self.apiModel = model;
        self.headerView.merchant = self.apiModel.data.merchant;
        [self createSections];
    }];
}
-(void)createSections {
    self.sections = [NSMutableArray new];
    DDMerchantVM *tempSection;
    DDMerchantM *merchant = self.apiModel.data.merchant;
    
    tempSection = [DDMerchantVM vmWithType:(DDMerchantDetailSectionTypeRating) andMerchant:merchant];
    [self.sections addObject:tempSection];
    
    tempSection = [DDMerchantVM vmWithType:(DDMerchantDetailSectionTypeInfo) andMerchant:merchant];
    [self.sections addObject:tempSection];
    
    tempSection = [DDMerchantVM vmWithType:(DDMerchantDetailSectionTypeMenu) andMerchant:merchant];
    tempSection.selectedMenu = merchant.delivery_menu.firstObject;
    [self.sections addObject:tempSection];
    
    [self reloadData];
    [self scrollViewDidScroll:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.sections[section].type == DDMerchantDetailSectionTypeMenu) {
        return self.sections[section].selectedMenu.items.count;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.sections[section].type == DDMerchantDetailSectionTypeRating) {
        DDMerchantAttributeTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DDMerchantAttributeTHFV"];
        [view setData:self.sections[section]];
        return view;
    }
    if (self.sections[section].type == DDMerchantDetailSectionTypeInfo) {
        DDMerchantDeliveryInfoTHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DDMerchantDeliveryInfoTHFV"];
        [view setData:self.sections[section]];
        return view;
    }
    if (self.sections[section].type == DDMerchantDetailSectionTypeMenu) {
        DDMunchMerchantMenuView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DDMunchMerchantMenuView"];
        view.delegate = self;
        [view setData:self.sections[section]];
        return view;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.sections[section].type == DDMerchantDetailSectionTypeMenu) {
        return 106;
    }
    if (self.sections[section].type == DDMerchantDetailSectionTypeInfo) {
        return 71;
    }
    if (self.sections[section].type == DDMerchantDetailSectionTypeRating) {
        return 34;
    }
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDItemsTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDItemsTVC"];
    DDMerchantDeliveryMenuItemM *item = self.sections[indexPath.section].selectedMenu.items[indexPath.row];
    item.currency = self.apiModel.data.merchant.currency;
    [cell setData:item];
    cell.delegate = self;
    return cell;
}
-(void)didSelectItem:(DDMerchantDeliveryMenuItemM *)item withModificationType:(DDItemModification)type forCell:(nonnull DDItemsTVC *)cell{
    if (DDBasketManager.shared.basketIsAllowedToEdit) {
        if (item.haveCustomization) {
            if (type == DDItemModificationAdd) {
                [DDHomeUIManager.shared openCustomoization:self withData:item.copy withCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
                    DDMerchantDeliveryMenuItemM *itemToAdd = (DDMerchantDeliveryMenuItemM *)data;
                    [self addItem:itemToAdd forCell:cell];
                }];
            }else {
                NSArray *items = [DDBasketManager.shared itemsInBasketOfItem:item];
                [DDHomeUIManager.shared openRemoveCustomoization:self withData:items withCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
                    DDMerchantDeliveryMenuItemM *itemToDelete = (DDMerchantDeliveryMenuItemM *)data;
                    [self removeItem:itemToDelete shouldRemoveAll:[identifier isEqualToString:@"all"] forCell:cell];
                }];
            }
            
        }else {
            if (type == DDItemModificationAdd) {
                [self addItem:item forCell:cell];
            }else {
                [self removeItem:item shouldRemoveAll:NO forCell:cell];
            }
        }
    }else {
        if (type == DDItemModificationAdd) {
            [DDAlertUtils showAlertWithTitle:@"Warning".localized subtitle:@"Current basket belongs to another merchant. Do you want to clear?".localized buttonNames:@[@"YES".localized, @"NO".localized] onClick:^(int index) {
                if(index == 0) {
                    [DDBasketManager.shared resetBasket];
                    [DDBasketManager.shared setMerchant:self.apiModel.data.merchant];
                    [self didSelectItem:item withModificationType:type forCell:cell];
                }
            }];
        }
    }
}
-(DDMerchantRM *)merchantReq {
    return self.navigation.routerModel.data;
}
-(void)didTapFavouriteButton {
    if (self.apiModel.data.merchant != nil) {
        [self merchantReq].is_mark_fav = @(!self.apiModel.data.merchant.isFav);
        [DDHomeManager.shared markFavourite:[self merchantReq] showHUD:YES onCompletion:^(DDBaseApiModel * _Nullable model, NSError * _Nullable error) {
            if (model.successfulApi) {
                self.apiModel.data.merchant.is_favourite = [self merchantReq].is_mark_fav;
                [self.headerView reloadInputViews];
            }
        }];
    }
    
}

-(void)reloadData {
    [self updateViewBasketCount];
    [self.tableView reloadData];
}
-(void)addItem:(DDMerchantDeliveryMenuItemM *)item forCell:(DDItemsTVC *)cell{
    [DDBasketManager.shared addItem:item onCompletion:^(DDMerchantDeliveryMenuItemM * _Nullable item, NSString * _Nullable info, BOOL isCompleted) {
        [self.tableView beginUpdates];
        [cell reloadInputViews];
        [self.tableView endUpdates];
        [self updateViewBasketCount];
    }];
}
-(void)removeItem:(DDMerchantDeliveryMenuItemM *)item shouldRemoveAll:(BOOL)shouldRemoveAll forCell:(DDItemsTVC *)cell{
    [DDBasketManager.shared removeItem:item shouldRemoveAll:shouldRemoveAll onCompletion:^(DDMerchantDeliveryMenuItemM * _Nullable item, NSString * _Nullable info, BOOL isCompleted) {
        [self.tableView beginUpdates];
        [cell reloadInputViews];
        [self.tableView endUpdates];
        [self updateViewBasketCount];
    }];
}
-(void)didSelectShowAllMenu {
    [DDHomeUIManager.shared showMenu:self withMenu:self.apiModel.data.merchant.delivery_menu withcallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        self.sections.lastObject.selectedMenu = data;
        [self reloadAllMenus];
    }];
}
-(void)didSelectMenuAtIndexPath:(NSIndexPath *)indexPath {
    self.sections.lastObject.selectedMenu = self.sections.lastObject.merchant.delivery_menu[indexPath.row];
    [self reloadAllMenus];
}
-(void)reloadAllMenus {
    [self updateViewBasketCount];
    
    NSInteger menuIndex = [self numberOfSectionsInTableView:self.tableView] - 1;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:menuIndex] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollViewDidScroll:self.tableView];
    });
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.headerView superScrollViewDidScroll:scrollView];
    [self checkAndChooseNavigationBar];
}
-(void)checkAndChooseNavigationBar {
    [self setNavigationBarSettings:!(self.tableView.contentOffset.y > 0 && self.headerView.overlayView.alpha >= 1.0)];
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self.headerView superScrollViewDidScroll:scrollView];
}
-(void)setNavigationBarSettings:(BOOL)showTranparent {
    self.navigationController.navigationBar.translucent = YES;
    if (showTranparent) {
        [self setNavigationBarBackgroundColor:UIColor.clearColor];
        [self setTransparentNavigationBar];
    }else {
        [self setNavigationBarBackgroundColor:HOME_THEME.app_theme.colorValue];
    }
}
-(void)setAnimation:(UIView *)view direction:(BOOL)isAdding{
    CATransition *fadeTextAnimation = [CATransition animation];
    fadeTextAnimation.duration = 0.2;
    fadeTextAnimation.type = kCATransitionPush;
    if (isAdding) {
        fadeTextAnimation.subtype = kCATransitionFromBottom;
    }else {
        fadeTextAnimation.subtype = kCATransitionFromTop;
    }
    [view.layer addAnimation: fadeTextAnimation forKey: @"fadeText"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Merchant_Detail andModuleName:@"DDHomeUI" withClassRef:self];
}
- (IBAction)didTapViewBasket:(id)sender {
    if (DDUserManager.shared.isLoggedIn) {
        if (DDLocationsManager.shared.selectedCashlessDeliveryLocation.delivery_location_id != nil) {
            if (self.apiModel.data.merchant.isOpen && self.apiModel.data.merchant.isInsideRegion) {
                [DDBasketManager.shared syncAddressAndCurrentUser];
                DDCashlessCart *cart = DDCashlessCart.new;
                cart.basket = DDBasketManager.shared.basketCartParams;
                cart.default_param = DDCCommonParamManager.shared.default_api_parameters.toDictionary;
                cart.__basket = [DDEncryptionManager.shared encryptDictionaryIntoString:cart.basket.mutableCopy];
                cart.__default_param = [DDEncryptionManager.shared encryptDictionaryIntoString:cart.default_param.mutableCopy];
                [self openCartWithCart:cart];
            }else {
                [DDAlertUtils showOkAlertWithTitle:@"Can't Place Order".localized subtitle:self.apiModel.data.merchant.unableToPlaceOrderError completion:^{
                    if (!self.apiModel.data.merchant.isInsideRegion) {
                        [self didTapSelectLocation];
                    }
                }];
            }
            
        }else {
            [self didTapSelectLocation];
        }
    }else {
        [DDHomeUIManager.shared openLoginVC:self onCompletion:^{
            if (DDUserManager.shared.isLoggedIn) {
                [self loadMerchantDetail];
            }
        }];
    }
}
-(void)didTapSelectLocation {
    [DDHomeUIManager.shared showDeliveryLocationsVCFrom:self withData:nil andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:YES completion:^{}];
        [self loadMerchantDetail];
    }];
}
-(void)openCartWithCart:(DDCashlessCart *)cart {
    __weak typeof(self) weakSelf = self;
    [DDHomeUIManager.shared showCashlessCart:cart onController:self controllerCallBack:^(NSString * _Nonnull identifier, id _Nonnull params, UIViewController * _Nonnull controller) {
        if ([params isKindOfClass:NSDictionary.class]) {
            [controller dismissViewControllerAnimated:YES completion:^{
                [weakSelf openOrderStatus:((NSDictionary *)params)];
            }];
        }else {
            [self openEditorForCart:cart onController:controller];
        }
    }];
}
-(void)openEditorForCart:(DDCashlessCart *)cart onController:(UIViewController *)controller {
    [DDAlertUtils showCancelActionSheetWithTitle:@"Basket" message:@"View Order Basket JSON" buttonTexts:@[@"View Decrypted Order".localized, @"View Encrypted Order".localized] completion:^(int index) {
        DDUIBaseViewController *baseVC = (DDUIBaseViewController *)controller;
        if (baseVC != nil) {
            __weak typeof(self) weakSelf = self;
            [baseVC goBackWithCompletion:^{
                id data = [cart.decryptedCart bv_jsonDataWithPrettyPrint:YES];
                if (index == 1) {
                    data = [cart.toDictionary bv_jsonDataWithPrettyPrint:YES];
                }
                if ([data isKindOfClass:NSData.class]) {
                    [DDEditConfigManager openJSONEditor:(NSData *)data withTitle:@"Basket".localized onController:self andCallBack:^(NSString * _Nonnull identifier, id _Nonnull returnedData, UIViewController * _Nonnull controller) {
                        NSData *editedData = returnedData;
                        DDCashlessCart *newCart = [editedData decodeTo:DDCashlessCart.class];
                        if (newCart != nil) {
//                            [DDBasket.shared encryptedCashlessCart:newCart];
                            [weakSelf openCartWithCart:newCart];
                        }else {
                            [DDAlertUtils showOkAlertWithTitle:@"Failure" subtitle:@"Provided JSON is not appropriate for Cashless Order" completion:^{
                                [self openCartWithCart:cart];
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}

-(void)didTapInfoButton {
    [DDHomeUIManager.shared showMerchantInfoRatingOnController:self withData:self.apiModel.data.merchant withcallBack:nil];
}
-(void)openOrderStatus:(NSDictionary *)orderInfo {
    DDOrderRM *request = [DDOrderRM new];
    request.order_id = orderInfo[@"order_id"];
    [DDHomeUIManager.shared showOrderStatus:self withData:request WithcallBack:nil];
}
@end
