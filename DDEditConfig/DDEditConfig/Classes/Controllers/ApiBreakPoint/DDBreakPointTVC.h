//
//  DDBreakPointTVC.h
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 24/04/2020.
//

#import "DDBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDBreakPointTVC : DDBaseTVC
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UISwitch *requestSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *responseSwitch;

@end

NS_ASSUME_NONNULL_END
