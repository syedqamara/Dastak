//
//  DDCashlessMerchantDetail.m
//  DDCashlessUI
//
//  Created by Syed Qamar Abbas on 09/03/2020.
//

#import "DDCashlessMerchantDetailVC.h"
#import "DDSegmentedTableView.h"
#import "DDCashlessItemTVC.h"
#import "DDCashless.h"
#import "DDCashlessMerchantDetailTblHeaderView.h"
#import "DDCashlessMerchantDetailTblHeaderViewModel.h"
#import "DDCashlessMerchantOffersTableHFV.h"
#import "DDCashlessMerchantSectionManusHFV.h"
#import "DDCashlessMerchantSectionOffersHFV.h"
#import "DDCashlessMerchantDetailOffersTVC.h"
#import "DDCashlessMerchantOffersCellViewModel.h"
#import "DDCashlessMerchantDeliveryInfoHFV.h"
#import "DDCashlessMerchantSectionOfflineAlertHFV.h"
#import "DDReorderInfoHFV.h"
#import "DDFavourites.h"
#import "DDLocations.h"
#import "DDCashlessMerchantSectionLockedOffersHFV.h"
#import "DDCashlessMerchantM+DDCashless.h"
#import "DDEditConfigManager.h"
#import <DDAnalyticsManager.h>

typedef NS_ENUM(NSUInteger, DDBasketModificationPermission)  {
    DDBasketModificationPermissionAllowed,
    DDBasketModificationPermissionDifferentMerchant,
    DDBasketModificationPermissionDifferentCashlessType,
    DDBasketModificationPermissionUnknown
};



@interface DDCashlessMerchantDetailVC ()<DDSegmentedTableViewDataSource, DDCashlessItemTVCDelegate, DDCashlessMerchantSectionManusHFVDelegate, DDCashlessMerchantSectionOffersHFVDelegate, DDCashlessMerchantDetailOffersTVCDelegate, DDReorderInfoHFVDelegate> {
    DDCashlessMerchantDetailTblHeaderView *tableHeaderView;
    DDCashlessMerchantOffersCellViewModel *offersCellViewModel;
    DDMerchantDetailSectionM *outletOfflineSection;
    BOOL isLocationSelectedOnThisController;
}
@property (strong, nonatomic) DDCashlessMerchantApiM *apiModel;
@property (strong, nonatomic) DDOutletM *selectedOutlet;
@property (assign, nonatomic) DDBasketModificationPermission basketPermission;
@property (weak, nonatomic) IBOutlet DDSegmentedTableView *segmentedTV;
@property (weak, nonatomic) IBOutlet UIView *viewBasketContainerView;
@property (weak, nonatomic) IBOutlet UIView *itemCountContainerView;
@property (weak, nonatomic) IBOutlet UILabel *itemCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewBasketButton;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *beforeSavingLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewBasketContainerHeightConstraint;
- (IBAction)didTapViewBasketButton:(id)sender;

@end

@implementation DDCashlessMerchantDetailVC

