//
//  DDCashlessLocationDetailsVC.m
//  DDLocationsUI
//
//  Created by Awais Shahid on 17/02/2020.
//

#import "DDCashlessLocationDetailsVC.h"
#import "DDCashlessLocationTypeCVC.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "DDAuth.h"
@interface DDCashlessLocationDetailsVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *pinLocationLbl;

@property (weak, nonatomic) IBOutlet UILabel *pinTitle;
@property (weak, nonatomic) IBOutlet UILabel *pinSubtitle;
@property (weak, nonatomic) IBOutlet UIImageView *pinImageView;

@property (weak, nonatomic) IBOutlet UILabel *flatLabel;
@property (weak, nonatomic) IBOutlet UITextField *flatTF;

@property (weak, nonatomic) IBOutlet UILabel *buildingLabel;
@property (weak, nonatomic) IBOutlet UITextField *buildingTF;

@property (weak, nonatomic) IBOutlet UILabel *streetLabel;
@property (weak, nonatomic) IBOutlet UITextField *streetTF;

@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UITextField *areaTF;

@property (weak, nonatomic) IBOutlet UILabel *additionalLabel;
@property (weak, nonatomic) IBOutlet UITextField *additionalTF;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *bottomSaveBtn;

@property (strong, nonatomic) DDDeliveryAddressM *deliveryAddressM;
@property (strong, nonatomic) DDDeliveryAddressM *prevAddressM;

@end

@implementation DDCashlessLocationDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarHidden:YES animated:NO];
    DDDeliveryAddressM *data = (DDDeliveryAddressM*)self.navigation.routerModel.data;
    if (data==nil) {
        [self goBackWithCompletion:nil];
        return;
    }
    self.deliveryAddressM = data;
    self.prevAddressM = data;
    [self setdata];
    [self setupCollectionView];
}

-(void)reSetdata {
    
}

-(void)setdata {
    [self reSetdata];
    self.pinSubtitle.text = self.deliveryAddressM.area;
    self.areaTF.text = self.deliveryAddressM.area;
    self.streetTF.text = self.deliveryAddressM.street;
    self.flatTF.text = self.deliveryAddressM.flat;
    self.buildingTF.text = self.deliveryAddressM.building;
}

#pragma mark - Overriden
-(BOOL)isKeyboardOpen {
    if (self.flatTF.isFirstResponder || self.buildingTF.isFirstResponder || self.streetTF.isFirstResponder || self.areaTF.isFirstResponder || self.additionalTF.isFirstResponder) {
        return YES;
    }
    return NO;
}
- (void)designUI {
    
    self.flatTF.delegate = self;
    self.buildingTF.delegate = self;
    self.streetTF.delegate = self;
    self.areaTF.delegate = self;
    self.additionalTF.delegate = self;
    
    
    self.title = K_CASHLESS_ADD_NEW_LOCATION.localized;
    
    [self.pinImageView loadImageWithString:@"ic-pin.png" forClass:self.class];
    
    self.pinTitle.font = [UIFont DDSemiBoldFont:15];
    self.pinSubtitle.font = [UIFont DDRegularFont:12];
    self.pinTitle.textColor = LOCATION_THEME.text_black.colorValue;
    self.pinSubtitle.textColor = LOCATION_THEME.text_grey_199.colorValue;
    
    self.flatLabel.font = [UIFont DDRegularFont:13];
    self.flatTF.font = [UIFont DDRegularFont:13];
    self.buildingLabel.font = [UIFont DDRegularFont:13];
    self.buildingTF.font = [UIFont DDRegularFont:13];
    self.streetLabel.font = [UIFont DDRegularFont:13];
    self.streetTF.font = [UIFont DDRegularFont:13];
    self.areaLabel.font = [UIFont DDRegularFont:13];
    self.areaTF.font = [UIFont DDRegularFont:13];
    self.additionalLabel.font = [UIFont DDRegularFont:13];
    self.additionalTF.font = [UIFont DDRegularFont:13];
    
    self.flatLabel.textColor = LOCATION_THEME.text_black.colorValue;
    self.flatTF.textColor = LOCATION_THEME.text_black.colorValue;
    self.buildingLabel.textColor = LOCATION_THEME.text_black.colorValue;
    self.buildingTF.textColor = LOCATION_THEME.text_black.colorValue;
    self.streetLabel.textColor = LOCATION_THEME.text_black.colorValue;
    self.streetTF.textColor = LOCATION_THEME.text_black.colorValue;
    self.areaLabel.textColor = LOCATION_THEME.text_black.colorValue;
    self.areaTF.textColor = LOCATION_THEME.text_black.colorValue;
    self.additionalLabel.textColor = LOCATION_THEME.text_black.colorValue;
    self.additionalTF.textColor = LOCATION_THEME.text_black.colorValue;
    
    self.flatTF.placeholder = PLACEHOLDER_FLAT.localized;
    self.buildingTF.placeholder = PLACEHOLDER_VILLA.localized;
    self.streetTF.placeholder = PLACEHOLDER_STREET.localized;
    self.areaTF.placeholder = PLACEHOLDER_AREA.localized;
    self.additionalTF.placeholder = PLACEHOLDER_ADDITION_INFO.localized;
    self.pinLocationLbl.text = @"Pin Location".localized;
    self.flatLabel.text = TITLE_FLAT.localized;
    self.buildingLabel.text = TITLE_VILLA.localized;
    self.streetLabel.text = TITLE_STREET.localized;
    self.areaLabel.text = TITLE_AREA.localized;
    self.additionalLabel.text = TITLE_ADDITION_INFO.localized;
    
    
    self.bottomSaveBtn.cornerR = 12;
    self.bottomSaveBtn.clipsToBounds = YES;
    [self.bottomSaveBtn setTitle:SAVE.localized forState:UIControlStateNormal];
    [self.bottomSaveBtn setTitleColor: LOCATION_THEME.text_white.colorValue forState:UIControlStateNormal];
    [self.bottomSaveBtn.titleLabel setFont:[UIFont DDBoldFont:17]];
}

