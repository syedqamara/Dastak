//
//  DDCategoryCVC.h
//  DDHomeUI
//
//  Created by Syed Qamar Abbas on 01/07/2020.
//

#import "DDBaseCVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCategoryCVC : DDBaseCVC
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;

@end

NS_ASSUME_NONNULL_END
