//
//  DDFilterCheckboxCell.h
//  DDSearchUI
//
//  Created by Syed Qamar Abbas on 20/07/2020.
//

#import <UIKit/UIKit.h>
#import <DDUI/DDUI.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDFilterCheckboxCell : DDBaseTVC
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

NS_ASSUME_NONNULL_END
