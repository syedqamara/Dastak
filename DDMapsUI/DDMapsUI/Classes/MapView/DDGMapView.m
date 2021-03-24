//
//  DDGMapView.m
//  DDUI
//
//  Created by Zubair Ahmad on 16/01/2020.
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

#import "DDGMapView.h"
#import "SDWebImage.h"
#import "DDMapsManager.h"
#import "DDMapsUIConstants.h"

@interface DDGMapView () {
    
    float previousZoomLevel;
    CLLocationCoordinate2D prevCoordinate;
    NSMutableArray <DDMapMarker*> *previousMarkersList;
        
    GMUDefaultClusterRenderer *_renderer;
    GMUClusterManager *_clusterManager;
    id _selectedOutlet;
    UIButton *recenterButton;
    NSMutableArray <Autolayout *> *bottomButtonConstraints;
}

@end

@implementation DDGMapView

-(instancetype)init {
    self = [super init];
    [self setMapDelegateAndDatasource];
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self setMapDelegateAndDatasource];
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setMapDelegateAndDatasource];
    return self;
}

-(void) layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - initail setup

-(void)setMapDelegateAndDatasource {
    super.delegate = self;
    self.markers = [NSMutableArray new];
    previousMarkersList = [NSMutableArray new];
    self.isMyLocationEnable = YES;
    self.zoomLevel = [NSNumber numberWithInt:12];
    self.isFirstIdleCameraPositionToIgnore = YES;
    self.isMarkersCollectionViewEnable = NO;
    self.isHomeViewMap = NO;
    self.myLocationEnabled = [[DDLocationsManager shared] isLocationServicesEnable];
    [self setMapCentrePosition:[[DDLocationsManager shared] userCurrentLocation]];
    [self setMapStyle];
}

- (void) setMapStyle {
    NSString *kMapStyle = [NSBundle loadJsonStringWithFileName:self.class fileName:@"DDMap_style"];
    NSError *error;
    
    // Set the map style by passing the URL for style.json.
    GMSMapStyle *style = [GMSMapStyle styleWithJSONString:kMapStyle error:&error];
    
    if (!style) {
        NSLog(@"The style definition could not be loaded: %@", error);
        return;
    }
    self.mapStyle = style;
    
    if (self.isMyLocationEnable && [[DDLocationsManager shared] isLocationServicesEnable]) {
        recenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [recenterButton setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icRecenterMap"] forState:UIControlStateNormal];
        [recenterButton addTarget:self action:@selector(setMapRecenterToUserCurrentLocation) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:recenterButton];
        [self bringSubviewToFront:recenterButton];
        
        recenterButton.translatesAutoresizingMaskIntoConstraints = NO;
        bottomButtonConstraints = [Autolayout addConstrainsToParentView:self andChildView:recenterButton withConstraintTypeArray:@[@(AutolayoutRight),@(AutolayoutHeight),@(AutolayoutWidth),@(AutolayoutBottom)] andValues:@[@(16),@(50),@(50),@(25)]];
    }
    
}

- (void) loadMapWithSingleMarker : (DDMapMarker*) marker {
    [self loadMapWithMarkers:[[NSMutableArray alloc] initWithObjects:marker, nil] isMapClear:YES];
}

- (void) loadMapWithMarkers : (NSMutableArray <DDMapMarker*> *) markers isMapClear:(BOOL) clearMap {
    if (clearMap){
        [self clearMapAllData];
    }
    self.markers = markers.mutableCopy;
    for (DDMapMarker *outlet in self.markers) {
        
        // init default marker with position and custom user data is being set to use later.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(outlet.lattitude.floatValue, outlet.longitude.floatValue);
        marker.userData = outlet;
        marker.map = self;
        marker.icon = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:outlet.localPinImage];
        // check if we have pin image from API, overwrite it.
        if (outlet.pinImage != nil && outlet.pinImage.length > 0){
            [self setMarkerImageFromURL:outlet.pinImage :marker];
        }
    }
}

-(void) loadMapWithClusteredMarkers : (NSMutableArray <DDMapMarker*> *) markers isMapClear:(BOOL) clearMap {
    if (clearMap){
        [self clearMapAllData];
    }
    self.markers = markers.mutableCopy;
    if (markers.count > 0) {
        [self setUpClusters];
    }
}

