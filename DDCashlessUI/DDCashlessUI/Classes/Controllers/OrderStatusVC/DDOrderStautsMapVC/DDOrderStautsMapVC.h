//
//  DDOrderStautsMapVC.h
//  DDCashlessUI
//
//  Created by Zubair Ahmad on 18/05/2020.
//

#import "DDUIBaseViewController.h"
#import <DDUI/DDUI.h>
#import <DDModels/DDModels.h>
#import <DDMapsUI/DDMapsUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDOrderStautsMapVC : DDUIBaseViewController <DDGMapViewDelegate>

@property (weak, nonatomic) IBOutlet DDGMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *btnDirection;
@end

NS_ASSUME_NONNULL_END
