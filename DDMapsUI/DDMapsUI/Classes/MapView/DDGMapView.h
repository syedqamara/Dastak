//
//  DDGMapView.h
//  DDUI
//
//  Created by Zubair Ahmad on 16/01/2020.
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DDLocations/DDLocations.h>
#import <DDCommons/DDCommons.h>
#import "DDMapsClusterHeaders.h"
#import "Autolayout.h"

NS_ASSUME_NONNULL_BEGIN

@class DDGMapView;
 
// Protocol to be use for map delegation
@protocol DDGMapViewDelegate <NSObject>

@optional
-(void)entGMapView:(DDGMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate;
-(void)entGMapView:(DDGMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position centre:(CLLocation*)centreLocation radius:(NSNumber*)radius;
-(BOOL)entGMapView:(DDGMapView *)mapView didTapMarker:(DDMapMarker *)marker;
-(void) didTapMapRecentreToUserCurrentLocation;
-(void) showHideRedoSearchView:(BOOL)isShow;
-(void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture;
@end

@interface DDGMapView : GMSMapView <GMSMapViewDelegate, GMUClusterManagerDelegate, GMUClusterRendererDelegate>

@property (weak, nonatomic) id<DDGMapViewDelegate> entGMapViewDelegate;

// contains data of all markers, will be render on map
@property (strong, nonatomic)  NSMutableArray <DDMapMarker*> *markers;

// either to show user location default icon on map
@property (assign, nonatomic) BOOL isMyLocationEnable;

// map camera zoom level, Default is 12
@property (strong, nonatomic) NSNumber *zoomLevel;

// If to restrict idle At Camera position call for very first time.
@property (assign, nonatomic) BOOL isFirstIdleCameraPositionToIgnore;

// flag to show collection view (card view) on top of the map (which outlet is tapped)
@property (assign, nonatomic) BOOL isMarkersCollectionViewEnable;

// If map is being used on Home, it will handle street, city and country levels.
@property (assign, nonatomic) BOOL isHomeViewMap;

@property (strong, nonatomic) GMSMarker *previousSelectedMarker;

// call this function with list of DDMapMarker to render all pins.
// If you want to show only one pin in centre, just add this in an array

-(void) loadMapWithSingleMarker : (DDMapMarker*) marker;

-(void) loadMapWithMarkers : (NSMutableArray <DDMapMarker*> *) markers isMapClear:(BOOL) clearMap;

-(void) loadMapWithClusteredMarkers : (NSMutableArray <DDMapMarker*> *) markers isMapClear:(BOOL) clearMap;

// If you want to set map center position
-(void) setMapCentrePosition :(CLLocation *)location ;

// To clear all map marker or annotations. Use this function
-(void) clearMapAllData;

// To remove all data from markers arrays and clear the map from all markers. Use this function
-(void) releaseAllData;

// To reload map data with previous datasource 
-(void) reloadData:(BOOL)isClusteringEnable;

// To reset selected marker state and it will deselect all markers from the map
-(void) resetSelectedMarker : (GMSMarker*) marker;

// To set marker on map on outlet selction base
-(void) setSelectedMarkerObject : (id) outlet;

// to change re centre button position in mapview
-(void)changeRecenterButtonConstraintsByConstant:(CGFloat)value ofType:(ConstraintType)type;

// To get the mapView visible area radius, in meters
-(CLLocationDistance)visibleRadiusMeters;

// To get the mapView centre coordinates
- (CLLocationCoordinate2D) centreOfMapView;
@end

NS_ASSUME_NONNULL_END