#pragma mark - Collection view

-(void)setupCollectionView {
    NSArray *cells = @[CashlessLocationTypeCVC];
    [self.collectionView registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView reloadData];
    [self.collectionView setHidden:(DDLocationsManager.shared.locationPickerPermission!= DDDeliveryLocationPickerPermissionSave)];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return DDLocationsManager.shared.cashlessDeliveryLocationTags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCashlessLocationTypeCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CashlessLocationTypeCVC forIndexPath:indexPath];
    DDLocationTagsM *tag = [DDLocationsManager.shared.cashlessDeliveryLocationTags objectAtIndex:indexPath.item];
    tag.is_selected = @(self.deliveryAddressM.tag.tag_id == tag.tag_id);
    [cell setData:tag];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DDLocationTagsM *tag = [DDLocationsManager.shared.cashlessDeliveryLocationTags objectAtIndex:indexPath.item];
    __weak typeof (self) weakSelf = self;
    if (tag.isCustom) {
        [DDAlertUtils.shared showNameInputAlertWithCompletion:^(NSString * _Nullable newname) {
            if (newname.length) {
                DDLocationTagsM* newTag = [DDLocationTagsM new];
                newTag.tag_name = newname;
                newTag.tag_id = tag.tag_id;
                newTag.allow_custom_name = tag.allow_custom_name;
                weakSelf.deliveryAddressM.tag = newTag;
                [collectionView reloadData];
            }
        }];
    }
    else {
        self.deliveryAddressM.tag = tag;
        [collectionView reloadData];
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDLocationTagsM *tag = [DDLocationsManager.shared.cashlessDeliveryLocationTags objectAtIndex:indexPath.item];
    CGFloat w = tag.tag_name.getWidt + 30;
    return CGSizeMake(w, collectionView.frame.size.height);
}

#pragma mark - Other

- (IBAction)swicthChanged:(UISwitch*)sender {
    self.collectionView.hidden = !sender.isOn;
}

