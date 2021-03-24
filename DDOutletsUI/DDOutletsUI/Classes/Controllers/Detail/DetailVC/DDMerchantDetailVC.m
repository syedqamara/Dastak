//
//  DDMerchantDetailVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 27/01/2020.
//

#import "DDMerchantDetailVC.h"
#import <DDOutlets/DDOutlets.h>
#import "DDOutletsUIManager.h"
#import "DDMerchantDetailTblHeaderView.h"
#import "DDMerchantDetailModulesViewModel.h"
#import "DDMerchantDetailModulesTVC.h"
#import "DDMerchantSectionAmenitiesHFV.h"
#import "DDMerchantSectionOutletDetailHFV.h"
#import "DDMerchantSectionLockedOffersHFV.h"
#import "DDMerchantSectionManusHFV.h"
#import "DDMerchantSectionModulesHFV.h"
#import "DDMerchantSectionOffersHFV.h"
#import "DDMerchantSectionOutletLocationHFV.h"
#import "DDMerchantSectionProductsHFV.h"
#import "DDMerchantDetailTblHeaderViewModel.h"
#import "DDMerchantDetailOffersTVC.h"
#import "DDMerchantSectionOnlineOffersHFV.h"
#import "DDMDProductTVC.h"
#import "DDUserManager.h"
#import "DDAuthUIManager.h"
#import <DDLocations/DDLocations.h>
#import "DDMerchantOutletLocationViewM.h"
#import "DDNormalDeliveryMenuTVC.h"
#import <DDFavourites/DDFavourites.h>

@interface DDMerchantDetailVC () <UITableViewDelegate, UITableViewDataSource,DDMerchantSectionOutletDetailHFVDelegate, DDMerchantSectionManusHFVDelegate, DDMerchantSectionOutletLocationHFVDelegate, DDMerchantSectionOffersHFVDelegate, DDMerchantDetailOffersTVCDelegate, DDMerchantDetailModulesTVCDelegate>
{
    DDMerchantDetailRequestM *reqModel;
    DDOutletM *selectedOutlet;
    DDMerchantDetailTblHeaderView *tableHeaderView;
    DDMerchantDetailM *merchantData;
    NSMutableArray *modules;
    BOOL isNavBarShowingWithAppSolidColor;
    DDMerchantOffersLocalDataM *offersCellViewModel;
    DDMerchantDetailTblHeaderViewModel *headerModel;
    CGFloat tableViewScrollContentOffset;
    NSMutableArray *productsArray;
    BOOL isNormalDeliveryViewShowing;
    NSMutableArray<DDMerchantDetailSectionM*> *sections;
}
@end

@implementation DDMerchantDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    sections = [NSMutableArray new];
    reqModel = (DDMerchantDetailRequestM*)self.navigation.routerModel.data;
    DDOutletM *outletWeGetForDetailReq = [[DDOutletM alloc] init];
    outletWeGetForDetailReq.outlet_id = reqModel.outlet_id;
    selectedOutlet = outletWeGetForDetailReq;
    modules = [NSMutableArray new];
    headerModel = [[DDMerchantDetailTblHeaderViewModel alloc] init];
    offersCellViewModel = [[DDMerchantOffersLocalDataM alloc] init];
    productsArray = [NSMutableArray new];
    
    [self setUpInitailNavBar];
    [self setUpTableView];
    [self setUpTableHeaderViewWithAutolayouts];
    
    [self loadProductsData:YES];
    tableViewScrollContentOffset = 0;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void) registerNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMerchantDetail:) name:DDRefreshMerchantOffersDetail object:nil];
}

-(void)dealloc{
    [self removeObservers];
}

-(void)removeObservers{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DDRefreshMerchantOffersDetail object:nil];
}

-(BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self setTransparentNavigationBar];
    [self changeNavigationBar:tableViewScrollContentOffset];
    [self.tblView reloadData];
}

- (void) setUpInitailNavBar {
    [self standardNavigationBar];
    [self setTransparentNavigationBar];
    [self addBackArrowNavigtaionItemWithtitle:@"Offers".localized];
    [self addNavigationItemWithImage:@"icMore.png" identifier:@"navBtnMenu" tintColor:[UIColor whiteColor] direction:DDNavigationItemDirectionRight];
    [self addNavigationItemWithImage:@"icLocation.png" identifier:@"navBtnMap" tintColor:[UIColor whiteColor] direction:DDNavigationItemDirectionRight];
}

