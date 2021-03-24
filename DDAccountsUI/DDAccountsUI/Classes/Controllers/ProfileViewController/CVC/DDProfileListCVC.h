//
//  DDProfileListCVC.h
//  DDAccountsUI
//
//  Created by Syed Qamar Abbas on 27/01/2020.
//

#import "DDUIThemeCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDProfileListCVC : DDUIThemeCollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *amountLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *accessoryImageView;

@end

NS_ASSUME_NONNULL_END