-(BOOL)hidesBottomBarWhenPushed {
    return YES;
}
-(BOOL)shouldLoadNavigationBar {
    DDCashlessRequestM *r = self.navigation.routerModel.data;
    return r.isDeliveryTabSelected;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isLocationSelectedOnThisController = ![DDLocationsManager.shared.selectedCashlessDeliveryLocation isCurrentLocation];
    if (![self shouldLoadNavigationBar]) {
        [self setTransparentNavigationBar];
    }else {
        [self.navigationController setNavigationBarHidden:YES];
    }
    self.segmentedTV.backgroundColor = DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue;
    [DDBasket.shared loadSavedBasket];
    offersCellViewModel = [[DDCashlessMerchantOffersCellViewModel alloc] init];
    self.selectedOutlet = [DDOutletM new];
    self.segmentedTV.estimatedHeaderHeight = 184.0;
    NSArray *cells = @[CashlessItemTVC, CashlessMerchantDetailOffersTVC];
    [_segmentedTV registerCells:cells andIdentifier:cells];
    NSArray *headers = @[CashlessMerchantSectionLockedOffersHFV,CashlessMerchantSectionOfflineAlertHFV, CashlessMerchantOffersTableHFV, CashlessMerchantSectionManusHFV, CashlessMerchantSectionOffersHFV, CashlessMerchantDeliveryInfoHFV, ReorderInfoHFV];
    
    [_segmentedTV registerHeaderFooter:headers andIdentifier: headers];
    _segmentedTV.dataSource = self;
    [self loadData];
    [self setUpTableHeaderViewWithAutolayouts];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self didChangeOccurInBasket];
    [self setStatusBarStyle:(UIStatusBarStyleLightContent)];
}
- (void) setUpTableHeaderViewWithAutolayouts {
    CGFloat yOffset = 0;
    if (@available(iOS 11.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        yOffset = window.safeAreaInsets.top;
    }else {
        if (IS_IPHONE_WITH_NOTCH_DEVICES){
            yOffset = 44;
        }else {
            yOffset = 20;
        }
    }
//    self.segmentedTV.contentInsets = UIEdgeInsetsMake(-(self.navigationController.navigationBar.bounds.size.height + yOffset),0,0,0);
    tableHeaderView = [DDCashlessMerchantDetailTblHeaderView nibInstanceOfClass:DDCashlessMerchantDetailTblHeaderView.class];
    [tableHeaderView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [tableHeaderView setHidden:YES];
    self.segmentedTV.tableHeaderView = tableHeaderView;
    
    [tableHeaderView.centerXAnchor constraintEqualToAnchor:self.segmentedTV.tvCenterXAnchor].active = YES;
    [tableHeaderView.widthAnchor constraintEqualToAnchor:self.segmentedTV.tvWidthAnchor].active = YES;
    [tableHeaderView.topAnchor constraintEqualToAnchor:self.segmentedTV.tvTopAnchor].active = YES;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:tableHeaderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:262];
    [tableHeaderView addConstraint:constraint];
    
    [self.segmentedTV.tableHeaderView setNeedsDisplay];
    [self.segmentedTV.tableHeaderView layoutIfNeeded];
}
-(void)designUI {
    [super designUI];
    [self setTransparentNavigationBar];
//    [[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icMore"] imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)]
    
    [self showMoreButton];
    self.segmentedTV.upperViewBackgroundColor = DDCashlessThemeManager.shared.selected_theme.bg_grey_248.colorValue;
    self.segmentedTV.upperViewTableViewSeparatorColor = DDCashlessThemeManager.shared.selected_theme.bg_grey_220.colorValue;
    self.view.backgroundColor = DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue;
    self.itemCountContainerView.backgroundColor = DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue;
    [self.viewBasketButton setTitleColor:DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue forState:(UIControlStateNormal)];
    self.priceLabel.textColor = DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue;
    self.beforeSavingLabel.textColor = DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue;
    self.itemCountLabel.textColor = DDCashlessThemeManager.shared.selected_theme.app_theme.colorValue;
    
    self.itemCountLabel.font = [UIFont DDBoldFont:17];
    self.beforeSavingLabel.font = [UIFont DDMediumFont:11];
    self.priceLabel.font = [UIFont DDBoldFont:15];
    self.viewBasketButton.titleLabel.font = [UIFont DDBoldFont:17];
    _segmentedTV.selectionBackgroundColor = DDUIThemeManager.shared.selected_theme.app_theme.colorValue;
    
}
-(void)checkAndChangeViewBasketView {
    if (DDBasket.shared.currentOrder.count > 0 && self.basketPermission == DDBasketModificationPermissionAllowed && self.apiModel != nil) {
        self.itemCountLabel.text = [NSString stringWithFormat:@"%ld",DDBasket.shared.currentOrder.count];
        NSString *currency = @"";
        if (self.apiModel.data.merchant.outletCurrency != nil) {
            currency = self.apiModel.data.merchant.outletCurrency;
        }
        self.priceLabel.text = [NSString stringWithFormat:@"%@ %.2f", currency, DDBasket.shared.currentOrder.allPriceWithUpgradesAndCounts];
        [UIView animateWithDuration:0.1 animations:^{
            self.viewBasketContainerHeightConstraint.constant = 82;
            [self.view layoutIfNeeded];
        }];
    }else {
        [UIView animateWithDuration:0.1 animations:^{
            self.viewBasketContainerHeightConstraint.constant = 0;
            [self.view layoutIfNeeded];
        }];
    }
}
-(void)loadData {
    DDCashlessRequestM *r = self.navigation.routerModel.data;
    r.cashless_delivery = @(YES);
    r.cashless_delivery_enabled = @(YES);
    r.delivery_lat = DDLocationsManager.shared.selectedCashlessDeliveryLocation.latitude;
    r.delivery_lng = DDLocationsManager.shared.selectedCashlessDeliveryLocation.longitude;
    r.is_new_order_status_flow = @(YES);
    r.is_last_mile_enabled = @(YES);
    
    
    __weak typeof(self) weakSelf = self;
    [DDCashlessManager.shared allMerchantDetailApis:r withCompletion:^(DDCashlessMerchantApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        weakSelf.apiModel = model;
        [weakSelf refreshBasketWithNewMerchant];
        [weakSelf insertMenusInSectionsManually];
        [weakSelf validateSelectedDeliveryLocation];
        [weakSelf.segmentedTV reload];
    }];
}
-(void)refreshBasketWithNewMerchant {
    DDCashlessRequestM *r = self.navigation.routerModel.data;
    if (DDCAppConfigManager.shared.api_config.CASHLESS_CART_URL.length == 0) {
        DDCAppConfigManager.shared.api_config.CASHLESS_CART_URL = self.apiModel.data.merchant.d_cart_url;
    }
    
    if (self.apiModel.data.merchant.isLastMileDelivery) {
        DDBasket.shared.currentOrder.selected_region.zone_id = self.apiModel.data.merchant.zoneID;
    }
    if (self.apiModel.data.merchant.isTakeAway) {
        //Settings For TakeAway
        DDBasket.shared.currentOrder.isTakeawayOrder = [NSNumber numberWithBool:YES];
    }else {
        //Settings For Delivery
        DDBasket.shared.currentOrder.isTakeawayOrder = [NSNumber numberWithBool:NO];
    }
    for( DDOutletM * outlet in self.apiModel.data.merchant.outlets){
        if([outlet.outlet_id isEqualToNumber:r.outlet_id]){
            self.selectedOutlet = [DDOutletM.alloc initWithDictionary:outlet.toDictionary error:nil];
            break;
        }
    }
    if ([DDBasket isBasketEmpty]){
        [self setOutletAndMerchantInBasket];
        self.basketPermission = DDBasketModificationPermissionAllowed;
    } else if (([self.selectedOutlet.outlet_id.stringValue isEqualToString:DDBasket.shared.currentOrder.outlet.outlet_id.stringValue] && DDBasket.shared.currentOrder.merchant != nil)) {
        if (self.apiModel.data.merchant.isTakeAway != DDBasket.shared.currentOrder.merchant.isTakeAway) {
            self.basketPermission = DDBasketModificationPermissionDifferentCashlessType;
        }else {
            [self setOutletAndMerchantInBasket];
            self.basketPermission = DDBasketModificationPermissionAllowed;
        }
    }else {
        self.basketPermission = DDBasketModificationPermissionDifferentMerchant;
    }
    [self checkAndChangeViewBasketView];
    offersCellViewModel.merchant = self.apiModel.data.merchant;
    offersCellViewModel.selectedOutlet = self.selectedOutlet;
}
-(void) setOutletAndMerchantInBasket{
    [DDBasket.shared setMerchant:self.apiModel.data.merchant andAllProducts:[DDBasket.shared.currentOrder.addedProducts mutableCopy]];
    DDBasket.shared.currentOrder.outlet = self.selectedOutlet;
}
-(void)insertMenusInSectionsManually {
    NSMutableArray <DDMerchantDetailSectionM, Optional> *arr = self.apiModel.data.merchant.sections.mutableCopy;
    if (arr == nil) {
        arr = [NSMutableArray<DDMerchantDetailSectionM, Optional> new];
    }
    
    outletOfflineSection = [DDMerchantDetailSectionM new];
    outletOfflineSection.identifier = OFFLINE_DELIVERY_SECTION_ID;
    outletOfflineSection.is_expandable = @(YES);
    outletOfflineSection.is_expanded = @(NO);
    if (arr.count > 2) {
        [arr insertObject:outletOfflineSection atIndex:2];
    }else {
        [arr addObject:outletOfflineSection];
    }
    
    
    for (DDCashlessMenuM *menu in self.apiModel.data.merchant.menus) {
        DDMerchantDetailSectionM *section = [DDMerchantDetailSectionM new];
        section.section_name = menu.menuName;
        section.identifier = MENU_SECTION_ID;
        section.menu = menu;
        [arr addObject:section];
    }
    self.apiModel.data.merchant.sections = arr;
    
    
    DDCashlessMerchantDetailTblHeaderViewModel *vm = [DDCashlessMerchantDetailTblHeaderViewModel new];
    vm.outlet = self.selectedOutlet;
    vm.merchant = self.apiModel.data.merchant;
    [tableHeaderView setData:vm];
    [tableHeaderView setHidden:NO];
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.apiModel.data.merchant.sections.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DDMerchantDetailSectionM *sect = self.apiModel.data.merchant.sections[section];
    if (sect.getType == DDMerchantSectionCashlessMenuItems) {
        return sect.menu.products.count;
    }else if (sect.isCashlessOffers) {
        return 1;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDMerchantDetailSectionM *sect = self.apiModel.data.merchant.sections[indexPath.section];
    if (sect.getType == DDMerchantSectionCashlessMenuItems) {
        return [self tableView:tableView menuItemCellOfSection:sect atIndexPath:indexPath];
    }else if (sect.isCashlessOffers) {
        DDCashlessMerchantDetailOffersTVC *cell = [tableView dequeueReusableCellWithIdentifier:CashlessMerchantDetailOffersTVC];
        offersCellViewModel.section = sect;
        [cell setData:offersCellViewModel];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [UITableViewCell new];
}

#pragma mark - UITableViewDelegate


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    DDMerchantDetailSectionM *sectionModel =  self.apiModel.data.merchant.sections[section];
    if (sectionModel.shouldHaveHeaderView) {
        return UITableViewAutomaticDimension;
    }
    return 0.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [self cashlessHeaderView:tableView forSection:section];
    if (view.tag != -11) {
        [view setHidden:NO];
    }
    return view;
}

//MARK:- TableDelegatesDataSourceInvokingMethod

-(UIView *)cashlessHeaderView:(UITableView *)tableView forSection:(NSInteger)section {
    DDMerchantDetailSectionM *sectionModel =  self.apiModel.data.merchant.sections[section];
    
    if (sectionModel.getType == DDMerchantSectionManuButtons) {
        DDCashlessMerchantSectionManusHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessMerchantSectionManusHFV];
        [view setData:sectionModel];
        [view setHidden:NO];
        view.delegate = self;
        view.tag = section;
        return view;
    }
    else if (sectionModel.getType == DDMerchantSectionCashlessReorder) {
        DDReorderInfoHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ReorderInfoHFV];
        [view setData:sectionModel];
        [view setHidden:NO];
        view.delegate = self;
        view.tag = section;
        return view;
    }
    else if (sectionModel.getType == DDMerchantSectionCashlessDeliveryInfo) {
        DDCashlessMerchantDeliveryInfoHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessMerchantDeliveryInfoHFV];
        [view setData:sectionModel];
        [view setHidden:NO];
        view.tag = section;
        return view;
    }
    else if (sectionModel.getType == DDMerchantSectionOffers || sectionModel.getType == DDMerchantSectionPreviewOffers) {
        sectionModel.is_expandable = @(YES);
        sectionModel.is_expanded = self.apiModel.data.merchant.is_offer_section_expanded;
        DDCashlessMerchantSectionOffersHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessMerchantSectionOffersHFV];
        [view setData:sectionModel];
        [view setHidden:NO];
        view.delegate = self;
        view.tag = section;
        return view;
    }
    else if (sectionModel.getType == DDMerchantSectionCashlessMenu || sectionModel.getType == DDMerchantSectionCashlessMenuItems) {
        DDCashlessMerchantSectionOffersHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessMerchantSectionOffersHFV];
        [view setData:sectionModel];
        [view setHidden:NO];
        view.tag = section;
        return view;
    }
    else if (sectionModel.getType == DDMerchantSectionCashlessOfflineAlert) {
        DDCashlessMerchantSectionOfflineAlertHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessMerchantSectionOfflineAlertHFV];
        [view setData:sectionModel];
        view.tag = -11;
        return view;
    }
    else if (sectionModel.getType == DDMerchantSectionLockedOffers) {
        DDCashlessMerchantSectionLockedOffersHFV *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CashlessMerchantSectionLockedOffersHFV];
        [view setData:sectionModel];
        __weak typeof(self) weakSelf = self;
        view.callBackShowAllLlockeOffers = ^{
            DDMerchantOffersLocalDataM *model =  [[DDMerchantOffersLocalDataM alloc] init];
            model.merchant = weakSelf.apiModel.data.merchant;
            model.selectedOutlet = weakSelf.selectedOutlet;
            model.section = sectionModel;
            [[DDCashlessUIManager shared] openMerchantLockeOffersView:self withLockOffersSectionAndModel:model onCompletion:^{
            }];
        };
        [view setHidden:NO];
        return view;
    }
    else
        return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView menuItemCellOfSection:(DDMerchantDetailSectionM *)section atIndexPath:(NSIndexPath *)indexPath {
    DDCashlessItemTVC *cell = [tableView dequeueReusableCellWithIdentifier:CashlessItemTVC];
    cell.delegate = self;
    DDCashlessItemM *item = section.menu.products[indexPath.row];
    item.itemName = item.itemName;
    item.currency = self.apiModel.data.merchant.outletCurrency;
    [cell setData:item];
    return cell;
}

