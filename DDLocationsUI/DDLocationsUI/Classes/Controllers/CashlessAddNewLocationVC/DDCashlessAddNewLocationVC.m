//
//  DDCashlessAddNewLocationVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 14/02/2020.
//
#import "DDLocationsUIConstants.h"
#import "DDCashlessAddNewLocationVC.h"
#import "DDCoreLocation.h"
@interface DDCashlessAddNewLocationVC () <DDGMapViewDelegate> {
    CLLocation *selectedLocation;
}
@property (weak, nonatomic) IBOutlet UIImageView *currentLocationImageView;
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImage;
@property (weak, nonatomic) IBOutlet UIImageView *searchImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchLocationBottomConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *separatorImage;
@property (weak, nonatomic) IBOutlet DDGMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *centerMarkerImg;
@property (weak, nonatomic) IBOutlet UIView *locationTextContainerView;
@property (weak, nonatomic) IBOutlet UIView *locationDotView;
@property (weak, nonatomic) IBOutlet UILabel *locationLbl;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *cancelContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *confirmLocationBottomConstraint;

@property (strong, nonatomic) DDDeliveryAddressM *deliveryAddressM;

@end

@implementation DDCashlessAddNewLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSearchLocation];
    DDDeliveryAddressM *data = (DDDeliveryAddressM*)self.navigation.routerModel.data;
    if (data==nil) {
        [self goBackWithCompletion:nil];
        return;
    }
    self.deliveryAddressM = data;
    [self setupMapThings];
    [self setLocationText];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self setThemeNavigationBar];
}

-(void)setupMapThings {
    [self.mapView setZoomLevel:@(12)];
    [self.mapView changeRecenterButtonConstraintsByConstant:-98 ofType:AutolayoutBottom];
    self.mapView.entGMapViewDelegate = self;
    [self moveMapAccordingToDeliveryLocation];
}

-(void)moveMapAccordingToDeliveryLocation {
    selectedLocation = [[CLLocation alloc] initWithLatitude:self.deliveryAddressM.latitude.doubleValue longitude:self.deliveryAddressM.longitude.doubleValue];
    [self.mapView setMapCentrePosition:selectedLocation];

}

- (IBAction)locationTextTapped:(UIButton *)sender {
    __weak typeof (self) weakSelf = self;
    GMSVisibleRegion visibleRegion =  [self.mapView.projection visibleRegion];
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:visibleRegion.farLeft coordinate:visibleRegion.nearRight];
    [DDLocationsUIManager.shared showSearchLocationsVCFrom:self withData:bounds andControllerCallBack:^(NSString * _Nonnull identifier, id _Nonnull data, UIViewController * _Nonnull fromVC) {
        GMSPlace *place = (GMSPlace*)data;
        if ([place isKindOfClass:GMSPlace.class]) {
            [weakSelf.deliveryAddressM setCoordinate:place.coordinate];
        }else {
            DDDeliveryAddressM *add = data;
            if (add) {
                [weakSelf.deliveryAddressM setCoordinate:add.toCoreLocationCoordinate];
            }
        }
        [weakSelf moveMapAccordingToDeliveryLocation];
        [weakSelf showConfirmLocation];
    }];
}

- (IBAction)continueBtnTapped:(UIButton *)sender {
    [self showConfirmLocation];
}


