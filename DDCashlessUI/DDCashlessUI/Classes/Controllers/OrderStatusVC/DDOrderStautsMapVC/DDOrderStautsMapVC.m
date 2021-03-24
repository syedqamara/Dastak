//
//  DDOrderStautsMapVC.m
//  DDCashlessUI
//
//  Created by Zubair Ahmad on 18/05/2020.
//

#import "DDOrderStautsMapVC.h"
#import "DDCashlessThemeManager.h"

@import MapKit;

@interface DDOrderStautsMapVC () {
    DDOrderDetailSectionM *section;
}

@end

@implementation DDOrderStautsMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setThemeNavigationBar];
    [self addBackArrowNavigtaionItemWithtitle:@"Back".localized];
    
    section = (DDOrderDetailSectionM*) self.navigation.routerModel.data;
    [self setTitle:@"Map".localized];
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
    
    DDMapMarker *marker = [[DDMapMarker alloc] init];
    marker.lattitude = section.section_takeaway_map.outlet_lat;
    marker.longitude = section.section_takeaway_map.outlet_lng;
    marker.localPinImage = [NSString  stringWithFormat:@"cashless_takeaway"];
    marker.localPinSelectedImage = [NSString  stringWithFormat:@"cashless_takeaway"];
    
    marker.markerData = section.section_takeaway_map;
    [self.mapView loadMapWithSingleMarker:marker];
    if (section.section_takeaway_map.outlet_lat && section.section_takeaway_map.outlet_lng){
        [self.mapView setMapCentrePosition:[[DDLocationsManager shared] getLocationObjectFromLatitude:section.section_takeaway_map.outlet_lat longitude:section.section_takeaway_map.outlet_lng]];
    }
    [self updateCameraZoom];
    [self.mapView changeRecenterButtonConstraintsByConstant:-24 ofType:AutolayoutBottom];
}

- (void) updateCameraZoom {
    if([DDLocationsManager shared].isLocationServicesEnable){
        CLLocation *location = [DDLocationsManager shared].userCurrentLocation;
        CLLocationCoordinate2D source = location.coordinate;
        CLLocationCoordinate2D destination =  CLLocationCoordinate2DMake(section.section_takeaway_map.outlet_lat.floatValue, section.section_takeaway_map.outlet_lng.floatValue);
        
        
        GMSCoordinateBounds* bounds =  [[GMSCoordinateBounds alloc] initWithCoordinate:source coordinate:destination];
        GMSCameraUpdate* update = [GMSCameraUpdate fitBounds:bounds withEdgeInsets:UIEdgeInsetsMake(50, 20, 50, 20)];
        [self.mapView moveCamera:update];
    }
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
    alert.view.tintColor = CASHLESS_THEME.app_theme.colorValue;
    [self presentViewController:alert animated:YES completion:^{
        alert.view.tintColor = CASHLESS_THEME.app_theme.colorValue;
    }];
}

- (void) showAppleMaps {
    CLLocationCoordinate2D destination =  CLLocationCoordinate2DMake(section.section_takeaway_map.outlet_lat.floatValue, section.section_takeaway_map.outlet_lng.floatValue);
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:destination addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    [mapItem setName:section.section_takeaway_map.outlet_name];
    NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    [mapItem openInMapsWithLaunchOptions:options];
}

- (void) showGoogleMaps {
    NSString *appDomain = @"comgooglemaps://";
    NSString *browserDomain = @"https://www.google.com/maps/dir/";
    NSString *directionBody = [NSString stringWithFormat:@"?saddr=&daddr=%@,%@&directionsmode=driving",section.section_takeaway_map.outlet_lat.stringValue,section.section_takeaway_map.outlet_lng.stringValue];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appDomain]]){
        NSString *fullPath = [NSString stringWithFormat:@"%@%@",appDomain,directionBody];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:fullPath] options:@{} completionHandler:nil];
    }
}
@end