- (void) setUpTableView {
    NSArray *headerViews = @[DDMerchantDetailAmenitiesSectionCell,DDMerchantDetailSectionCell,DDMerchantDetailSectionManusHFV, DDMerchantDetailSectionOutletLocationHFV, DDMerchantDetailSectionOffersHFV, DDMerchantDetailSectionLockedOffersHFV, DDMerchantDetailSectionProductsHFV, DDMerchantDetailSectionOnlineOffersHFV];
    NSArray *tableCells = @[DDMerchantDetailModulesCell, DDMerchantDetailOffersTVCell, DDMDProductTVCell,DDNormalDeliveryMenuTVCell];
    [self.tblView registerHeaderFooterWithNibNames:headerViews forClass:self.class withIdentifiers:headerViews];
    [self.tblView registerCellWithNibNames:tableCells forClass:self.class withIdentifiers:tableCells];
    self.tblView.dataSource = self;
    self.tblView.delegate = self;
    self.tblView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    self.tblView.sectionHeaderHeight = 184.0;
    self.tblView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tblView.rowHeight = 150.0;
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
    self.tblView.contentInset = UIEdgeInsetsMake(-(self.navigationController.navigationBar.bounds.size.height + yOffset),0,0,0);
    tableHeaderView = [DDMerchantDetailTblHeaderView nibInstanceOfClass:DDMerchantDetailTblHeaderView.class];
    [tableHeaderView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.tblView.tableHeaderView = tableHeaderView;
    
    [tableHeaderView.centerXAnchor constraintEqualToAnchor:self.tblView.centerXAnchor].active = YES;
    [tableHeaderView.widthAnchor constraintEqualToAnchor:self.tblView.widthAnchor].active = YES;
    [tableHeaderView.topAnchor constraintEqualToAnchor:self.tblView.topAnchor].active = YES;
    CGFloat height = 262;
    if (isNormalDeliveryViewShowing){
        height = 262+80;
    }else {
        
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:tableHeaderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height];
    [tableHeaderView addConstraint:constraint];
    
    [self.tblView.tableHeaderView setNeedsDisplay];
    [self.tblView.tableHeaderView layoutIfNeeded];    
}

-(void)designUI   {
    [super designUI];
}


#pragma mark - NAV BAR actions

-(void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    if ([sender.identifier isEqualToString:@"navBtnMenu"]){
        [self topMenuActionFromNavBar];
    }else if ([sender.identifier isEqualToString:@"navBtnMap"]) {
        [self mapActionFromNavBar];
    }else{
        [self backActionFromNavBar];
    }
}

-(void) mapActionFromNavBar {
    DDMerchantOffersLocalDataM *data = [[DDMerchantOffersLocalDataM alloc] init];
    data.selectedOutlet = selectedOutlet;
    data.merchant = merchantData;
    [DDOutletsUIManager.shared openMerchantOnMap:self withSelectedOutlet:data onCompletion:^{
    }];
}

-(void) topMenuActionFromNavBar  {
    [DDOutletsUIManager.shared openMerchantTopMenuOptions:self withMerchnatData:merchantData onCompletion:^{
    }];
}

-(void) backActionFromNavBar {
    [self goBackWithCompletion:nil];
}

#pragma mark - LOADING DATA

- (void) loadProductsData : (BOOL) showLoader {
    DDBaseRequestModel *reqM = [[DDBaseRequestModel alloc] init];
    [reqM addCustomParams:@{@"merchant_id":reqModel.merchant_id}];
    [[DDOutletsManager shared] fetchProductsList:reqM showLoader:showLoader andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDProfileApiM *data = (DDProfileApiM*) model;
        if (data != nil && data.data.products != nil && data.data.products.count > 0){
            self->productsArray = data.data.products.mutableCopy;
        }else{
            [self->productsArray removeAllObjects];
        }
        [self loadMerchantDetail:YES];
    }];
}

- (void) loadMerchantDetail : (BOOL) showLoader {
    reqModel.custom_parameters = [NSMutableDictionary new];
    __weak typeof(self) weakSelf = self;
    [[DDOutletsManager shared] fetchMerchantDetail:reqModel showLoader:showLoader andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __strong typeof(self) strongSelf = weakSelf;
        if (error == nil) {
            [strongSelf processData:(DDMerchantDetailApiM*) model];
        }else{
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
        }
    }];
}

-(void) processData : (DDMerchantDetailApiM*)merchantModel {
    merchantData = merchantModel.data.merchant;
    headerModel.merchant = merchantData;
    [self setUpPreExpandSections:DDMerchantSectionOffers];
    [self setUpPreExpandSections:DDMerchantSectionPreviewOffers];
    BOOL outletFound = NO;
    for (DDOutletM *outlet in merchantData.outlets){
        if (outlet.outlet_id == selectedOutlet.outlet_id){
            outletFound = YES;
            [self setSelectedOutletAndOtherViewModels:outlet];
            break;
        }
    }
    if (!outletFound && merchantData.outlets.count > 0){
        [self setSelectedOutletAndOtherViewModels:merchantData.outlets.firstObject];
    }
}

-(void)setUpPreExpandSections : (DDMerchantDetailSectionType)sectionId{
    for (DDMerchantDetailSectionM *section in merchantData.sections){
        if (section.getType == sectionId){
            section.is_expanded = @(1);
            break;
        }
    }
}

// this function will be called on outlet location change
- (void) setSelectedOutletAndOtherViewModels : (DDOutletM*)outlet {
    selectedOutlet = outlet;
    if (selectedOutlet) {
        reqModel.outlet_id = selectedOutlet.outlet_id;
        if (selectedOutlet.merchant != nil && selectedOutlet.merchant.merchant_id != nil){
            reqModel.merchant_id = selectedOutlet.merchant.merchant_id;
        }else{
           reqModel.merchant_id = merchantData.merchant_id;
        }
    }
    
    DDCAppConfigManager.shared.api_config.BOOK_A_TABLE_URL = selectedOutlet.bat_section.bat_url;
    DDCAppConfigManager.shared.api_config.CINEMA_URL = selectedOutlet.cinema_booking_info.cb_url;
    
    [self setViewModels];
    [self reloadTableView];
}

