//
//  DDProfileTVC.h
//  DDAccountsUI
//
//  Created by Syed Qamar Abbas on 27/01/2020.
//

#import "DDUIThemeTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDProfileTVC : DDUIThemeTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *seperatorView;

@end

NS_ASSUME_NONNULL_END