-(void)setLocationText {
    if (self.deliveryAddressM.area.length) {
        self.locationLbl.text = self.deliveryAddressM.area;
    }
    else {
        self.locationLbl.text = K_CASHLESS_SEARCH_OR_MOVE.localized;
    }
}
-(void)showSearchLocation {
    [UIView animateWithDuration:0.4 animations:^{
        self.searchLocationBottomConstraint.constant = 0;
        self.confirmLocationBottomConstraint.constant = -1000;
        [self.view layoutIfNeeded];
    }];
    [self.mapView setMapCentrePosition:self->selectedLocation];
}
-(void)showConfirmLocation {
    [UIView animateWithDuration:0.4 animations:^{
        self.searchLocationBottomConstraint.constant = -1000;
        self.confirmLocationBottomConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
    [self.mapView setMapCentrePosition:self->selectedLocation];
}
-(void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    [self goBackWithCompletion:nil];
}
#pragma mark - Overridden
- (void)designUI {
    
//    self.title = K_CASHLESS_ADD_NEW_LOCATION.localized;
    [self setNavigationBarHidden:NO animated:NO];
    [self setTransparentNavigationBar];
    [self addNavigationItemWithImage:@"ic-close.png" identifier:@"ic-close" tintColor:THEME.app_theme.colorValue direction:(DDNavigationItemDirectionLeft)];
    self.searchImage.image = [@"ic-saerch" pngImage:self.class];
    self.rightArrowImage.image = [@"ic-arrow-right" pngImage:self.class];
    [self.centerMarkerImg loadImageWithString:@"pin.png" forClass:self.class];
    
    [self.currentLocationImageView loadImageWithString:@"ic-current-location_map.png" forClass:self.class];
    [self.currentLocationImageView.superview setHidden:!DDLocationsManager.shared.isLocationServicesEnable];
    
    self.separatorImage.backgroundColor = @"c7cad0".colorValue;
    self.separatorView.backgroundColor = @"c7cad0".colorValue;
    
    self.cancelBtn.titleLabel.font = [UIFont DDSemiBoldFont:17];
    self.confirmBtn.titleLabel.font = [UIFont DDSemiBoldFont:17];
    [self.cancelBtn setTitleColor:THEME.app_theme.colorValue forState:UIControlStateNormal];
    self.cancelBtn.layer.borderColor = THEME.app_theme.colorValue.CGColor;
    self.cancelBtn.layer.borderWidth = 1;
    self.cancelBtn.layer.cornerRadius = 12;
    self.cancelBtn.clipsToBounds = YES;
    [self.confirmBtn setTitleColor:THEME.text_white.colorValue forState:UIControlStateNormal];
    self.cancelContainer.borderColor = THEME.text_white.colorValue;
    self.separatorImage.cornerR = 3;
    self.separatorImage.clipsToBounds = YES;
    
    self.locationTextContainerView.cornerR = 12.0;
    self.locationTextContainerView.clipsToBounds = YES;
    self.locationTextContainerView.borderW = 0.5;
    self.locationTextContainerView.borderColor = DDLocationsThemeManager.shared.selected_theme.text_grey_238.colorValue;
    self.locationTextContainerView.backgroundColor = DDLocationsThemeManager.shared.selected_theme.bg_grey_248.colorValue;
    self.locationDotView.backgroundColor = UIColor.clearColor;
//    self.locationDotView.cornerR = 2;
//    self.locationDotView.clipsToBounds = YES;
    
    self.locationLbl.font = [UIFont DDRegularFont:15];
    self.locationLbl.textColor = DDLocationsThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.locationLbl.numberOfLines = 2;
    
    
    self.continueBtn.cornerR = 12.0;
    self.continueBtn.clipsToBounds = YES;
    self.continueBtn.titleLabel.font = [UIFont DDRegularFont:17];
    [self.continueBtn setTitle:USE_MARKED_LOCATION_BY_PIN.localized forState:UIControlStateNormal];
    [self.continueBtn setTitleColor:DDLocationsThemeManager.shared.selected_theme.app_theme.colorValue forState:UIControlStateNormal];
    
    [self.cancelBtn setTitle:CANCEL.localized forState:UIControlStateNormal];
    [self.confirmBtn setTitle:CONFIRM_PIN_LOCATION.localized forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(didTapCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmBtn addTarget:self action:@selector(didTapConfirmButton) forControlEvents:UIControlEventTouchUpInside];
}



#pragma mark - DDGMapViewDelegate

-(void)locationChanged:(GMSReverseGeocodeResponse*)GMSResponse {
    [self makeMarkerDefault];
    if (GMSResponse == nil) return;
    self.deliveryAddressM.area = GMSResponse.area;
    self.deliveryAddressM.street = GMSResponse.street;
    [self.deliveryAddressM setCoordinate:GMSResponse.firstResult.coordinate];
    self.locationLbl.text = self.deliveryAddressM.area;
}

- (void)entGMapView:(DDGMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position centre:(CLLocation *)centreLocation radius:(NSNumber *)radius {
    selectedLocation = [[CLLocation alloc] initWithLatitude:position.target.latitude longitude:position.target.longitude];
    self.continueBtn.hidden = YES;
    __weak typeof (self) weakSelf = self;
    [DDGoogleApiManager.shared reverseGeoLocation:selectedLocation withDetailCompletionCallBack:^(GMSReverseGeocodeResponse * _Nullable response) {
        if (response!=nil) {
            weakSelf.continueBtn.hidden = NO;
            [weakSelf locationChanged:response];
        }
    }];
}

+(void)setRouteConfiguration {
    NSString *moduleName = @"DDLocations";
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Cashless_Add_New_Location andModuleName:moduleName withClassRef:DDCashlessAddNewLocationVC.class];
}
-(void)makeMarkerSmall {
    [UIView animateWithDuration:0.1 animations:^{
        self.centerMarkerImg.transform = CGAffineTransformMakeScale(0.7, 0.7);
        self.centerMarkerImg.alpha = 0.4;
    }];
}
-(void)makeMarkerDefault {
    [UIView animateWithDuration:0.1 animations:^{
        self.centerMarkerImg.transform = CGAffineTransformMakeScale(1, 1);
        self.centerMarkerImg.alpha = 1;
    }];
}
-(void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture {
    [self makeMarkerSmall];
}
-(void)didTapCancelButton {
    [self showSearchLocation];
}
-(void)didTapConfirmButton {
    [DDLocationsUIManager.shared showCashlessLocationDetailsVCFrom:self withData:self.deliveryAddressM andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        [controller dismissViewControllerAnimated:NO completion:^{
            [self.navigation.routerModel sendDataCallback:identifier withData:data withController:self];
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }];
    }];
}
- (IBAction)didTapCurrentLocationButton:(id)sender {
    [self.mapView setMapCentrePosition:DDCoreLocation.shared.currentLocation];
}
@end
