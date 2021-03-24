//
//  DDSettingsTVC.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 23/07/2020.
//

#import "DDBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDSettingsTVC : DDBaseTVC
@property (weak, nonatomic) IBOutlet UIImageView *settingsImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *separatorView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *arrowImgView;

@end

NS_ASSUME_NONNULL_END