- (void) setViewModels {
    sections = merchantData.sections.mutableCopy;
    headerModel.outlet = selectedOutlet;
    headerModel.is_deliveryView = @(isNormalDeliveryViewShowing);
    [tableHeaderView setData:headerModel];
    
    [self setUpNormalDeliveryOffersSection];
    [self setUpModulesDataArray];
    [self setUpOutletDetailSection];
    
    offersCellViewModel.merchant = merchantData;
    offersCellViewModel.selectedOutlet = selectedOutlet;
}

-(void) setUpNormalDeliveryOffersSection {
    if (isNormalDeliveryViewShowing){
        NSInteger index = -1;
        for (int i=0; i<sections.count; i++){
            DDMerchantDetailSectionM *section = sections[i];
            if (section.getType == DDMerchantSectionOutletDetail){
                index = i-1;
                break;
            }
        }
        if (index > 0){
            NSMutableArray<DDMenuSection*> *menu_sections = merchantData.delivery_section.menu_section.mutableCopy;
            for (DDMenuSection *menuSection in menu_sections){
                DDMerchantDetailSectionM *newSection = [[DDMerchantDetailSectionM alloc] init];
                newSection.is_expandable = @(0);
                newSection.expandable_button_text = @"";
                newSection.identifier = [NSString stringWithFormat:@"%@",NormalDeliverySectionID];
                newSection.section_name = menuSection.title;
                newSection.menus_old_delivery = menuSection.menus;
                index = index +1;
                [sections insertObject:newSection atIndex:index];
            }
        }
    }
}

-(void)setUpModulesDataArray {
    for (DDMerchantDetailSectionM *section in sections){
        if (section.getType == DDMerchantSectionModules){
            for(DDMerchantModuleNavigation *modules in selectedOutlet.modules_navigations){
                if ([modules.identifier isEqualToString:NormalDeliveryID]){
                    if (isNormalDeliveryViewShowing){
                        modules.title = [NormalDineIn localized];
                    }else{
                        modules.title = [NormalDelivery localized];
                    }
                    break;
                }
            }
            section.modules_navigations = selectedOutlet.modules_navigations;
            if (section.modules_navigations == nil){
                NSMutableArray<DDMerchantModuleNavigation *> *array = [NSMutableArray array];
                modules =  array;
            }else{
                modules = [DDMerchantDetailModulesViewModel getAccumulatedOutletServicesArray:section.modules_navigations.mutableCopy];
            }
            break;
        }
    }
}

- (void) setUpOutletDetailSection {
    for (DDMerchantDetailSectionM *section in sections){
        if (section.getType == DDMerchantSectionOutletDetail){
            section.detail_desc = merchantData.merchant_description;
            
            NSMutableArray <DDMerchantDetailAttributesM*> *detail_attributes = [NSMutableArray new];
            
            if (selectedOutlet.human_location && selectedOutlet.human_location.length){
                DDMerchantDetailAttributesM * attribM = [[DDMerchantDetailAttributesM alloc] init];
                attribM.title = @"Location".localized;
                attribM.value = selectedOutlet.human_location;
                [detail_attributes addObject:attribM];
            }
            
            if (selectedOutlet.name && selectedOutlet.name.length){
                DDMerchantDetailAttributesM * attribM = [[DDMerchantDetailAttributesM alloc] init];
                attribM.title = @"Address".localized;
                attribM.value = selectedOutlet.name;
                [detail_attributes addObject:attribM];
            }
            
            if (selectedOutlet.neighborhood && selectedOutlet.neighborhood.length){
                DDMerchantDetailAttributesM * attribM = [[DDMerchantDetailAttributesM alloc] init];
                attribM.title = @"Area".localized;
                attribM.value = selectedOutlet.neighborhood;
                [detail_attributes addObject:attribM];
            }
            
            if (selectedOutlet.lat && selectedOutlet.lng){
                NSString *dist = [[DDLocationsManager shared] distanceFromLatidute:selectedOutlet.lat longitude:selectedOutlet.lng];
                if (dist && dist.length){
                    DDMerchantDetailAttributesM * attribM = [[DDMerchantDetailAttributesM alloc] init];
                    attribM.title = @"Distance".localized;
                    attribM.value = [[DDLocationsManager shared] distanceFromLatidute:selectedOutlet.lat longitude:selectedOutlet.lng];
                    [detail_attributes addObject:attribM];
                }
            }
           
            if(merchantData.digital_section && merchantData.digital_section.length){
                NSString* type = @"Type".localized;
                if([selectedOutlet.category isEqualToString:kHotelsWorldwide]){
                    type =  @"Rating";
                }
                DDMerchantDetailAttributesM * attribM = [[DDMerchantDetailAttributesM alloc] init];
                attribM.title = type.localized;
                attribM.value = merchantData.digital_section;
                [detail_attributes addObject:attribM];
            }
            
            if(merchantData.cuisine && merchantData.cuisine.length){
                DDMerchantDetailAttributesM * attribM = [[DDMerchantDetailAttributesM alloc] init];
                attribM.title = @"Cuisine".localized;
                attribM.value = merchantData.cuisine;
                [detail_attributes addObject:attribM];
            }
            
            if(merchantData.opening_hours && merchantData.opening_hours.length){
                DDMerchantDetailAttributesM * attribM = [[DDMerchantDetailAttributesM alloc] init];
                attribM.title = @"Opening time".localized;
                attribM.value = merchantData.opening_hours;
                [detail_attributes addObject:attribM];
            }
            
            section.detail_attributes = detail_attributes.mutableCopy;
            break;
        }
    }
}