-(DDTagM *)tableView:(UITableView *)tableView tagForHeaderInSection:(NSInteger)section {
    DDMerchantDetailSectionM *sect = self.apiModel.data.merchant.sections[section];
    DDTagM *tag = [DDTagM new];
    tag.corner_radius = 5;
    tag.title = sect.section_name;
    tag.is_enabled = sect.getType == DDMerchantSectionCashlessMenuItems;
    tag.background_color = UIColor.clearColor;
    tag.title_color_normal = DDUIThemeManager.shared.selected_theme.text_black.colorValue;
    tag.title_color_selected = UIColor.whiteColor;
    tag.font_normal = [UIFont DDRegularFont:13];
    tag.font_selected = [UIFont DDBoldFont:13];
    return tag;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![self shouldLoadNavigationBar]) {
        CGFloat maxThreshold = tableHeaderView.frame.size.height/1.75;
        CGFloat overlayColorAlpha = scrollView.contentOffset.y/maxThreshold;
        [tableHeaderView changeOverlayColorByAlpha:overlayColorAlpha];
        if (overlayColorAlpha >= 1) {
            self.navigationItem.title = self.apiModel.data.merchant.name;
            [self setNavigationBarBackgroundColor:CASHLESS_THEME.app_theme.colorValue];
        }else {
            self.navigationItem.title = @"";
            [self setTransparentNavigationBar];
            self.navigationController.navigationBar.barTintColor = UIColor.clearColor;
            [self setNavigationBarBackgroundColor:UIColor.clearColor];
        }
    }
}
-(void)horizontalMenuToggleHidden:(BOOL)isHidden {
//    if (isHidden) {
//        [self showNavBarWithDuration:0.3];
//    }else {
//        [self hideNavBarWithDuration:0.3];
//    }
}
-(void)didTapAddItemButton:(DDCashlessItemM *)item fromCell:(nonnull DDCashlessItemTVC *)cell{
    __weak typeof(self) weakSelf = self;
    [self checkBasketModificationIsAllowed:^{
        if (item.isCustomizable) {
            [DDCashlessUIManager.shared showCashlessItemCustomization:self withData:item.mutableCopy andControllerCallBack:^(NSString * _Nonnull identifier, id _Nonnull data, UIViewController * _Nonnull controller) {
                DDCashlessItemM *itemToAdd = data;
                [DDBasket.shared.currentOrder addItemToBasket:itemToAdd];
                [cell setData:item];
                [weakSelf didChangeOccurInBasket];
            }];
        }else {
            [DDBasket.shared.currentOrder addItemToBasket:item];
            [cell setData:item];
            [weakSelf didChangeOccurInBasket];
        }
    }];
}
-(void)didTapRemoveItemButton:(DDCashlessItemM *)item fromCell:(nonnull DDCashlessItemTVC *)cell {
    __weak typeof (self) weakSelf = self;
    BOOL zeroItem = [DDBasket.shared.currentOrder countOfItemInBasket:item] == 0;
    if (zeroItem) return;
    [self checkBasketModificationIsAllowed:^{
        if (item.isCustomizable) {
            NSArray <DDCashlessItemM *> *itemsToRemove = [DDBasket.shared.currentOrder getSelectedCustomizedProductsAgainstProduct:item];
            [DDCashlessUIManager.shared showCashlessRemoveItemsVCFrom:weakSelf withData:itemsToRemove andControllerCallBack:^(NSString * _Nonnull status, id _Nonnull data, UIViewController * _Nonnull from) {
                [from dismissViewControllerAnimated:YES completion:nil];
                if ([status isEqualToString:DONE]) {
                    [cell setData:item];
                    [weakSelf didChangeOccurInBasket];
                }
            }];
        } else {
            [DDBasket.shared.currentOrder removeItemFromBasket:item];
            [cell setData:item];
            [weakSelf didChangeOccurInBasket];
        }
    }];
}
-(void)checkBasketModificationIsAllowed:(void(^)(void))completion {
    if (self.basketPermission == DDBasketModificationPermissionAllowed) {
        completion();
    }
    else if (self.basketPermission == DDBasketModificationPermissionDifferentMerchant) {
        [self clearCartAndUpdateViewWithTitle:@"" andMessage:ALERT_TEXT_DIFFERDD_MERCHANT_EN];
    }else if(self.basketPermission == DDBasketModificationPermissionDifferentCashlessType){
        NSString *message = ALERT_TEXT_DIFFERDD_CASHLESS_TYPE_EN;
        message = [message stringByReplacingOccurrencesOfString:@"%@" withString:DDBasket.shared.cashlessType];
        [self clearCartAndUpdateViewWithTitle:@"" andMessage:message];
    }
}
-(void)clearCartAndUpdateViewWithTitle:(NSString *)title andMessage:(NSString *)message {
    __weak typeof(self) weakSelf = self;
    [DDAlertUtils showAlertWithTitle:title subtitle:message buttonNames:@[ALERT_TEXT_CLEAR_EN,ALERT_TEXT_CANCEL_EN] onClick:^(int index) {
        if (index == 0) {
            weakSelf.basketPermission = DDBasketModificationPermissionAllowed;
            [DDBasket.shared resetBasketForceReset:YES];
            [weakSelf setOutletAndMerchantInBasket];
            [weakSelf.segmentedTV reload];
        }
    }];
    
}
-(void)didChangeOccurInBasket {
    [self checkAndChangeViewBasketView];
}
-(void)didTapMenuItem:(DDMerchantMenuButtonM *)button {
    if ([button.type  isEqual: DDFavouriteBtn]){
        // call favourite api to set unset
        [self invokeFavouriteApi];
    }else if ([button.type  isEqual: DDPingBtn]){
        // pings module will get control with offers array
    }else if ([button.type  isEqual: DDMenuBtn]){
        // open menu
    }else if ([button.type  isEqual: DDCatalogueBtn]){
        // open catalogue
    }else{
        
    }
}
-(void)invokeFavouriteApi {
    [[DDFavouritesManager shared] markFavoritie:@[self.apiModel.data.merchant.merchant_id] isFavourite:!self.apiModel.data.merchant.is_favourite.boolValue needFavRefresh:YES completion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (model.success.boolValue) {
            self.apiModel.data.merchant.is_favourite = @(!self.apiModel.data.merchant.is_favourite.boolValue);
            for (DDMerchantDetailSectionM *sectionModel in self.apiModel.data.merchant.sections){
                if (sectionModel.getType == DDMerchantSectionManuButtons) {
                    for (DDMerchantMenuButtonM *menu in sectionModel.menu_buttons){
                        if ([menu.type isEqualToString:@"favourites"]){
                            menu.is_favourite = self.apiModel.data.merchant.is_favourite;
                            break;
                        }
                    }
                    break;
                }
            }
            [self.segmentedTV reload];
        }
    }];
}

