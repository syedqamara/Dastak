//
//  DDRedemptionTVC.h
//  DDRedemptionsUI
//
//  Created by Hafiz Aziz on 25/02/2020.
//

#import "DDBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDRedemptionTVC : DDBaseTVC

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *logo_imgView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *title_label;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *category_label;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *dateTime_label;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnShare;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *iconImageContainerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *icon_imgView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *saving_label;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *reference_label;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *name_label;

@end

NS_ASSUME_NONNULL_END
