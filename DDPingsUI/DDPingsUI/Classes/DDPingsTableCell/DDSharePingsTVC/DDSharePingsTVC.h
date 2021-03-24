//
//  DDSharePingsTVC.h
//  DDPingsUI
//
//  Created by Hafiz Aziz on 24/01/2020.
//

#import "DDUIThemeTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDSharePingsTVC : DDUIThemeTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *sepratorView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *selectionImgView;
@end

NS_ASSUME_NONNULL_END
