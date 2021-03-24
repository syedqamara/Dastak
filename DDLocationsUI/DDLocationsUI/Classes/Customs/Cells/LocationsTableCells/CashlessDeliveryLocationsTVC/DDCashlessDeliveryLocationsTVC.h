//
//  DDCashlessDeliveryLocationsTVC.h
//  DDCashlessUI
//
//  Created by Awais Shahid on 13/02/2020.
//

#import <UIKit/UIKit.h>
#import "DDLocationsBaseTVC.h"
@import GooglePlaces;
@import GoogleMaps;

NS_ASSUME_NONNULL_BEGIN

@interface DDCashlessDeliveryLocationsTVC : DDLocationsBaseTVC
-(void)setPrediction:(GMSAutocompletePrediction*)prediction;
- (void)setAddress:(DDDeliveryAddressM *)adress;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *selectionButton;
@end

NS_ASSUME_NONNULL_END