- (void) reloadTableView {
    [self.tblView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tblView reloadData];
    });
}

#pragma mark - UI-TABLE-VIEW

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return sections.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    DDMerchantDetailSectionM *sectionModel =  sections[section];
    if (sectionModel.getType == DDMerchantSectionModules) {
        if (modules.count > 0){
             return 17;
        }else{
             return 0;
        }
    }else if (sectionModel.getType == DDMerchantSectionProducts && productsArray.count <= 0){
        return 0.01;
    }
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DDMerchantDetailSectionM *sectionModel =  sections[section];

    if (sectionModel.getType == DDMerchantSectionModules) {
        return modules.count;
    }else if (sectionModel.getType == DDMerchantSectionOffers) {
        if (sectionModel.is_expanded != nil && sectionModel.is_expanded.boolValue){
            return 1;
        }
    }
    else if (sectionModel.getType == DDMerchantSectionPreviewOffers) {
        if (sectionModel.is_expanded != nil && sectionModel.is_expanded.boolValue){
            return 1;
        }
    }
    else if (sectionModel.getType == DDMerchantSectionProducts) {
        return productsArray.count;
    }
    else if (sectionModel.getType == DDMerchantSectionNormalDeliveryOffers) {
        return sectionModel.menus_old_delivery.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v= [[UIView alloc] initWithFrame:CGRectZero];
    return v;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    DDMerchantDetailSectionM *sectionModel =  sections[section];
    
    if (sectionModel.getType == DDMerchantSectionManuButtons) {
        DDMerchantSectionManusHFV *view = [self.tblView dequeueReusableHeaderFooterViewWithIdentifier:DDMerchantDetailSectionManusHFV];
        [view setData:sectionModel];
        view.delegate = self;
        return view;
    }
    else if (sectionModel.getType == DDMerchantSectionOutletLocation) {
        DDMerchantSectionOutletLocationHFV *view = [self.tblView dequeueReusableHeaderFooterViewWithIdentifier:DDMerchantDetailSectionOutletLocationHFV];
        [view setData:selectedOutlet];
        view.delegate = self;
        return view;
    }
    else if (sectionModel.getType == DDMerchantSectionOffers) {
        DDMerchantSectionOffersHFV *view = [self.tblView dequeueReusableHeaderFooterViewWithIdentifier:DDMerchantDetailSectionOffersHFV];
        [view setData:sectionModel];
        view.delegate = self;
        return view;
    }
    else if (sectionModel.getType == DDMerchantSectionPreviewOffers) {
        DDMerchantSectionOffersHFV *view = [self.tblView dequeueReusableHeaderFooterViewWithIdentifier:DDMerchantDetailSectionOffersHFV];
        [view setData:sectionModel];
        view.delegate = self;
        return view;
    }
    else if (sectionModel.getType == DDMerchantSectionLockedOffers) {
        DDMerchantSectionLockedOffersHFV *view = [self.tblView dequeueReusableHeaderFooterViewWithIdentifier:DDMerchantDetailSectionLockedOffersHFV];
        [view setData:sectionModel];
        view.callBackShowAllLlockeOffers = ^{
            DDMerchantOffersLocalDataM *model =  [[DDMerchantOffersLocalDataM alloc] init];
            model.merchant = self->merchantData;
            model.selectedOutlet = self->selectedOutlet;
            model.section = sectionModel;
            [[DDOutletsUIManager shared] openMerchantLockeOffersView:self withLockOffersSectionAndModel:model onCompletion:^{
            }];
        };
        return view;
    }
    else if (sectionModel.getType == DDMerchantSectionAmenities) {
        DDMerchantSectionAmenitiesHFV *view = [self.tblView dequeueReusableHeaderFooterViewWithIdentifier:DDMerchantDetailAmenitiesSectionCell];
       view.callBackShowAll = ^(NSArray * _Nonnull attributesArray) {
           if (attributesArray.count > 0) {
               [DDOutletsUIManager.shared openAmenitiesDetail:self withAmenitiesArray:attributesArray onCompletion:^{
               }];
           }
       };
       [view setData:sectionModel];
       return view;
    }
    else if (sectionModel.getType == DDMerchantSectionOutletDetail){
        DDMerchantSectionOutletDetailHFV *view = [self.tblView dequeueReusableHeaderFooterViewWithIdentifier:DDMerchantDetailSectionCell];
        [view setData:sectionModel];
        view.delegate = self;
        return view;
    }
    else if (sectionModel.getType == DDMerchantSectionProducts){
        if (productsArray.count > 0){
            DDMerchantSectionProductsHFV *view = [self.tblView dequeueReusableHeaderFooterViewWithIdentifier:DDMerchantDetailSectionProductsHFV];
            [view setData:sectionModel];
            return view;
        }else{
            UIView *v= [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tblView.frame.size.width, 0.01)];
            return v;
        }
    }
    else if (sectionModel.getType == DDMerchantSectionOnlineOfferHistory){
        DDMerchantSectionOnlineOffersHFV *view = [self.tblView dequeueReusableHeaderFooterViewWithIdentifier:DDMerchantDetailSectionOnlineOffersHFV];
        [view setData:sectionModel];
        view.callBackSeeAll = ^{
            if (![DDUserManager shared].isLoggedIn){
                [self showLoginViewController:^(BOOL isLoggedIn) {
                    if (isLoggedIn){
                        [[DDOutletsUIManager shared] openMerchantBaseOnlineOffersHistory:self withLockOffersSectionAndModel:self->merchantData.merchant_id.stringValue onCompletion:^{
                        }];
                    }
                }];
            }else {
                [[DDOutletsUIManager shared] openMerchantBaseOnlineOffersHistory:self withLockOffersSectionAndModel:self->merchantData.merchant_id.stringValue onCompletion:^{
                }];
            }
        };
        return view;
    }
    else if (sectionModel.getType == DDMerchantSectionNormalDeliveryOffers){
        DDMerchantSectionOffersHFV *view = [self.tblView dequeueReusableHeaderFooterViewWithIdentifier:DDMerchantDetailSectionOffersHFV];
        [view setData:sectionModel];
        return view;
    }
    else{
        UIView *v= [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tblView.frame.size.width, 0.01)];
        return v;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DDMerchantDetailSectionM *sectionModel = sections[indexPath.section];

    if (sectionModel.getType == DDMerchantSectionModules) {
        DDMerchantDetailModulesTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDMerchantDetailModulesCell];
          [cell setData:[modules objectAtIndex:indexPath.row]];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (sectionModel.getType == DDMerchantSectionOffers) {
        DDMerchantDetailOffersTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDMerchantDetailOffersTVCell];
        offersCellViewModel.section = sectionModel;
        [cell setData:offersCellViewModel];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (sectionModel.getType == DDMerchantSectionPreviewOffers) {
        DDMerchantDetailOffersTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDMerchantDetailOffersTVCell];
        offersCellViewModel.section = sectionModel;
        [cell setData:offersCellViewModel];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (sectionModel.getType == DDMerchantSectionProducts) {
        DDMDProductTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDMDProductTVCell];
        DDProfileSectionListM *product = productsArray[indexPath.row];
        [cell setData:product];
        if (indexPath.row == productsArray.count -1){
            cell.lineView.hidden =  NO;
        }else{
            cell.lineView.hidden =  YES;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (sectionModel.getType == DDMerchantSectionNormalDeliveryOffers){
        DDNormalDeliveryMenuTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDNormalDeliveryMenuTVCell];
        [cell setData:sectionModel.menus_old_delivery[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellDETAIL"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDMerchantDetailSectionM *sectionModel =  sections[indexPath.section];
    if (sectionModel.getType  == DDMerchantSectionProducts){
        if (indexPath.row < productsArray.count){
            DDProfileSectionListM *product = productsArray[indexPath.row];
            if (product.deeplink && product.deeplink.length){
                [DDWebManager.shared openURL:product.deeplink.noRequireRefreshGlobally title:@"" onController:self];
            }
        }
    }
}

#pragma mark - UI-SCROLL-VIEW

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tblView){
        tableViewScrollContentOffset = scrollView.contentOffset.y;
        [self changeNavigationBar:scrollView.contentOffset.y];
    }
}