- (void) setUpClusters {
    // Set up the cluster manager with a supplied icon generator and renderer.
    // set renderer delegate to self. For custom clustring
    id<GMUClusterAlgorithm> algorithm =
        [[GMUNonHierarchicalDistanceBasedAlgorithm alloc] init];
    id<GMUClusterIconGenerator> iconGenerator =
    [[GMUDefaultClusterIconGenerator alloc] init];
    _renderer = [[GMUDefaultClusterRenderer alloc] initWithMapView:self clusterIconGenerator:iconGenerator];
    _renderer.delegate = self;
    _clusterManager = [[GMUClusterManager alloc] initWithMap:self algorithm:algorithm renderer:_renderer];
    
    // Generate and add random items to the cluster manager.
    [self generateClusterItems];

    // Call cluster() after items have been added
    // to perform the clustering and rendering on map.
    [_clusterManager cluster];
    
    // Register self to listen to both GMUClusterManagerDelegate and GMSMapViewDelegate events.
    [_clusterManager setDelegate:self mapDelegate:self];
}

// generates cluster items within some extent of the camera and
// adds them to the cluster manager.
- (void)generateClusterItems {
    
    for (int index = 0; index < self.markers.count; index++) {
        DDMapMarker *marker = self.markers[index];
        
        double lat = marker.lattitude.doubleValue;
        double lng = marker.longitude.doubleValue;
        
        // POIItem position with custom marker object
        id<GMUClusterItem> item =
        [[DDMapClusterItem alloc] initWithPosition:CLLocationCoordinate2DMake(lat, lng) marker:marker];
        
        // adding cluster item in manager
        [_clusterManager addItem:item];
    }
}


#pragma mark - Map helpers

-(Autolayout *)getConstraintWithType:(ConstraintType)type {
    Autolayout *layout;
    for (Autolayout *constraint in bottomButtonConstraints) {
        if (type == constraint.type) {
            layout = constraint;
            break;
        }
    }
    return layout;
}
-(void)changeRecenterButtonConstraintsByConstant:(CGFloat)value ofType:(ConstraintType)type {
    Autolayout *layout = [self getConstraintWithType:type];
    [layout changeConstraintValue:value];
}

- (void) setMapRecenterToUserCurrentLocation {
    if ([[DDLocationsManager shared] isLocationServicesEnable]){
        [self setMapCentrePosition:[[DDLocationsManager shared] userCurrentLocation]];
        if ([self.entGMapViewDelegate respondsToSelector:@selector(didTapMapRecentreToUserCurrentLocation)]) {
            [self.entGMapViewDelegate didTapMapRecentreToUserCurrentLocation];
        }
    }
}

-(void) setMapCentrePosition :(CLLocation *)location {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude zoom:self.zoomLevel.integerValue];
        [self setCamera: camera];
    });
}

- (void) setNewCameraPosition : (GMSCameraPosition*) newCamera  {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         GMSCameraUpdate *update = [GMSCameraUpdate setCamera:newCamera];
           [self moveCamera:update];
    });
}

#pragma mark - Cluster delegates

- (BOOL)clusterManager:(GMUClusterManager *)clusterManager didTapCluster:(id<GMUCluster>)cluster {
  GMSCameraPosition *newCamera =
      [GMSCameraPosition cameraWithTarget:cluster.position zoom:self.camera.zoom + 1];
  GMSCameraUpdate *update = [GMSCameraUpdate setCamera:newCamera];
  [self moveCamera:update];
    return YES;
}

- (void)renderer:(id<GMUClusterRenderer>)renderer willRenderMarker:(GMSMarker *)marker {

    NSString *imageURL = @"";
    // check if this is not a cluster, but a single pin and set pin image
    //else
    // check if this is cluster of pins and get max occurrence of category
    if ([marker.userData isKindOfClass:[DDMapClusterItem class]]) {
        DDMapClusterItem *userData = marker.userData;
        if ([self checkIfMarkerISSelected:marker]){
            marker.icon = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:userData.marker.localPinSelectedImage];
            // if image from api url exists
            if (userData.marker.pinSelectedImage != nil && userData.marker.pinSelectedImage.length > 0){
                imageURL = userData.marker.pinSelectedImage;
            }
        }else {
            marker.icon = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:userData.marker.localPinImage];
            // if image from api url exists
            if (userData.marker.pinImage != nil && userData.marker.pinImage.length > 0){
                imageURL = userData.marker.pinImage;
            }
        }
    } else if ([marker.userData conformsToProtocol:@protocol(GMUCluster)]) {
        id<GMUCluster> userData = marker.userData;
        // this is most occurred category in the cluster items array
        DDMapClusterItem *topCategoryMarker = [self getClusterMaxCategoryImage:userData.items];
        marker.icon = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:topCategoryMarker.marker.localClusterImage];
        // if image from api url exists
        if (topCategoryMarker.marker.clusterImage != nil && topCategoryMarker.marker.clusterImage.length > 0){
            imageURL = topCategoryMarker.marker.clusterImage;
        }
    }else{
        marker.icon = marker.icon;
    }
    // load image from api url
    if (imageURL != nil && imageURL.length > 0){
        [self setMarkerImageFromURL:imageURL :marker];
    }
}

