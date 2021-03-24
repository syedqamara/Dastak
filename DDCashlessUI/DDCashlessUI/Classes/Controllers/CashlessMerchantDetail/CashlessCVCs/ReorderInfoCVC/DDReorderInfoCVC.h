//
//  DDCashlessDeliveryInfoCVC.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 05/03/2020.
//

#import "DDUIThemeCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDReorderInfoCVC : DDUIThemeCollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *countLabelContainerView;
@property (weak, nonatomic) IBOutlet UIButton *reorderButton;
@end

NS_ASSUME_NONNULL_END
