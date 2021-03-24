//
//  DDOutletsLAttributeCVC.h
//  DDHomeUI
//
//  Created by Zubair Ahmad on 30/01/2020.
//

#import "DDUIThemeCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDOutletsLAttributeCVC : DDUIThemeCollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *featuredLabel;
@end

NS_ASSUME_NONNULL_END
