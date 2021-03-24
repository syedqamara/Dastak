//
//  DDMapCVC.h
//  DDMapsUI
//
//  Created by Zubair Ahmad on 11/02/2020.
//

#import <UIKit/UIKit.h>
#import <DDCommons/DDCommons.h>
#import <DDUI/DDUI.h>
#import "DDMapsThemeManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDMapCVC : DDUIThemeCollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *lockImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cuisinesLabel;
@end

NS_ASSUME_NONNULL_END
