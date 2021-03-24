//
//  DDLocationPermissionVC.h
//  DDLocationsUI
//
//  Created by Zubair Ahmad on 06/02/2020.
//

#import "DDUIBaseViewController.h"
#import "DDLocationsThemeManager.h"
#import <DDUI/DDUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDLocationPermissionVC : DDUIBaseViewController
@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UILabel *lblSubTitle;
@property (nonatomic, weak) IBOutlet UIButton *btnAccept;
@property (nonatomic, weak) IBOutlet UIButton *btnReject;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;


@end

NS_ASSUME_NONNULL_END
