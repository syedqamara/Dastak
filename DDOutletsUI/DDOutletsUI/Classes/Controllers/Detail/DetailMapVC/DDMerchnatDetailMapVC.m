//
//  DDMerchnatDetailMapVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 16/03/2020.
//

#import "DDMerchnatDetailMapVC.h"
#import "DDOutletsUIConstants.h"
#import "DDOutletsThemeManager.h"
@import MapKit;

@interface DDMerchnatDetailMapVC () {
    DDOutletM *outlet;
    DDMerchantOffersLocalDataM *viewModel;
}

@end

@implementation DDMerchnatDetailMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setThemeNavigationBar];
    [self addBackArrowNavigtaionItemWithtitle:@"Back".localized];
    
    viewModel = (DDMerchantOffersLocalDataM*) self.navigation.routerModel.data;
    outlet = viewModel.selectedOutlet;
    [self setTitle:outlet.name];
    [self setupMapView];
}

-(void)designUI {
    [self.btnDirection setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icDirectionMaps"] forState:UIControlStateNormal];
    [self.view bringSubviewToFront:self.btnDirection];
}

- (void) setupMapView {
    self.mapView.isFirstIdleCameraPositionToIgnore = YES;
    self.mapView.zoomLevel = @(10);
    self.mapView.entGMapViewDelegate = self;
    
    
    NSString *analyticsCategoryName = viewModel.merchant.categories_analytics;
    
    DDMapMarker *marker = [[DDMapMarker alloc] init];
    marker.lattitude = outlet.lat;
    marker.longitude = outlet.lng;
    marker.category = outlet.category;
    marker.localPinImage = [NSString  stringWithFormat:@"%@_pin_selected",analyticsCategoryName.lowercaseString];
    marker.localPinSelectedImage = [NSString  stringWithFormat:@"%@_pin_selected",analyticsCategoryName.lowercaseString];
    
    marker.markerData = outlet;
    [self.mapView loadMapWithSingleMarker:marker];
    if (outlet.lat && outlet.lng){
        [self.mapView setMapCentrePosition:[[DDLocationsManager shared] getLocationObjectFromLatitude:outlet.lat longitude:outlet.lng]];
    }
    [self updateCameraZoom];
    [self.mapView changeRecenterButtonConstraintsByConstant:-24 ofType:AutolayoutBottom];
}

- (void) updateCameraZoom {
    if([DDLocationsManager shared].isLocationServicesEnable){
        CLLocation *location = [DDLocationsManager shared].userCurrentLocation;
        CLLocationCoordinate2D source = location.coordinate;
        CLLocationCoordinate2D destination =  CLLocationCoordinate2DMake(outlet.lat.floatValue, outlet.lng.floatValue);
        
        
        GMSCoordinateBounds* bounds =  [[GMSCoordinateBounds alloc] initWithCoordinate:source coordinate:destination];
        GMSCameraUpdate* update = [GMSCameraUpdate fitBounds:bounds withEdgeInsets:UIEdgeInsetsMake(50, 20, 50, 20)];
        [self.mapView moveCamera:update];
        
//        [self getPolylineRouteFrom:source to:destination];
    }
}

//-(void)getPolylineRouteFrom:(CLLocationCoordinate2D)source to:(CLLocationCoordinate2D)destination{
//
//
//    NSMutableDictionary *params = [NSMutableDictionary new];
//    [params setValue:[NSString stringWithFormat:@"%f,%f",source.latitude, source.longitude] forKey:@"origin"];
//    [params setValue:[NSString stringWithFormat:@"%f,%f",destination.latitude, destination.longitude] forKey:@"destination"];
//    [params setValue:DDCAppConfigManager.shared.api_config.GOOGLE_API_KEY forKey:@"key"];
//
//    [[DDMapsManager shared] getDirectionsFromGoogleAPI:params andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%@",response);
//        [self showPath:@""];
//    }];
//}

-(void)showPath:(NSString*)polyStr{
    GMSPath *path = [GMSPath pathFromEncodedPath:polyStr];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeWidth = 6.0;
    polyline.strokeColor = DDOutletsThemeManager.shared.selected_theme.app_theme.colorValue;
    polyline.map = self.mapView;
    
}

- (IBAction)directionsAction:(id)sender {
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        [self showAppleMaps];
        return;
    }
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Choose a map to view the route".localized message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* appleMap = [UIAlertAction actionWithTitle:@"Maps"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
                               {
        [self  showAppleMaps];
    }];
    
    UIAlertAction* googleMap = [UIAlertAction actionWithTitle:@"Google Maps"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
                                {
        [self  showGoogleMaps];
    }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action)
                             {
    }];
    
    [alert addAction:appleMap];
    [alert addAction:googleMap];
    [alert addAction:cancel];
    alert.view.tintColor = DDOutletsThemeManager.shared.selected_theme.app_theme.colorValue;
    [self presentViewController:alert animated:YES completion:^{
        alert.view.tintColor = DDOutletsThemeManager.shared.selected_theme.app_theme.colorValue;
    }];
}

- (void) showAppleMaps {
    CLLocationCoordinate2D destination =  CLLocationCoordinate2DMake(outlet.lat.floatValue, outlet.lng.floatValue);
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:destination addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    [mapItem setName:outlet.name];
    NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    [mapItem openInMapsWithLaunchOptions:options];
}

- (void) showGoogleMaps {
    NSString *appDomain = @"comgooglemaps://";
    NSString *browserDomain = @"https://www.google.com/maps/dir/";
    NSString *directionBody = [NSString stringWithFormat:@"?saddr=&daddr=%@,%@&directionsmode=driving",outlet.lat.stringValue,outlet.lng.stringValue];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appDomain]]){
        NSString *fullPath = [NSString stringWithFormat:@"%@%@",appDomain,directionBody];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:fullPath] options:@{} completionHandler:nil];
    }
}
@end
