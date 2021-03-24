//
//  DDSendParcelVC.m
//  AppAuth
//
//  Created by Syed Qamar Abbas on 12/10/2020.
//

#import "DDSendParcelVC.h"
#import "ACFloatingTextField.h"
#import "DDHomeUIManager.h"
#import "DDUI.h"
#import "DDLocationsUI.h"
#import "DDSendParcelRM.h"
#import "DDAuth.h"
#import "DDFormCollectionM.h"
#import "DDCashlessCartWebVC.h"

@import GoogleMaps;
@interface DDSendParcelVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet DDGradientButton *letsGoBtn;
@property (weak, nonatomic) IBOutlet DDGradientButton *submitButton;
@property (weak, nonatomic) IBOutlet UIView *dropOffAddressView;
@property (strong, nonatomic) DDSendParcelRM *requestM;
@property (strong, nonatomic) DDFormCollectionM *senderForm;
@property (strong, nonatomic) DDFormCollectionM *recieverForm;
@property (strong, nonatomic) DDFormCollectionM *parcelForm;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomConstraint;
@property (weak, nonatomic) IBOutlet DDGMapView *mapView;
@property (weak, nonatomic) IBOutlet DDDotView *dottedView;
@property (weak, nonatomic) IBOutlet UILabel *distanceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceSubTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *pickupImageView;
@property (weak, nonatomic) IBOutlet UIImageView *dropoffImageView;
@property (weak, nonatomic) IBOutlet UIButton *pickupChangeButton;
@property (weak, nonatomic) IBOutlet UIButton *dropoffChangeButton;
@property (weak, nonatomic) IBOutlet UILabel *timeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeSubTitleLabel;

@property (weak, nonatomic) IBOutlet ACFloatingTextField *pickupLocationTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *dropoffLocationTF;
@property (weak, nonatomic) IBOutlet UILabel *fareTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fareSubTitleLabel;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *paymentTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *parcelTypeTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *recieverInfoTF;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *senderInfoTF;

@property (weak, nonatomic) IBOutlet UIImageView *paymentImageView;
@property (weak, nonatomic) IBOutlet UIImageView *paymentDropdownImageView;

@property (weak, nonatomic) IBOutlet UIImageView *parcelTypeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *parcelTypeDropdownImageView;

@property (weak, nonatomic) IBOutlet UIImageView *recieverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *senderDropdownImageView;


@end

@implementation DDSendParcelVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setTransparentNavigationBar];
    [self setStatusBarStyle:(UIStatusBarStyleDefault)];
}
-(void)orderIsSuccessfullyPlaced {
    self.requestM = [DDSendParcelRM new];
    self.paymentTF.text = @"";
    self.parcelTypeTF.text = @"";
    self.recieverInfoTF.text = @"";
    self.senderInfoTF.text = @"";
    self.pickupLocationTF.text = @"";
    self.dropoffLocationTF.text = @"";
    [self checkAndOpenBottomView];
}

