//
//  DDPurchaseProductsHistoryTableViewCell.h
//  DDProductsUI
//
//  Created by M.Jabbar on 26/03/2020.
//

#import <UIKit/UIKit.h>
#import <DDUI/DDUI.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDPurchaseProductsHistoryTableViewCell : DDBaseTVC
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *addonsLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *validLabel;
@property (weak, nonatomic) IBOutlet UIView *sideSliderView;
@property (weak, nonatomic) IBOutlet UILabel *purchaseTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *productCountLabel;

@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countContainerHeightConstraint;

@end

NS_ASSUME_NONNULL_END
