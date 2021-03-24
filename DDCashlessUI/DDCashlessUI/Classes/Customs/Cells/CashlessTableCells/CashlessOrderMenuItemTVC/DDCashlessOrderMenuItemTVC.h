//
//  DDCashlessOrderMenuItemTVC.h
//  DDCashlessUI
//
//  Created by Syed Qamar Abbas on 15/04/2020.
//

#import "DDCashlessBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCashlessOrderMenuItemTVC : DDCashlessBaseTVC
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *optionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *optionPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorView;

@end

NS_ASSUME_NONNULL_END