- (IBAction)bottomSaveBtnTapped:(UIButton *)sender {
    [self saveLocations];
    
}
-(void)saveLocations {
        
    NSString *apt = self.flatTF.text;
    NSString *street = self.streetTF.text;
    NSString *area = self.areaTF.text;
    NSString *buiding = self.buildingTF.text;
    NSString *instruction = self.additionalTF.text;

    if (apt.length == 0 || buiding.length == 0 || area.length == 0) {
        [DDAlertUtils showOkAlertWithTitle:@"" subtitle:K_LOCATIONS_INPUT_ERROR completion:nil];
        return;
    }
        
    BOOL alreadyFound = false;
    if (DDUserManager.shared.isLoggedIn) {
        for (DDDeliveryAddressM *model in DDLocationsManager.shared.cashlessDeliveryLocations) {
            if (model.isCurrentLocation){
                if (apt && [apt.lowercaseString isEqualToString:CURRDD_LOCATION.lowercaseString]){
                    alreadyFound = YES;
                    break;
                }
                if (self.deliveryAddressM.tag.tag_name.length && [self.deliveryAddressM.tag.tag_name.lowercaseString isEqualToString:CURRDD_LOCATION.lowercaseString]){
                    alreadyFound = YES;
                    break;
                }
            } else {
                if ([apt.lowercaseString isEqualToString:model.getTitle.lowercaseString] && !model.isTemporaryLocation){
                    alreadyFound = YES;
                    break;
                }
            }
        }
    }
    
    
    if (alreadyFound) {
        [DDAlertUtils showOkAlertWithTitle:@"" subtitle:@"Address already added with this title".localized completion:nil];
        return;
    }
        
    self.deliveryAddressM.building = buiding;
    self.deliveryAddressM.area = area;
    self.deliveryAddressM.street = street;
    self.deliveryAddressM.flat = apt;
    self.deliveryAddressM.special_instructions = instruction;
    
    self.deliveryAddressM.is_temporary_location = @(DDLocationsManager.shared.locationPickerPermission != DDDeliveryLocationPickerPermissionSave);
        
    if (self.deliveryAddressM.isTemporaryLocation) {
        if (DDLocationsManager.shared.locationPickerPermission != DDDeliveryLocationPickerPermissionNotSetNotSave) {
            DDLocationsManager.shared.selectedCashlessDeliveryLocation = self.deliveryAddressM;
        }
        [self goBackWithCompletion:^{
            [self.navigation.routerModel sendDataCallback:nil withData:self.deliveryAddressM withController:self];
        }];
    }
    else {
        [self sendApiCallForDeliveryLocation];
    }
}
-(void)sendApiCallForDeliveryLocation {
    
    DDCashlessLocationsRequestM *requestModel = [DDCashlessLocationsRequestM new];

    NSMutableDictionary *params = [self.deliveryAddressM toDictionaryValue].mutableCopy;
    params[@"home_office_address"] = self.deliveryAddressM.building;
    params[@"title"] = self.deliveryAddressM.tag.tag_name;
    requestModel.custom_parameters = params;
    if (self.deliveryAddressM.delivery_location_id == nil) {
        [self saveDeliveryAddressOnServerWithReq:requestModel];
    }
    else {
        requestModel.delivery_location_id = self.deliveryAddressM.delivery_location_id;
        [self updateDeliveryAddressOnServerWithReq:requestModel];
    }
    
}

-(void)saveDeliveryAddressOnServerWithReq:(DDCashlessLocationsRequestM*)requestModel {
    __weak typeof(self) weakSelf = self;
    [DDLocationsManager.shared addCashlessDeliveryLocationWithRequest:requestModel callBack:^(DDDeliveryLocationsAPI * _Nullable model, NSError * _Nullable error) {
        [weakSelf sendCallBackWithData:model error:error];
    }];
    
}

-(void)updateDeliveryAddressOnServerWithReq:(DDCashlessLocationsRequestM*)requestModel {
    __weak typeof(self) weakSelf = self;
    [DDLocationsManager.shared updateCashlessDeliveryLocationWithRequest:requestModel callBack:^(DDDeliveryLocationsAPI * _Nullable model, NSError * _Nullable error) {
        [weakSelf sendCallBackWithData:model error:error];
    }];
    
}

-(void)sendCallBackWithData:(DDDeliveryLocationsAPI * _Nullable)model error:(NSError * _Nullable)error {
    if (model) {
        if (model.successfulApi) {
            DDDeliveryAddressM *temp = model.data.delivery_locations.lastObject;
            for (DDDeliveryAddressM *adr in model.data.delivery_locations) {
                BOOL matched = [adr.tag.tag_id isEqualToNumber:self.deliveryAddressM.tag.tag_id] && [adr.getTitle  isEqualToString:self.deliveryAddressM.getTitle];
                if (matched) {
                    temp = adr;
                    break;
                }
            }
            NSMutableArray *arr = [NSMutableArray new];
            for (DDDeliveryAddressM *adr in DDLocationsManager.shared.cashlessDeliveryLocations) {
                if (temp != nil && temp.delivery_location_id.integerValue == adr.delivery_location_id.integerValue) {
                    [arr addObject:temp];
                }else {
                    [arr addObject:adr];
                }
            }
            DDLocationsManager.shared.cashlessDeliveryLocations = arr;
            DDLocationsManager.shared.selectedCashlessDeliveryLocation = temp;
            [self goBackWithCompletion:^{
                [self.navigation.routerModel sendDataCallback:nil withData:self.deliveryAddressM withController:self];
            }];
        }
        else {
            [DDAlertUtils showOkAlertWithTitle:model.title subtitle:model.message completion:nil];
        }
    }
    else  {
        [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.navigationController reloadInputViews];
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.navigationController reloadInputViews];
}
-(CGFloat)dragableHeight {
    if ([self isKeyboardOpen]) {
        return UIScreen.mainScreen.bounds.size.height - 50;
    }
    return 443;
}
+(void)setRouteConfiguration {
    NSString *moduleName = @"DDLocations";
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Location_Details andModuleName:moduleName withClassRef:self.class];
}
@end
