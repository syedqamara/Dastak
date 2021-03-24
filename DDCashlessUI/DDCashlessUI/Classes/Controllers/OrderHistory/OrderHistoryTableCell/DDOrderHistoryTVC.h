//
//  DDOrderHistoryTVC.h
//  DDCashlessUI
//
//  Created by Hafiz Aziz on 09/04/2020.
//

#import "DDBaseTVC.h"
#import <DDModels/DDModels.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDOrderHistoryTVC : DDBaseTVC

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *logo_imgView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *title_label;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *status_label;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *total_label;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *saving_label;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *dateTime_label;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *iconImageContainerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *icon_imgView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnReorder;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnViewOrder;

@property (nonatomic, copy) void (^buttonCallback)(DDOrderM * data , BOOL isreOrderSelected);
@end

NS_ASSUME_NONNULL_END
