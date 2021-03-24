//
//  DDPopupOptionTVC.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 06/06/2020.
//

#import "DDBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPopupOptionTVC : DDBaseTVC
@property (unsafe_unretained, nonatomic) IBOutlet UIView *leftView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *rightView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *titleLeftView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *titleRightView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *leftImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *rightImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *leftLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *rightLabel;
@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *leftWidthConstraint;
@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *rightWidthConstraint;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *separatorView;

@end

NS_ASSUME_NONNULL_END
