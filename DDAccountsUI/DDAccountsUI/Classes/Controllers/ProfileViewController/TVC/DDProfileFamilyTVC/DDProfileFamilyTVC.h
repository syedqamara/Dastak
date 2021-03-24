//
//  DDProfileFamilyTVC.h
//  DDAccountsUI
//
//  Created by Syed Qamar Abbas on 27/01/2020.
//

#import "DDUIThemeTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDProfileFamilyTVC : DDUIThemeTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *savingsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *memberImageView;
@property (weak, nonatomic) IBOutlet UIView *seperatorView;

@end

NS_ASSUME_NONNULL_END