//MARK:- DDReorderInfoHFVDelegate

-(void)didTapReorderButtonForOrder:(DDOrderM *)order {
    DDCashlessRequestM *req = [DDCashlessRequestM new];
    req.order_id = order.order_id;
    [DDCashlessManager.shared validateReorder:req withCompletion:^(DDCashlessReorderApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDBasket.shared.currentOrder.addedProducts = model.data.addedProducts.mutableCopy;
        [DDBasket.shared.currentOrder saveAsJson];
        [self didChangeOccurInBasket];
        [self.segmentedTV reload];
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)didTapOptionsButton {
    [DDCashlessUIManager.shared openMerchantTopMenuOptions:self withTopMenuArray:self.apiModel.data.merchant onCompletion:^{
        
    }];
}
-(void)didTapExpandCollapsButtonFromOfferAtSection:(NSInteger)section {
    self.apiModel.data.merchant.is_offer_section_expanded = @(!self.apiModel.data.merchant.isExpanded);
    [self.segmentedTV reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
}

- (IBAction)didTapViewBasketButton:(id)sender {
    [self showCart];
}
-(void)deliveryLocationChanged {
    isLocationSelectedOnThisController = YES;
    [self validateSelectedDeliveryLocation];
}
-(void)validateSelectedDeliveryLocation {
    [self.apiModel.data.merchant validateSelectedLocationOnOutlet:self.selectedOutlet onCompletion:^(NSString * _Nullable error) {
        if (error.length > 0) {
            [DDAlertUtils showOkAlertWithTitle:@"LM Validation Error".localized subtitle:error completion:nil];
        }
        [self checkOutletOnlineAndDeliverableLocation];
    }];
}
-(void)checkOutletOnlineAndDeliverableLocation {
    outletOfflineSection.section_subtitle = self.apiModel.data.merchant.offline_alert_message;
    outletOfflineSection.is_expanded = @(!self.apiModel.data.merchant.isAllowedToPlaceOrder);
    [self.segmentedTV reload];
}

-(void)showCart {
    
    if (self.apiModel.data.merchant.isAllowedToPlaceOrder) {
        if (isLocationSelectedOnThisController) {
            DDCashlessCart *cart = DDBasket.shared.getBasketRequestMForWeb;
            [self openCartWithCart:cart];
        }else {
            [self didTapSelectDeliveryLocation];
        }
    }
}
-(void)openCartWithCart:(DDCashlessCart *)cart {
    __weak typeof(self) weakSelf = self;
    
    [DDCashlessUIManager.shared showCashlessCart:cart onController:self controllerCallBack:^(NSString * _Nonnull identifier, id _Nonnull params, UIViewController * _Nonnull controller) {
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
                            [DDBasket.shared encryptedCashlessCart:newCart];
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
-(void)openOrderStatus:(NSDictionary *)orderInfo {
    DDOrderStatusRequestM *screenData = [DDOrderStatusRequestM.alloc initWithDictionary:orderInfo error:nil];
    screenData.order_status_order_type = @(DDOrderStatusOrderTypeNewOrder);
    [APP_ANALYTICS trackEvent:APPBOY_EVDD_OrderedDelivery withType:DDEventTypeBraze andParam:@{} andEventDescription:@""];
    __weak typeof(self) weakSelf = self;
    [DDCashlessUIManager.shared showOrderStatus:screenData onController:self andControllerCallBack:^(NSString * _Nonnull identifier, id _Nonnull data, UIViewController * _Nonnull controller) {
        [weakSelf.segmentedTV reload];
    }];
}

- (void)didTapOfferItem:(nonnull DDCashlessMerchantOffersCellViewModel *)offerViewModel {
    
}

+(NSArray<DDUIRouterM *> *)deeplinkRoutes {
    DDUIRouterM *r1 = [[DDUIRouterM alloc]init];
    r1.route_link = DD_Nav_Cashless_Merchant_Detail;
    r1.transition = DDUITransitionPush;
    r1.is_animated = YES;
    r1.should_embed_in_nav = NO;
    return @[r1];
}
@end