- (void) renderer:(id<GMUClusterRenderer>)renderer didRenderMarker:(GMSMarker *)marker {
    
}

- (GMSMarker*) renderer:(id<GMUClusterRenderer>)renderer markerForObject:(id)object {
    GMSMarker *marker = [[GMSMarker alloc] init];
    if ([object isKindOfClass:[DDMapClusterItem class]]) {
        DDMapClusterItem *item = (DDMapClusterItem*)object;
        marker.userData = item;
    }
    return marker;
}

#pragma mark - Map View Delegates

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    DDMapMarker *thisMarker;
    if ([marker.userData isKindOfClass:[DDMapClusterItem class]]) { // marker is kind of cluster item
        if (self.previousSelectedMarker) {
            [self resetSelectedMarker:self.previousSelectedMarker];
        }
        DDMapClusterItem *userData = marker.userData;
        thisMarker = userData.marker;
        self.previousSelectedMarker = marker;
        marker.icon = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:thisMarker.localPinSelectedImage];
        if (thisMarker.pinSelectedImage != nil && thisMarker.pinSelectedImage.length > 0){
            [self setMarkerImageFromURL:thisMarker.pinSelectedImage :marker];
        }
    }else{
        // create DDMapMarker object to send back to respective controllers
        thisMarker = [[DDMapMarker alloc] init];
        thisMarker.lattitude = @(marker.position.latitude);
        thisMarker.longitude = @(marker.position.longitude);
        thisMarker.markerData = marker.userData;
    }
    // if delegate is responding
    if ([self.entGMapViewDelegate respondsToSelector:@selector(entGMapView:didTapMarker:)]) {
        [self.entGMapViewDelegate entGMapView:self didTapMarker:thisMarker];
    }
    return YES;
}

-(void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position{
    if (self.isFirstIdleCameraPositionToIgnore){
        self.isFirstIdleCameraPositionToIgnore = NO;
        previousZoomLevel = self.zoomLevel.floatValue;
        prevCoordinate = [self centreOfMapView];
        return;
    }
    if (_selectedOutlet != nil){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setSelectedMarkerObject:self->_selectedOutlet];
            self->_selectedOutlet = nil;
        });
        return;
    }
    BOOL loadNewData = YES;
    
    CLLocationCoordinate2D centerCoordinate = [self centreOfMapView];
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
    CLLocationDistance newRadius = [self visibleRadiusMeters];
    
    if (self.isHomeViewMap){
        if (position.zoom <= 5){
            if (previousZoomLevel > 5){
                previousMarkersList = self.markers.mutableCopy;
            }
            [self clearMapAllData];
            [self loadCountryMarkers];
            loadNewData = NO;
        }else {
            if (previousZoomLevel <= 5){
                [self clearMapAllData];
                [self loadMapWithClusteredMarkers:previousMarkersList isMapClear:YES];
                loadNewData = NO;
            }
            if (position.zoom > 5){
                
            }else if (position.zoom > 10){
                
            }
        }
        if (loadNewData){
            if (CLLocationCoordinate2DIsValid(prevCoordinate)) {
                CLLocation *prevLocation = [[CLLocation alloc] initWithLatitude:prevCoordinate.latitude longitude:prevCoordinate.longitude];
                
//                CGFloat thresholdInMeters = newRadius / 4;
                double differenceInDistanceOfCentre = [currentLocation distanceFromLocation:prevLocation];
                if (differenceInDistanceOfCentre < K_MAP_DISTANCE_THRESHOLD) {
                    loadNewData = NO;
                }
            }
            
            float curZoomLevel = position.zoom;
            if(previousZoomLevel < curZoomLevel) {
                loadNewData = NO;
            }
            
//            loadNewData = NO;
//            // CHECK FOR ZOOM
//            if (previousZoomLevel > position.zoom){
//                loadNewData = YES;
//            }
//
//            // CHECK FOR DIFFERENCE IN Centre POINTS
//            if (differenceInDistanceOfCentre > 1000) {
//                loadNewData = YES;
//            }
        }
    }
    
    previousZoomLevel = position.zoom;
    if (loadNewData){
        prevCoordinate = centerCoordinate;
        if (self.isHomeViewMap){
            [self showRedoSearchView:YES];
        }else{
            if ([self.entGMapViewDelegate respondsToSelector:@selector(entGMapView:idleAtCameraPosition:centre:radius:)]) {
                [self.entGMapViewDelegate entGMapView:self idleAtCameraPosition:position centre:currentLocation radius:@(newRadius)];
            }
        }
    }
}