- (void) changeNavigationBar : (CGFloat) yOffset {
    CGFloat maxThreshold = tableHeaderView.frame.size.height/1.75;
    CGFloat overlayColorAlpha = yOffset/maxThreshold;
    [tableHeaderView changeOverlayColorByAlpha:overlayColorAlpha];
    if (overlayColorAlpha >= 1) {
        self.navigationItem.title = headerModel.merchant.name;
        [self setNavigationBarBackgroundColor:OUTLETS_THEME.app_theme.colorValue];
    }else {
        self.navigationItem.title = @"";
        [self setTransparentNavigationBar];
        self.navigationController.navigationBar.barTintColor = UIColor.clearColor;
        [self setNavigationBarBackgroundColor:UIColor.clearColor];
    }
}

#pragma mark - header VIEW Actions

#pragma mark - Merchant section Delegates

// section of favourities, pings, menu etc...
-(void)didTapMenuItem:(DDMerchantMenuButtonM *)button {
    if ([button.type  isEqual: DDFavouriteBtn]){
        // call favourite api to set unset
        if (![DDUserManager shared].isLoggedIn){
            [self showLoginViewController:^(BOOL isLoggedIn) {
                if (isLoggedIn){
                    [self markFavourite];
                }
            }];
        }else{
            [self markFavourite];
        }
    }else if ([button.type  isEqual: DDPingBtn]){
        // pings module will get control with pingable oofers
        if (![DDUserManager shared].isLoggedIn){
            [self showLoginViewController:^(BOOL isLoggedIn) {
                if (isLoggedIn){
                    [self openPingsShareView];
                }
            }];
        }else{
            [self openPingsShareView];
        }
    }else if ([button.type  isEqual: DDMenuBtn]){
        // open menu
        if (button.value && button.value.length){
            [DDWebManager.shared openURL:button.value.noRequireRefreshGlobally title:selectedOutlet.name onController:self];
        }
    }else if ([button.type  isEqual: DDCatalogueBtn]){
        // it is also being handled with DDMenuBtn
        // open catalogue
        if (button.value && button.value.length){
            [DDWebManager.shared openURL:button.value.noRequireRefreshGlobally title:selectedOutlet.name onController:self];
        }
    }else{
        
    }
}