-(UITabBarItem *)tabBarItem {
    UITabBarItem *item = [[UITabBarItem alloc] init];
    item.image = [[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"ic-send-un-selected"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    item.selectedImage = [[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"ic-send"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    item.title = [@"DD C2C" localized];
    item.tag = 0;
    return item;
}
-(void)viewDidLoad {
    [super viewDidLoad];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(orderIsSuccessfullyPlaced) name:CASHLESS_ORDER_PLACE_NOTIFICATION object:nil];
    self.requestM = [DDSendParcelRM new];
    self.requestM.app_address = DDAuthManager.shared.config.data.default_location;
    [self checkAndOpenBottomView];
    [self addNavigationItemWithTitle:@"Delivery Details".localized identifier:@"title" tintColor:HOME_THEME.text_black_40.colorValue direction:(DDNavigationItemDirectionCenter)];
    // Do any additional setup after loading the view from its nib.
}
-(void)insertFormInfo {
    self.senderForm = [DDFormCollectionM new];
    self.recieverForm = [DDFormCollectionM new];
    self.parcelForm = [DDFormCollectionM new];
    
    //Parcel Form Info
    DDFormM *form = [DDFormM formWithTitle:@"Description".localized andValueKey:@"category_title" withImage:@"ic-form-edit.png" classType:DDTextFormM.class isRequired:YES withValue:nil];
    [self.parcelForm add:form];
    
    //Sender Form Info
    form = [DDFormM formWithTitle:@"Please enter sender name".localized andValueKey:@"name" withImage:@"ic-form-user.png" classType:DDTextFormM.class isRequired:YES withValue:nil];
    [self.senderForm add:form];
    form = [DDFormM formWithTitle:@"Please enter phone number".localized andValueKey:@"phone_number" withImage:@"ic-form-phone.png" classType:DDTextFormM.class isRequired:YES withValue:nil];
    [self.senderForm add:form];
    
    
    //Reciever Form Info
    form = [DDFormM formWithTitle:@"Please enter receiver name".localized andValueKey:@"name" withImage:@"ic-form-user.png" classType:DDTextFormM.class isRequired:YES withValue:nil];
    [self.recieverForm add:form];
    form = [DDFormM formWithTitle:@"Please enter phone number".localized andValueKey:@"phone_number" withImage:@"ic-form-phone.png" classType:DDTextFormM.class isRequired:YES withValue:nil];
    [self.recieverForm add:form];
}
-(void)designUI {
    [self insertFormInfo];
    self.dottedView.direction = DDDotViewDirectionVertical;
    self.dottedView.size = 3;
    self.dottedView.space = 4;
    self.dottedView.dotColor = HOME_THEME.text_grey_238.colorValue;
    self.submitButton.overlayColor = HOME_THEME.bg_white.colorValue;
    self.submitButton.overlayAlpha = 0.3;
    [self.submitButton setTitleColor:HOME_THEME.text_white.colorValue forState:(UIControlStateNormal)];
    
    [self.pickupChangeButton setTitleColor:HOME_THEME.app_theme.colorValue forState:(UIControlStateNormal)];
    [self.dropoffChangeButton setTitleColor:HOME_THEME.app_theme.colorValue forState:(UIControlStateNormal)];
    [self.pickupChangeButton setTitle:@"Change".localized forState:(UIControlStateNormal)];
    [self.dropoffChangeButton setTitle:@"Change".localized forState:(UIControlStateNormal)];
    
    self.pickupLocationTF.font = [UIFont DDMediumFont:13];
    self.pickupLocationTF.labelPlaceholder.font = [UIFont DDMediumFont:13];
    self.pickupLocationTF.textColor = HOME_THEME.text_black_40.colorValue;
    self.pickupLocationTF.placeHolderColor = HOME_THEME.text_grey_111.colorValue;
    self.pickupLocationTF.placeholder = @"Select pickup location".localized;
    
    
    self.dropoffLocationTF.font = [UIFont DDMediumFont:13];
    self.dropoffLocationTF.labelPlaceholder.font = [UIFont DDMediumFont:13];
    self.dropoffLocationTF.textColor = HOME_THEME.text_black_40.colorValue;
    self.dropoffLocationTF.placeHolderColor = HOME_THEME.text_grey_111.colorValue;
    self.dropoffLocationTF.placeholder = @"Select dropoff location".localized;
    
    
    [self.dropoffImageView loadImageWithString:@"ic-dropoff.png" forClass:self.class];
    [self.pickupImageView loadImageWithString:@"ic-pickup.png" forClass:self.class];
    
    self.senderForm.title = @"Sender information".localized;
    self.senderForm.submitButtonTitle = @"Confirm booking".localized;
    self.recieverForm.title = @"Receiver information".localized;
    self.recieverForm.submitButtonTitle = @"Confirm booking".localized;
    self.parcelForm.title = @"Add specific description".localized;
    self.parcelForm.submitButtonTitle = @"Save".localized;
    self.distanceTitleLabel.font = [UIFont DDRegularFont:13];
    self.distanceSubTitleLabel.font = [UIFont DDSemiBoldFont:13];
    self.timeTitleLabel.font = [UIFont DDRegularFont:13];
    self.timeSubTitleLabel.font = [UIFont DDSemiBoldFont:13];
    self.fareTitleLabel.font = [UIFont DDRegularFont:13];
    self.fareSubTitleLabel.font = [UIFont DDSemiBoldFont:13];
    self.distanceTitleLabel.textColor = @"747881".colorValue;
    self.distanceSubTitleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.timeTitleLabel.textColor = @"747881".colorValue;
    self.timeSubTitleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.fareTitleLabel.textColor = @"747881".colorValue;
    self.fareSubTitleLabel.textColor = HOME_THEME.app_theme.colorValue;
    
    self.paymentTF.textColor = HOME_THEME.text_black_40.colorValue;
    self.paymentTF.placeHolderColor = HOME_THEME.text_grey_111.colorValue;
    self.paymentTF.font = [UIFont DDSemiBoldFont:12];
    self.paymentTF.labelPlaceholder.font = [UIFont DDMediumFont:10];
    self.paymentTF.placeholder = @"Payment method".localized;
    self.parcelTypeTF.textColor = HOME_THEME.text_black_40.colorValue;
    self.parcelTypeTF.placeHolderColor = HOME_THEME.text_grey_111.colorValue;
    self.parcelTypeTF.font = [UIFont DDSemiBoldFont:12];
    self.parcelTypeTF.labelPlaceholder.font = [UIFont DDMediumFont:10];
    self.parcelTypeTF.placeholder = @"What are you sending?".localized;
    self.recieverInfoTF.textColor = HOME_THEME.text_black_40.colorValue;
    self.recieverInfoTF.placeHolderColor = HOME_THEME.text_grey_111.colorValue;
    self.recieverInfoTF.font = [UIFont DDSemiBoldFont:12];
    self.recieverInfoTF.labelPlaceholder.font = [UIFont DDMediumFont:10];
    self.recieverInfoTF.placeholder = @"Receiver".localized;
    self.senderInfoTF.textColor = HOME_THEME.text_black_40.colorValue;
    self.senderInfoTF.placeHolderColor = HOME_THEME.text_grey_111.colorValue;
    self.senderInfoTF.font = [UIFont DDSemiBoldFont:12];
    self.senderInfoTF.labelPlaceholder.font = [UIFont DDMediumFont:10];
    self.senderInfoTF.placeholder = @"Sender".localized;
    [self.letsGoBtn setTitle:@"Let's go".localized forState:(UIControlStateNormal)];
    [self.paymentImageView loadImageWithString:@"ic-payment.png" forClass:self.class];
    [self.paymentDropdownImageView loadImageWithString:@"ic-arrow-down.png" forClass:self.class];
    [self.parcelTypeImageView loadImageWithString:@"ic-goods.png" forClass:self.class];
    [self.parcelTypeDropdownImageView loadImageWithString:@"ic-arrow-down.png" forClass:self.class];
    [self.recieverImageView loadImageWithString:@"ic-payment-edit.png" forClass:self.class];
    [self.senderDropdownImageView loadImageWithString:@"ic-payment-edit.png" forClass:self.class];
    self.distanceTitleLabel.text = @"Distance".localized;
    self.timeTitleLabel.text = @"Time".localized;
    self.fareTitleLabel.text = @"Estimate Fare".localized;
    self.fareSubTitleLabel.text = @"";
    self.paymentTF.delegate = self;
    self.parcelTypeTF.delegate = self;
    self.recieverInfoTF.delegate = self;
    self.senderInfoTF.delegate = self;
    self.pickupLocationTF.delegate = self;  
    self.dropoffLocationTF.delegate = self;
    UITapGestureRecognizer *gest = [UITapGestureRecognizer.alloc initWithTarget:self action:@selector(didTapParcelType)];
    gest.numberOfTapsRequired = 1;
    [self.parcelTypeTF.superview.superview addGestureRecognizer:gest];
    gest = [UITapGestureRecognizer.alloc initWithTarget:self action:@selector(didTapPaymentType)];
    gest.numberOfTapsRequired = 1;
    [self.paymentTF.superview.superview addGestureRecognizer:gest];
    
}
-(void)calculateFair {
    DDC2CFairsRM *req = [DDC2CFairsRM new];
    req.pick_up_lat = @(self.requestM.pick_up_address.toCoreLocationCoordinate.latitude);
    req.pick_up_lng = @(self.requestM.pick_up_address.toCoreLocationCoordinate.longitude);
    req.drop_off_lat = @(self.requestM.drop_off_address.toCoreLocationCoordinate.latitude);
    req.drop_off_lng = @(self.requestM.drop_off_address.toCoreLocationCoordinate.longitude);
    self.fareSubTitleLabel.text = @"";
    [self.fareSubTitleLabel setGradientMovingColor:HOME_THEME.bg_grey_199.colorValue];
    [self.fareSubTitleLabel setGradientBackgroundColor:HOME_THEME.bg_grey_220.colorValue];
    self.fareSubTitleLabel.placeHolder = YES;
    [DDHomeManager.shared calculateFair:req showHUD:NO onCompletion:^(DDBaseApiModel * _Nullable model, NSError * _Nullable error) {
        if (model.successfulApi) {
            self.fareSubTitleLabel.placeHolder = NO;
            DDC2CFairsApiM *m = (DDC2CFairsApiM *)model;
            self.requestM.fair_params = m.data.api_param;
            self.fareSubTitleLabel.text = m.data.charges;
            self.distanceSubTitleLabel.text = m.data.distance;
            self.timeSubTitleLabel.text = m.data.time;
            [self inputChange];
        }else {
            [DDAlertUtils showOkAlertWithTitle:@"" subtitle:model.message completion:^{}];
            self.fareSubTitleLabel.placeHolder = NO;
            self.requestM.fair_params = @{};
            self.fareSubTitleLabel.text = @"N/A";
            self.distanceSubTitleLabel.text = @"N/A";
            self.timeSubTitleLabel.text = @"N/A";
            [self inputChange];
        }
    }];
}
-(void)didTapParcelType {
    [self.parcelTypeTF becomeFirstResponder];
}
-(void)didTapPaymentType {
    [self.paymentTF becomeFirstResponder];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.paymentTF == textField) {
        [self openPaymentMethod];
    }
    if (self.parcelTypeTF == textField) {
        [self openParcelType];
    }
    if (self.senderInfoTF == textField) {
        [self openSenderInfo];
    }
    if (self.recieverInfoTF == textField) {
        [self openRecieverInfo];
    }
    if (self.pickupLocationTF == textField) {
        [self openPickupLocationPicker];
    }
    if (self.dropoffLocationTF == textField) {
        [self openDropoffLocationPicker];
    }
    return NO;
}
-(void)openPaymentMethod {
    [self.paymentDropdownImageView rotateBy180:0.25];
    [DDHomeUIManager.shared showPaymentMethod:self withSelectedMethod:self.requestM.payment withcallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        self.requestM.payment = data;
        self.paymentTF.text = self.requestM.payment.title;
        [self.paymentDropdownImageView resetRotation:0.25];
        [self inputChange];
    }];
}
-(void)openParcelType {
    [self.parcelTypeDropdownImageView rotateBy180:0.25];
    [DDHomeUIManager.shared showGoodsType:self withSelected:self.requestM.parcel_info withcallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        DDHomeSectionListM *cat = data;
        DDParcelInfoRM *info = [DDParcelInfoRM new];
        info.category_id = cat.category_id;
        info.category_title = cat.title;
        if ([identifier isEqualToString:@"CUSTOM"]) {
            if (info.category_id == nil) {
                [self openForm:self.parcelForm andCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
                    DDParcelInfoRM *pInfo = [self.parcelForm.toDictionary decodeTo:DDParcelInfoRM.class];
                    self.parcelTypeTF.text = pInfo.category_title;
                    self.requestM.parcel_info = pInfo;
                    [self.paymentDropdownImageView resetRotation:0.25];
                }];
            }else {
                self.parcelTypeTF.text = info.category_title;
                self.requestM.parcel_info = info;
                [self.paymentDropdownImageView resetRotation:0.25];
            }
        }else {
            if (data != nil) {
                self.parcelTypeTF.text = info.category_title;
                self.requestM.parcel_info = info;
                [self.paymentDropdownImageView resetRotation:0.25];
            }else {
                [self.paymentDropdownImageView resetRotation:0.25];
            }
        }
        
        [self inputChange];
    }];
}
-(void)openSenderInfo {
    [self openForm:self.senderForm andCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        DDParcelClientInfoRM *pInfo = [self.senderForm.toDictionary decodeTo:DDParcelClientInfoRM.class];
        self.senderInfoTF.text = pInfo.name;
        self.requestM.sender_info = pInfo;
        [self.paymentDropdownImageView resetRotation:0.25];
    }];
}
-(void)openForm:(DDFormCollectionM *)form andCallBack:(ControllerCallBack)callBack {
    [DDHomeUIManager.shared showForm:form onController:self controllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        if (callBack != nil) {
            callBack(identifier, data, controller);
        }
        [self inputChange];
    }];
}
-(void)openRecieverInfo {
    [self openForm:self.recieverForm andCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        DDParcelClientInfoRM *pInfo = [self.recieverForm.toDictionary decodeTo:DDParcelClientInfoRM.class];
        self.recieverInfoTF.text = pInfo.name;
        self.requestM.reciever_info = pInfo;
        [self.paymentDropdownImageView resetRotation:0.25];
    }];
}
-(void)inputChange {
    self.submitButton.showOverlay = !self.requestM.isReadyToPlaceOrder;
}
-(void)openCartWithCart:(DDSendParcelRM *)cart {
    __weak typeof(self) weakSelf = self;
    [DDHomeUIManager.shared showC2CCart:cart onController:self controllerCallBack:^(NSString * _Nonnull identifier, id _Nonnull params, UIViewController * _Nonnull controller) {
        if ([params isKindOfClass:NSDictionary.class]) {
            [controller dismissViewControllerAnimated:YES completion:^{
                [weakSelf openOrderStatus:((NSDictionary *)params)];
            }];
        }else {
            [self openEditorForCart:cart onController:controller];
        }
    }];
}
-(void)openOrderStatus:(NSDictionary *)orderInfo {
    DDOrderRM *request = [DDOrderRM new];
    request.order_id = orderInfo[@"order_id"];
    [DDHomeUIManager.shared showOrderStatus:self withData:request WithcallBack:nil];
}
-(void)openEditorForCart:(DDSendParcelRM *)cart onController:(UIViewController *)controller {
    DDUIBaseViewController *baseVC = (DDUIBaseViewController *)controller;
    if (baseVC != nil) {
        [baseVC goBackWithCompletion:^{
            id data = [cart.toDictionary bv_jsonDataWithPrettyPrint:YES];
            if ([data isKindOfClass:NSData.class]) {
                [DDEditConfigManager openJSONEditor:(NSData *)data withTitle:@"Send".localized onController:self andCallBack:^(NSString * _Nonnull identifier, id _Nonnull returnedData, UIViewController * _Nonnull controller) {
                    NSData *editedData = returnedData;
                    DDSendParcelRM *newCart = [editedData decodeTo:DDSendParcelRM.class];
                    if (newCart != nil) {
                        [self openCartWithCart:newCart];
                    }else {
                        [DDAlertUtils showOkAlertWithTitle:@"Failure" subtitle:@"Provided JSON is not appropriate for Cashless Order" completion:^{
                            [self openCartWithCart:cart];
                        }];
                    }
                }];
            }
        }];
    }
}
-(void)openDropoffLocationPicker {
    [DDHomeUIManager.shared showC2CLocationsVCFrom:self withData:nil andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        DDDeliveryAddressM *addr = data;
        if (addr != nil) {
            self.requestM.drop_off_address = addr;
            self.dropoffLocationTF.text = addr.getCompleteAddress;
            [self checkAndOpenBottomView];
        }
    }];
}
-(void)openPickupLocationPicker {
    [DDHomeUIManager.shared showC2CLocationsVCFrom:self withData:@"Picked From".localized andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        DDDeliveryAddressM *addr = data;
        if (addr != nil) {
            self.requestM.pick_up_address = addr;
            self.pickupLocationTF.text = addr.getCompleteAddress;
            [self checkAndOpenBottomView];
        }
    }];
}
-(void)animateMap {
    [self.mapView clear];
    if (self.requestM.haveBothAddresses) {
        [self calculateFair];
        GMSCoordinateBounds *bound = [GMSCoordinateBounds.alloc initWithCoordinate:self.requestM.pick_up_address.toCoreLocationCoordinate coordinate:self.requestM.drop_off_address.toCoreLocationCoordinate];
        [self drawPath];
        [self.mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bound]];
    }else {
        GMSCoordinateBounds *bound = [GMSCoordinateBounds.alloc initWithCoordinate:self.requestM.defaultAddress.toCoreLocationCoordinate coordinate:self.requestM.defaultAddress.toCoreLocationCoordinate];
        [self.mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bound]];
    }
    
}
-(void)drawPath {
    [self.mapView animateToZoom:14];
    [DDGoogleApiManager.shared findDirection:self.requestM.drop_off_address.toCoreLocationCoordinate andDestination:self.requestM.pick_up_address.toCoreLocationCoordinate completionCallBack:^(NSArray<NSString *> * _Nullable routes) {
        
        [self.mapView clear];
        for (NSString *str in routes) {
            GMSMutablePath *path = [GMSMutablePath pathFromEncodedPath:str];
            GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
            polyline.strokeWidth = 5;
            polyline.strokeColor = HOME_THEME.app_theme.colorValue;
            polyline.map = self.mapView;
        }
    }];
    
}
-(void)checkAndOpenBottomView {
    if (!self.requestM.hideBottomView) {
        NSTimeInterval interval = 0.4;
        [UIView animateWithDuration:interval animations:^{
            self.bottomViewBottomConstraint.constant = 0;
            [self.view layoutIfNeeded];
        } completion:nil];
    }else {
        self.bottomViewBottomConstraint.constant = -1000;
        [self.view layoutIfNeeded];
    }
    [UIView animateWithDuration:0.9 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.dropOffAddressView setHidden:self.requestM.hideDropoffAddressView];
        [self.dropoffImageView setHidden:self.requestM.hideDropoffAddressView];
        [self.dottedView setHidden:self.requestM.hideDropoffAddressView];
    } completion:nil];
    [self animateMap];
    [self inputChange];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTapSubmitButton:(id)sender {
    self.requestM.user = DDUserManager.shared.currentUser.copy;
    self.requestM.default_param = DDCCommonParamManager.shared.default_api_parameters.toDictionary;
    [self openCartWithCart:self.requestM];
}
- (IBAction)didTapChangeButton:(id)sender {
    if (sender == self.pickupChangeButton) {
        [self openPickupLocationPicker];
    }else {
        [self openDropoffLocationPicker];
    }
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Home_Send_Parcel andModuleName:@"DDHomeUI" withClassRef:self];
}
@end
