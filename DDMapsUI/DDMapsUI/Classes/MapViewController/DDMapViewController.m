//
//  DDMapViewController.m
//  DDMapsUI
//
//  Created by Zubair Ahmad on 10/02/2020.
//

#import "DDMapViewController.h"
#import "DDMapsThemeManager.h"
#import "DDMapsUIConstants.h"
#import "DDMapsUIManager.h"

@interface DDMapViewController () <DDGMapViewDelegate, DDMapCollectionViewDelegate>
{
    DDBaseRequestModel *reqModelOutlets;
    BOOL isLoadMoreOutlets;
    BOOL dataStoredIsMapViewShownOnFullScreen;
}
@end

@implementation DDMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    reqModelOutlets = [[DDBaseRequestModel alloc] init];
    _outlets = [NSMutableArray new];
    [self hideNoResultsFoundView:YES];
    self.viewAllOffersBottomConstraint.constant = -200;
    [self setupMapView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGPoint point = self.mapView.center;
        point.y = point.y + 150;
        CLLocationCoordinate2D coordiantes =  [self.mapView.projection coordinateForPoint:point];
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:coordiantes.latitude longitude:coordiantes.longitude zoom:self.mapView.zoomLevel.integerValue];
        [self.mapView setCamera: camera];
    });
    [self designUI];
}

- (void)designUI {
    [super designUI];
    
    self.view.backgroundColor = DDMapsThemeManager.shared.selected_theme.bg_white.colorValue;
    self.redoSearchView.backgroundColor = DDMapsThemeManager.shared.selected_theme.app_theme.colorValue;
    self.redoSearchLabel.textColor = DDMapsThemeManager.shared.selected_theme.bg_white.colorValue;
    self.redoSearchLabel.font = [UIFont DDMediumFont:15];
    self.redoSearchLabel.text = [NSString stringWithFormat:@"%@",K_REDO_SEARCH_MESSAGE].localized;
    self.stackViewTopConstraint.constant = -200;
    self.collectionContainerViewHeightConstraint.constant = 0;
    self.redoSearchViewHeightConstraint.constant = 0;
    self.redoSearchView.cornerR = 10;
    self.redoSearchIndicator.hidden = YES;
    self.redoSearchIndicator.hidesWhenStopped = YES;
    self.redoSearchLabel.hidden = YES;
    self.collectionContainerView.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.cornerR = 10;
    self.collectionView.clipsToBounds = YES;
    
    self.noResultsView.backgroundColor = DDMapsThemeManager.shared.selected_theme.bg_white.colorValue;
    self.noResultsLabel.textColor = DDMapsThemeManager.shared.selected_theme.bg_red_39.colorValue;
    self.noResultsLabel.text = @"There aren't any available merchants in this specific area. Try broadening your search.".localized;
    
    self.viewAllOffersLabel.textColor = DDMapsThemeManager.shared.selected_theme.text_white.colorValue;
       self.viewAllOffersLabel.font = [UIFont DDBoldFont:17];
    self.viewAllOffersView.cornerR = 12;
       self.viewAllOffersView.backgroundColor = DDMapsThemeManager.shared.selected_theme.app_theme.colorValue;
       self.viewAllOffersImageView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icList"];
       self.viewAllOffersLabel.text = @"View All Offers".localized;
    
    [self.view layoutIfNeeded];
}

- (void) setupMapView {
    self.mapView.isFirstIdleCameraPositionToIgnore = YES;
    self.mapView.isMarkersCollectionViewEnable = YES;
    self.mapView.isHomeViewMap = YES;
    self.mapView.zoomLevel = @(14);
    self.mapView.entGMapViewDelegate = self;
    [self.mapView setMapCentrePosition:[[DDLocationsManager shared] userCurrentLocation]];
    self.collectionView.mapDelegate = self;
    self.isMapViewShownInFullScreen = NO;
}

-(BOOL) isMapViewShownInFullScreen {
    return dataStoredIsMapViewShownOnFullScreen;
}

-(void)setIsMapViewShownInFullScreen:(BOOL)isMapViewShownInFullScreen {
    dataStoredIsMapViewShownOnFullScreen = isMapViewShownInFullScreen;
    if (isMapViewShownInFullScreen) {
        self.viewAllOffersBottomConstraint.constant = 24;
        self.mapView.settings.scrollGestures = YES;
        self.mapView.settings.rotateGestures = YES;
        self.mapView.settings.zoomGestures = YES;
        self.mapView.settings.tiltGestures = YES;
    }else{
        self.viewAllOffersBottomConstraint.constant = -200;
        self.mapView.settings.scrollGestures = NO;
        self.mapView.settings.rotateGestures = NO;
        self.mapView.settings.zoomGestures = NO;
        self.mapView.settings.tiltGestures = NO;
    }
    if (_outlets.count <= 0){
        [self hideNoResultsFoundView:NO];
    }
}

#pragma mark - Map View Data loading

-(void)fetchListOfOutlets :(BOOL)showHUD callBack: (void (^)(NSMutableArray * _Nullable outlets)) completion {
    [self.mapView setMapCentrePosition:[[DDLocationsManager shared] userCurrentLocation]];
    [self.outlets removeAllObjects];
    [self.mapView releaseAllData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadMapData:showHUD:completion];
    });
}

-(void)selectedCategoryOnHome:(id)category {
//    if ([reqModelOutlets.category isEqualToString:category.api_name]){
//        return;
//    }
//    reqModelOutlets.category = category.api_name;
    self.redoSearchViewHeightConstraint.constant = 35;
    [self didTapReDoSearchAction:nil];
}

