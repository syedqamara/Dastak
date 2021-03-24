//
//  DDMapViewController.h
//  DDMapsUI
//
//  Created by Zubair Ahmad on 10/02/2020.
//

#import "DDUIBaseViewController.h"
#import "DDGMapView.h"
#import "DDMapsManager.h"
#import <DDCommons/DDCommons.h>
#import <DDUI/DDUI.h>
#import <DDLocations/DDLocations.h>
#import "DDMapCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDMapViewControllerDelegate <NSObject>

-(void)didTapMapView;
@end

@interface DDMapViewController : DDUIBaseViewController

@property (weak, nonatomic) id<DDMapViewControllerDelegate> entMapViewControllerDelegate;
@property (weak, nonatomic) IBOutlet DDGMapView *mapView;

@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewTopConstraint;

@property (weak, nonatomic) IBOutlet UIView *noResultsView;
@property (weak, nonatomic) IBOutlet UILabel *noResultsLabel;

@property (weak, nonatomic) IBOutlet UIView *redoSearchView;
@property (weak, nonatomic) IBOutlet UILabel *redoSearchLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *redoSearchIndicator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redoSearchViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionContainerViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIView *collectionContainerView;
@property (weak, nonatomic) IBOutlet DDMapCollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIImageView *viewAllOffersImageView;
@property (weak, nonatomic) IBOutlet UILabel *viewAllOffersLabel;
@property (weak, nonatomic) IBOutlet UIView *viewAllOffersView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewAllOffersBottomConstraint;

@property (strong, nonatomic) NSMutableArray *outlets;

@property (assign, nonatomic) BOOL isMapViewShownInFullScreen;

//-(void)initLoadingDataFromAPI;
-(void)fetchListOfOutlets :(BOOL)showHUD callBack : (void (^)(NSMutableArray * _Nullable outlets))completion;
-(void)selectedCategoryOnHome:(id)category;
-(void)hideCollectionANDRedoSearchView;
@end

NS_ASSUME_NONNULL_END