-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    if ([self.entGMapViewDelegate respondsToSelector:@selector(entGMapView:didTapAtCoordinate:)]) {
        [self.entGMapViewDelegate entGMapView:self didTapAtCoordinate:coordinate];
    }
}

#pragma mark - set reset markers

- (BOOL) checkIfMarkerISSelected : (GMSMarker*)marker {
    if (_previousSelectedMarker != nil){
//        DDMapClusterItem *prevItem = (DDMapClusterItem*)_previousSelectedMarker.userData;
//        DDOutletM *prevOutlet = (DDOutletM*)prevItem.marker.markerData;
//
//        DDMapClusterItem *newItem = (DDMapClusterItem*)marker.userData;
//        DDOutletM *newOutlet = (DDOutletM*)newItem.marker.markerData;
//
//        if (newOutlet != nil && prevOutlet != nil && (prevOutlet.outlet_id == newOutlet.outlet_id)){
//            return YES;
//        }
    }
    return NO;
}

-(void) setSelectedMarkerObject : (id) outlet{
    if (outlet == nil){
        return;
    }
//    NSArray <GMSMarker *> *markersArray = [NSArray new];
//    markersArray = [[_renderer markers] mutableCopy];
////    NSString *refMethodName = @"markers";
////    SEL selector = NSSelectorFromString(refMethodName);
////    if ([_renderer respondsToSelector:selector]) {
////        markersArray = [_renderer performSelector:selector];
////    }else {
////
////    }
//
//    __block BOOL isFoundOutletMarker = NO;
//
//    for (GMSMarker *marker in markersArray) {
//        if ([marker.userData isKindOfClass:[DDMapClusterItem class]]) {
//            DDMapClusterItem *userData = marker.userData;
//            DDOutletM *tempOutlet = (DDOutletM*)userData.marker.markerData;
//            if (tempOutlet != nil && [tempOutlet.outlet_id isEqualToNumber:outlet.outlet_id]){
//                marker.icon = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:userData.marker.localPinSelectedImage];
//                // if image from api url exists
//                if (userData.marker.pinSelectedImage != nil && userData.marker.pinSelectedImage.length > 0){
//                    [self setMarkerImageFromURL:userData.marker.pinSelectedImage :marker];
//                }
//                GMSCameraPosition *newCamera =
//                    [GMSCameraPosition cameraWithTarget:userData.position zoom:self.camera.zoom];
//                [self setNewCameraPosition:newCamera];
//                self.previousSelectedMarker = marker;
//                isFoundOutletMarker = YES;
//                break;
//            }
//        }else if ([marker.userData conformsToProtocol:@protocol(GMUCluster)]) {
//            id<GMUCluster> userData = marker.userData;
//            // this is selected item
//            DDMapClusterItem *selectedMarker = [self getSelectedItemObject:userData.items:outlet];
//            if (selectedMarker != nil){
//                float zoom = 17.0;
//                if (zoom < previousZoomLevel){
//                    zoom =  previousZoomLevel;
//                }
//                if (self.camera.zoom >= 16.0){
//                    zoom = zoom + 1;
//                }
//                _selectedOutlet = outlet;
//                GMSCameraPosition *newCamera =
//                    [GMSCameraPosition cameraWithTarget:selectedMarker.position zoom:zoom];
//                [self setNewCameraPosition:newCamera];
//                isFoundOutletMarker = YES;
//                break;
//            }
//        }
//    }
//    if (!isFoundOutletMarker){
//        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(outlet.lat.doubleValue, outlet.lng.doubleValue);
//        if (CLLocationCoordinate2DIsValid(position)) {
//            _selectedOutlet = outlet;
//            GMSCameraPosition *newCamera =
//                [GMSCameraPosition cameraWithTarget:position zoom:20];
//            [self setNewCameraPosition:newCamera];
//        }
//
//    }
}

