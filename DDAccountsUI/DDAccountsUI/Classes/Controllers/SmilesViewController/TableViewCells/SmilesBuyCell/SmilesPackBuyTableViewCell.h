//
//  SmilesPackBuyTableViewCell.h
//  DDAccountsUI
//
//  Created by M.Jabbar on 20/03/2020.
//

#import <UIKit/UIKit.h>
#import <DDUI/DDUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface SmilesPackBuyTableViewCell : DDBaseTVC
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIView *pointsView;
@property (weak, nonatomic) IBOutlet UIImageView *pointsImageView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

NS_ASSUME_NONNULL_END
