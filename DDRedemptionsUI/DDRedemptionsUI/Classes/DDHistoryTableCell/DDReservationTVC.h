//
//  DDReservationTVC.h
//  DDRedemptionsUI
//
//  Created by Hafiz Aziz on 19/02/2020.
//

#import "DDBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDReservationTVC : DDBaseTVC
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *logo_imgView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *title_label;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *status_label;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *info_label;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *dateTime_label;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *icon_imgView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *message_label;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnCall;

@end

NS_ASSUME_NONNULL_END