-(DDMapClusterItem*) getSelectedItemObject:(NSArray *)clusterItems : (id) outlet {
    DDMapClusterItem *selectedItem;
//    for (DDMapClusterItem *item in clusterItems)
//    {
//        DDOutletM *tempOutlet = (DDOutletM*)item.marker.markerData;
//        if (tempOutlet != nil && [tempOutlet.outlet_id isEqualToNumber:outlet.outlet_id]){
//            selectedItem = item;
//            break;
//        }
//    }
    return selectedItem;
}

- (void) resetSelectedMarker : (GMSMarker*) marker {
    DDMapMarker *thisMarker;
    DDMapClusterItem *userData = marker.userData;
    thisMarker = userData.marker;
    marker.icon = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:thisMarker.localPinImage];
    if (thisMarker.pinImage != nil && thisMarker.pinImage.length > 0){
        [self setMarkerImageFromURL:thisMarker.pinImage :marker];
    }
    [self setSelectedMarker:nil];
}

#pragma mark - Helper methods

// this method is being used to get most repeated category outlet in cluster of items
-(DDMapClusterItem*) getClusterMaxCategoryImage:(NSArray *)clusterItems {
    NSMutableArray *categories = [[NSMutableArray alloc] init];
    DDMapClusterItem *category;
    for (DDMapClusterItem *item in clusterItems)
    {
        [categories addObject:item.marker.category];
    }
    NSCountedSet *set = [[NSCountedSet alloc] initWithArray:categories];
    
    NSUInteger highest = 0;
    for (DDMapClusterItem *item in clusterItems)
    {
        if ([set countForObject:item.marker.category] > highest)
        {
            highest = [set countForObject:item.marker.category];
            category = item;
        }
    }
    return category;
}

- (void) setMarkerImageFromURL : (NSString*) urlString : (GMSMarker*) marker {
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:urlString] options:SDWebImageQueryMemoryData progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        marker.icon = image;
    }];
}

-(void) clearMapAllData {
    [self clear];
    
    // This shuffling is to release memory
//    self.mapType = kGMSTypeHybrid;
//    self.mapType = kGMSTypeNormal;
}

-(void) releaseAllData {
    [self.markers removeAllObjects];
    [previousMarkersList removeAllObjects];
    [self clearMapAllData];
}

-(void) reloadData:(BOOL)isClusteringEnable {
    if (isClusteringEnable){
        [self loadMapWithClusteredMarkers:self.markers isMapClear:YES];
    }else{
        [self loadMapWithMarkers:self.markers isMapClear:YES];
    }
}

// to show all app location pins on map
- (void) loadCountryMarkers {
    NSMutableArray *array = [[DDMapsManager shared] setMarkersDataFromLocations];
    [self loadMapWithMarkers:array isMapClear:YES];
    
}

-(CLLocationDistance)visibleRadiusMeters{
    CLLocationCoordinate2D centerCoordinate = [self centreOfMapView];
    CGPoint topCenterCoor = [self convertPoint:CGPointMake(0, 0)  fromView:self];
    CLLocationCoordinate2D topCenterCoordinate = [self.projection coordinateForPoint:topCenterCoor];
    
    CLLocation *centerLocation = [[CLLocation alloc]initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
    CLLocation * topCenterLocation = [[CLLocation alloc]initWithLatitude:topCenterCoordinate.latitude longitude:topCenterCoordinate.longitude];
    CLLocationDistance radius = [centerLocation distanceFromLocation:topCenterLocation];
    
    return radius;
}

- (CLLocationCoordinate2D) centreOfMapView  {
    return  [self.projection coordinateForPoint:self.center];
}

#pragma mark - ReDO Search
-(void)showRedoSearchView:(BOOL)show {
    if ([self.entGMapViewDelegate respondsToSelector:@selector(showHideRedoSearchView:)]) {
        [self.entGMapViewDelegate showHideRedoSearchView:YES];
    }
}
-(void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture {
    if (self.entGMapViewDelegate != nil && [self.entGMapViewDelegate respondsToSelector:@selector(mapView:willMove:)]) {
        [self.entGMapViewDelegate mapView:mapView willMove:gesture];
    }
}
@end