- (void) loadMapData : (BOOL) showLoader : (void (^)(NSMutableArray * _Nullable outlets))completion {
    [self hideNoResultsFoundView:YES];
    [self gtMapCentreAndRadius];
//    reqModelOutlets.billing_country = nil;
    [[DDMapsManager shared] fetchListOfOutlets:reqModelOutlets showLoader:showLoader andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id outletModel = model;
            if (outletModel != nil){
                dispatch_time_t stopAnimationTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC));
                dispatch_after(stopAnimationTime, dispatch_get_main_queue(), ^(void){
                    self->isLoadMoreOutlets = YES;
                    NSMutableArray * newOutlets;
                    if (newOutlets == nil){
                        newOutlets = [NSMutableArray new];
                    }
                    [self loadMapWithMarkers:newOutlets];
                    if (completion){
                        completion(newOutlets);
                    }
                });
            }else{
                if (completion){
                    completion([NSMutableArray new]);
                }
                [self hideNoResultsFoundView:NO];
            }
        }else{
            if (completion){
                completion([NSMutableArray new]);
            }
            [self hideNoResultsFoundView:NO];
            [self showHideRedoSearchView:NO];
        }
    }];
}

- (void) gtMapCentreAndRadius  {
    CLLocationCoordinate2D centerCoordinate = [self.mapView centreOfMapView];
}

- (void) loadMapDataFromReDoSearchAction {
    [_outlets removeAllObjects];
    [self.mapView releaseAllData];
    self.redoSearchLabel.hidden = YES;
    self.redoSearchIndicator.hidden = NO;
    [self.redoSearchIndicator startAnimating];
    [self loadMapData:NO:nil];
}

-(void) loadMapWithMarkers : (NSMutableArray  *) newOutlets {
    if (newOutlets.count < 1){
        isLoadMoreOutlets = NO;
    }
    if (_outlets.count <= 0){
        _outlets = newOutlets.mutableCopy;
    }else{
        
    }
    self.collectionView.outlets = _outlets;
    [self.collectionView reloadData];
    
    [self showHideRedoSearchView:NO];
//    self.mapView.isFirstIdleCameraPositionToIgnore = YES;
    [self.mapView loadMapWithClusteredMarkers:[[DDMapsManager shared] setMarkersData:newOutlets] isMapClear:YES];
    if (_outlets.count <= 0){
        [self hideNoResultsFoundView:NO];
    }else{
        [self hideNoResultsFoundView:YES];
    }
}

#pragma mark - button actions

- (IBAction)didTapReDoSearchAction:(UIButton*)sender {
    self.collectionContainerViewHeightConstraint.constant = 0;
    [self.view layoutIfNeeded];
    [self loadMapDataFromReDoSearchAction];
}

- (IBAction)didTapViewAllOffres:(UIButton*)sender {
    DDBaseRequestModel *model = [[DDBaseRequestModel alloc] init];
    [[DDMapsUIManager shared] showOutletsListingFrom:self withReqModel:model andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
    }];
}

#pragma mark - Map View Delegates

-(void)entGMapView:(DDGMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    if ([self.entMapViewControllerDelegate respondsToSelector:@selector(didTapMapView)]) {
        [self.entMapViewControllerDelegate  didTapMapView];
    }
    
}
-(BOOL)entGMapView:(DDGMapView *)mapView didTapMarker:(DDMapMarker *)marker {
    
    return YES;
}

-(void)entGMapView:(DDGMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position centre:(CLLocation *)centreLocation radius:(NSNumber *)radius {
}

#pragma mark - CollectionView Delegates

- (void) didSelectCollectionViewCellWithOutlet:(id)outlet {
    [[DDMapsUIManager shared] showMerchantDetailsFrom:self withOutlet:outlet andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
    }];    
}

- (void) didHiglightMapPinWithOutlet:(id)outlet {
    [self.mapView resetSelectedMarker:self.mapView.previousSelectedMarker];
    [self.mapView setSelectedMarkerObject:outlet];
}

#pragma mark - View UI/UX accessory methods

- (void) showHideRedoSearchView:(BOOL)isShow {
    if (!self.isMapViewShownInFullScreen){
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            self.stackViewTopConstraint.constant = isShow ? 20 : -200;
            if (isShow){
                self.redoSearchViewHeightConstraint.constant = 35;
                self.redoSearchLabel.hidden = NO;
                [self.redoSearchIndicator stopAnimating];
                self.redoSearchIndicator.hidden = YES;
            }else{
                self.redoSearchViewHeightConstraint.constant = 0;
                [self.redoSearchIndicator stopAnimating];
                self.redoSearchIndicator.hidden = YES;
            }
            [self.view layoutIfNeeded];
        }];
    });
}

- (void) showCollectionViewForSelectedOutlet:(id)outlet {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            self.stackViewTopConstraint.constant = 20;
            self.collectionContainerViewHeightConstraint.constant = 76;
            [self.collectionView layoutSubviews];
            [self.view layoutIfNeeded];
            [self.collectionView reloadData];
            [self.collectionView selectOutlet:outlet];
        }];
    });
}

-(void)hideCollectionANDRedoSearchView {
    [self.redoSearchIndicator stopAnimating];
    self.redoSearchIndicator.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.stackViewTopConstraint.constant =  -200;
        self.collectionContainerViewHeightConstraint.constant = 0;
        self.redoSearchViewHeightConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (void) hideNoResultsFoundView : (BOOL) isHide {
    
    if (!isHide){
        if (self.isMapViewShownInFullScreen){
            self.viewAllOffersBottomConstraint.constant = self.noResultsView.frame.size.height+10;
        }
    }else{
        if (self.isMapViewShownInFullScreen){
            self.viewAllOffersBottomConstraint.constant = 24;
        }
    }
    
    self.noResultsView.hidden = isHide;
}

@end
