//
//  DDMerchantLockedOffersVC.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 19/03/2020.
//

#import "DDUIBaseViewController.h"
#import <DDUI/DDUI.h>
#import <DDModels/DDModels.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantLockedOffersVC : DDUIBaseViewController

@property (nonatomic, strong) IBOutlet UILabel *sectionTitle;
@property (nonatomic, strong) IBOutlet UIButton *btnCross;
@property (nonatomic, strong) IBOutlet UITableView *tblView;

@end

NS_ASSUME_NONNULL_END