- (void)  markFavourite {
    [[DDFavouritesManager shared] markFavoritie:@[merchantData.merchant_id] isFavourite:!merchantData.is_favourite.boolValue needFavRefresh:YES completion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (model.success.boolValue) {
            [self loadMerchantDetail:YES];
        }
    }];
}

- (void) openPingsShareView {
    DDMerchantOffersLocalDataM *model = [[DDMerchantOffersLocalDataM alloc] init];
    model.merchant = merchantData;
    model.selectedOutlet = selectedOutlet;
    for (DDMerchantDetailSectionM *section in sections){
        if (section.getType == DDMerchantSectionOffers){
            model.section = section;
            break;
        }
    }
    [[DDOutletsUIManager shared] openPingShareVCFrom:self withOfferViewModel:model andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        if ([identifier isEqualToString:PING_SDD_CALLBACK_MESSAGE]){
            [self loadMerchantDetail:NO];
        }
    }];
}

// section of outlet location change
- (void)didTapAreYouHereButton {
    DDMerchantOutletLocationViewM *locationM = [[DDMerchantOutletLocationViewM alloc] init];
    locationM.merchant = merchantData;
    locationM.selectedOutlet = selectedOutlet;
    locationM.outletArray = [[NSMutableArray<DDOutletM> alloc] initWithArray: merchantData.outlets];
    [[DDOutletsUIManager shared] openMerchantOutlets:self withViewModel:locationM onCompletion:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:TRUE completion:nil];
        DDOutletM *outlet = (DDOutletM*)data;
        if (outlet){
            if (self->selectedOutlet.outlet_id != outlet.outlet_id) {
                [self setSelectedOutletAndOtherViewModels:outlet];
            }
        }
    }];
}

// section of Module Navigations
- (void)didTapOnModuleItem:(NSInteger)index {
    DDMerchantModuleNavigation * tappedItem;
    for (DDMerchantDetailSectionM *section in sections){
        if (section.getType == DDMerchantSectionModules){
            if (index < section.modules_navigations.count) {
                 tappedItem  = section.modules_navigations[index];
            }
            break;
        }
    }
    if (tappedItem){
        if (![DDUserManager shared].isLoggedIn){
            [self showLoginViewController:^(BOOL isLoggedIn) {
                if (isLoggedIn){
                    [self moduleNavigationItemTapHandling:tappedItem];
                }
            }];
        }else{
            [self moduleNavigationItemTapHandling:tappedItem];
        }
    }
}

- (void) moduleNavigationItemTapHandling : (DDMerchantModuleNavigation*)item {
    if (item.getType == DDMerchantModuleNavigationCashlessDelivery){
        [self openCashlessMerchantDetailVCForDelivery :item];
    }
    else  if (item.getType == DDMerchantModuleNavigationCashlessTakeaway){
        [self openCashlessMerchantDetailVCForTakeaway :item];
    }
    else if (item.getType == DDMerchantModuleNavigationBookATable){
        if (selectedOutlet.bat_section && DDCAppConfigManager.shared.api_config.BOOK_A_TABLE_URL && DDCAppConfigManager.shared.api_config.BOOK_A_TABLE_URL.length > 0){
            DDUIWebViewVM *vm = [DDUIWebViewVM new];
            vm.title = selectedOutlet.bat_section.bat_webview_title;
            vm.webType = DDUIWebViewTypeBookATable;
            [DDWebManager.shared openWeb:vm onController:self];
        }
    }
    else if (item.getType == DDMerchantModuleNavigationCinemaBooking){
        if (selectedOutlet.cinema_booking_info && DDCAppConfigManager.shared.api_config.CINEMA_URL && DDCAppConfigManager.shared.api_config.CINEMA_URL.length > 0){
            DDUIWebViewVM *vm = [DDUIWebViewVM new];
            vm.params = [self cinemaCart].toDictionary.mutableCopy;
            vm.title = selectedOutlet.bat_section.bat_webview_title;
            vm.webType = DDUIWebViewTypeCinema;
            __weak typeof(self) weakSelf = self;
            vm.webCompletion = ^(NSMutableDictionary * _Nullable params, UIViewController * _Nullable controller) {
                [weakSelf loadMerchantDetail:YES];
            };
            [DDWebManager.shared openWeb:vm onController:self];
        }
    }
    else if (item.getType == DDMerchantModuleNavigationDelivery){
        [self showMerchantNormalDeliveryView];
    }
}

