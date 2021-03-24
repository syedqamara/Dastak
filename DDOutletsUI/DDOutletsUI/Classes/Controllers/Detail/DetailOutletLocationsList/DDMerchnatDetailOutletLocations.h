//
//  DDMerchnatDetailOutletLocations.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 16/03/2020.
//

#import "DDUIBaseViewController.h"
#import <DDUI/DDUI.h>
#import <DDModels/DDModels.h>
#import "DDMerchantOutletLocationViewM.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDMerchnatDetailOutletLocations : DDUIBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *merchantLogo;
@property (weak, nonatomic) IBOutlet UILabel *outletLocation;
@property (weak, nonatomic) IBOutlet UILabel *cuisineType;
@property (weak, nonatomic) IBOutlet UIView *searchBGView;
@property (weak, nonatomic) IBOutlet UIImageView *search_imageView;
@property (weak, nonatomic) IBOutlet UITextField *search_textField;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic, strong) DDOutletM *preSelected;

@end

NS_ASSUME_NONNULL_END
