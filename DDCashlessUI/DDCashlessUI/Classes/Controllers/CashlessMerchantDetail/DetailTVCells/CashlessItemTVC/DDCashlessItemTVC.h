//
//  DDCashlessItemTVC.h
//  DDCashlessUI
//
//  Created by Syed Qamar Abbas on 16/03/2020.
//

#import "DDBaseTVC.h"
#import "DDModels.h"

NS_ASSUME_NONNULL_BEGIN

@class DDCashlessItemTVC;

@protocol DDCashlessItemTVCDelegate <NSObject>
-(void)didTapAddItemButton:(DDCashlessItemM *)item fromCell:(DDCashlessItemTVC *)cell;
-(void)didTapRemoveItemButton:(DDCashlessItemM *)item fromCell:(DDCashlessItemTVC *)cell;
@end

@interface DDCashlessItemTVC : DDBaseTVC
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *minusLabel;
@property (weak, nonatomic) IBOutlet UILabel *plusLabel;
@property (weak, nonatomic) IBOutlet UIView *minusContainerView;
@property (weak, nonatomic) IBOutlet UIView *plusContainerView;
@property (weak, nonatomic) IBOutlet UILabel *itemCountLabel;
@property (weak, nonatomic) IBOutlet UIView *actionsContainerView;
@property (weak, nonatomic) id<DDCashlessItemTVCDelegate> delegate;
- (IBAction)didTapMinusButton:(id)sender;
- (IBAction)didTapPlusButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