- (void) openCashlessMerchantDetailVCForDelivery : (DDMerchantModuleNavigation*)item {
    DDCashlessRequestM *req = [self getCashlessRequestObject:item];
    req.is_delivery_tab_selected = @(YES);
    [[DDOutletsUIManager shared] showCashlessMerchantDetailsFrom:self withOutlet:req andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
    }];
}

- (void) openCashlessMerchantDetailVCForTakeaway : (DDMerchantModuleNavigation*)item {
    DDCashlessRequestM *req = [self getCashlessRequestObject:item];
    req.is_delivery_tab_selected = @(NO);
    [[DDOutletsUIManager shared] showCashlessMerchantDetailsFrom:self withOutlet:req andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
    }];
}

- (DDCashlessRequestM*)getCashlessRequestObject : (DDMerchantModuleNavigation*)item {
    DDCashlessRequestM *req = [DDCashlessRequestM new];
    req.merchant_id = merchantData.merchant_id;
    req.outlet_id = selectedOutlet.outlet_id;
    req.cashless_delivery_param = item.extra_params;
    req.is_new_order_status_flow = @(YES);
    return req;
}

- (DDCashlessCart *)cinemaCart {
    DDCashlessCart *cart = selectedOutlet.cinema_booking_info.cartObject;
    NSString *encryptedP = [DDEncryptionManager.shared encryptDictionaryIntoString:cart.__p_decrypted.mutableCopy];
    NSString *encryptedOrder = [DDEncryptionManager.shared encryptDictionaryIntoString:cart.__dts_decrypted.mutableCopy];
    
    cart.__p = encryptedP;
    cart.__dts = encryptedOrder;
    return cart;
}
- (void) showMerchantNormalDeliveryView {
    isNormalDeliveryViewShowing = !isNormalDeliveryViewShowing;
    tableHeaderView = nil;
    [self setUpTableHeaderViewWithAutolayouts];
    [self setViewModels];
    [self reloadTableView];
//    [[DDCustomAppAnalytics defaultAnalytics]googleTagManagerPushDatawithScreenName:[NSString stringWithFormat:@"%@ - %@ - %@ - %@ - delivery",[[DDUserManager sharedManager] getSelectedLocation].name,self.merchant.category?self.merchant.category:@"",_selectedOutlet.merchant.name?_selectedOutlet.merchant.name:@"",_selectedOutlet.name?_selectedOutlet.name:@""] event:@"view_delivery"];
//    [[DDCustomAppAnalytics defaultAnalytics]trackisNewScreen:NO parameters:@{@"current_screen":@"Merchant Detail",@"action":@"click_view_delivery_offer",@"merchant_id":self.merchant.merchant_id,@"sub_category":self.selectedOutlet.sub_categories_analytics ? self.selectedOutlet.sub_categories_analytics : @""}];
}

// section of offers expand collaps handling
-(void)didTapExpandCollapsButtonFromOfferSection:(NSString*)sectionID {
    for (DDMerchantDetailSectionM *section in sections){
        if ([section.identifier isEqualToString:sectionID]){
            section.is_expanded = section.is_expanded.boolValue ? @(0) : @(1);
            break;
        }
    }
    [self.tblView layoutIfNeeded];
    [self.tblView reloadData];
}

// section of outlet detail expand collaps
- (void)refreshMainTableViewFromOutletDetailSection {
    [self.tblView layoutIfNeeded];
    [self reloadTableView];
}

// section of offers tapped

- (void)didTapOfferItem:(DDMerchantOffersLocalDataM *)offerViewModel {
    [self proceedToRedeemAfterValidation:^(BOOL success) {
        if (success){
            [self openOfferForRedemption:offerViewModel];
        }
    }];
}

- (void)openOfferForRedemption : (DDMerchantOffersLocalDataM*)offerViewModel {
    
    [DDOutletsManager.shared checkAndShowRedemption:offerViewModel completion:^(DDMOfferRedemptionType responseType, NSString * _Nullable alertTitle, NSString * _Nullable alertMsg) {
        switch (responseType) {
            case DDMOfferRedemptionTypeRedeemable:
                [self openRedemptionProcessVCWithData:offerViewModel];
                break;
            case DDMOfferRedemptionTypeRedeemableWithLocation:
            {
                if (![[DDLocationsManager shared] isLocationServicesEnable]){
                    [[DDLocationsManager shared] showSettingAlert:^(bool isSuccess) {}];
                }else {
                    [self openRedemptionProcessVCWithData:offerViewModel];
                }
            }
                break;
            case DDMOfferRedemptionTypeOutletChangeAlert:
                [self showChangeOutletAlert:offerViewModel];
                break;
            case DDMOfferRedemptionTypeBuyBack:
            {
                [self performBuyBack:offerViewModel];
            }
                break;
            case DDMOfferRedemptionTypeUnknown:
                [DDAlertUtils showOkAlertWithTitle:alertTitle subtitle:alertMsg completion:nil];
                break;
        }
    }];
}

