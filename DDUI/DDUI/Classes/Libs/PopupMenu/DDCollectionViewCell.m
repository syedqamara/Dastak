//
//  DDCollectionViewCell.m
//  dynamicdelivery_Example
//
//  Created by Syed Qamar Abbas on 06/02/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import "DDCollectionViewCell.h"
#import "DDCommons.h"
#import "UIFont+DDFont.h"
#import "LSAnimator.h"
@interface DDCollectionViewCell()
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation DDCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [UIFont DDMediumFont:11];
    self.titleLabel.textColor = UIColor.blackColor;
    self.backgroundColor = UIColor.clearColor;
    // Initialization code
}
-(void)setImageName:(NSString *)imageName {
    [self.imageView loadImageWithString:imageName forClass:self.class];
}
-(void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self resetCell];
}
-(void)resetCell {
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    self.transform = CGAffineTransformMakeTranslation(0, 1000);
    [UIView animateWithDuration:(self.index + 1) * 0.25 delay:0.0 usingSpringWithDamping:0.85 initialSpringVelocity:0.3 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:nil];
}
@end
