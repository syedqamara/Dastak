//
//  DDSearchDishesTVC.h
//  DDSearchUI
//
//  Created by Syed Qamar Abbas on 05/07/2020.
//

#import "DDBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDSearchDishesTVC : DDBaseTVC
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *nameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *outletNameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *priceLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *dishImageView;

@end

NS_ASSUME_NONNULL_END