- (void) performBuyBack  : (DDMerchantOffersLocalDataM*) offerViewModel {
    NSString *outletWithOffer = [NSString stringWithFormat:@"%@ - %@",offerViewModel.selectedOutlet.name, offerViewModel.offerToDisplay.name];
    NSString *detail = [NSString stringWithFormat:@"%@",DDBuyBackConfirmationMessageDetail];
    detail = [detail stringByReplacingOccurrencesOfString:DDBuyBackConfirmationBalance withString:[offerViewModel.merchant.smiles_total_balance stringValue]];
    detail = [detail stringByReplacingOccurrencesOfString:DDBuyBackConfirmationOffer withString:outletWithOffer];
    NSString *button = [NSString stringWithFormat:@"Buy Back for %@ Smiles",offerViewModel.offerToDisplay.smiles_burn_value];
    __weak typeof(self) weakSelf = self;
    [DDAlertUtils showAlertWithTitle:[DDBuyBackConfirmationMessageTitle localized] subtitle:detail.localized buttonNames:@[button,CANCEL] onClick:^(int index) {
        if (index == 0){
            [weakSelf performBuyBackWithUserConfirmation :offerViewModel];
        }
    }];
}

- (void) performBuyBackWithUserConfirmation  : (DDMerchantOffersLocalDataM*) offerViewModel  {
    [[DDRedemptionsManager shared] sendTopupOfferRequest:offerViewModel showLoader:YES andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil){
            DDRedemptionBuyBackApiM *apiM = (DDRedemptionBuyBackApiM*)model;
            if (apiM.data.success && apiM.data.success.boolValue) {
                [DDAlertUtils showOkAlertWithTitle:@"" subtitle:apiM.data.message completion:nil];
                [self loadMerchantDetail:YES];
            }else {
                NSString  *message =  apiM.data.message ? apiM.data.message :  model.message;
                [DDAlertUtils showOkAlertWithTitle:@"" subtitle:message completion:nil];
            }
        }else {
            [DDAlertUtils showOkAlertWithTitle:@"" subtitle:error.localizedDescription completion:nil];
        }
    }];
}

-(void)showChangeOutletAlert:(DDMerchantOffersLocalDataM*)offerViewModel{
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:offerViewModel.selectedOutlet.name
                                                                  message:[NSString stringWithFormat:@"%s",DDMerchantDOutletChangeMessage].localized
                                                           preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* changeOutlet = [UIAlertAction actionWithTitle:@"Change Outlet".localized
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action)
                                   {
    }];
    
    UIAlertAction* continueSelection = [UIAlertAction actionWithTitle:@"Continue".localized
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action)
                                        {
        //Open redemption pin entry anyway
        [self openRedemptionProcessVCWithData:offerViewModel];
    }];
    
    [alert addAction:changeOutlet];
    [alert addAction:continueSelection];
    
    [[UIApplication topMostController] presentViewController:alert animated:YES completion:nil];
}

- (void) openRedemptionProcessVCWithData : (DDMerchantOffersLocalDataM*)offerViewModel {
    [[DDOutletsUIManager shared] openRedemptionVCFrom:self withOfferViewModel:offerViewModel andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        if ([identifier isEqualToString:REDEMPTION_PROCESS_CALLBACK_MESSAGE]){
            [self loadMerchantDetail:NO];
            if ([DDUserManager.shared.currentUser isTrialUser]){
               [UIApplication refreshAppWithParams:nil];
            }
        }
    }];
}

-(void) showLoginViewController:(void (^)(BOOL isLoggedIn))completion{
    __weak __typeof(self) weakSElf = self;
    [DDAuthUIManager showLoginScreenOnController:self WithcallBack:^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:YES completion:nil];
        if ([DDUserManager shared].isLoggedIn) {
            [weakSElf loadProductsData:YES];
            completion(YES);
            self.navigation.routerModel.callback(@"", nil, self);
        }else {
            completion(NO);
        }
    }];
}

-(void)proceedToRedeemAfterValidation:(void (^)(BOOL success))completion {
    if ([DDUserManager shared].isLoggedIn){
        if ([DDUserManager shared].currentUser.isDemographicsUpdated){
            completion(YES);
        }else{
            [self validateUserDemographics:completion];
        }
    }else{
        [self showLoginViewController:^(BOOL isLoggedIn) {
            if (isLoggedIn){
                if ([DDUserManager shared].currentUser.isDemographicsUpdated){
                    completion(YES);
                }else{
                    [self validateUserDemographics:completion];
                }
            }else{
                completion(NO);
            }
        }];
    }
}

- (void) validateUserDemographics :(void (^)(BOOL success))completion {
    [[DDOutletsUIManager shared] showDemographicsOnController:self WithcallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        if ([DDUserManager shared].currentUser.isDemographicsUpdated){
            completion(YES);
        }else{
            completion(NO);
        }
    }];
}

@end
