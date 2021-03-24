//
//  DDOrderStatusTHFV.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/07/2020.
//

#import "DDBaseHFV.h"
#import "VBPieChart.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDOrderStatusTHFV : DDBaseHFV
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet VBPieChart *chartView;
@property (weak, nonatomic) IBOutlet UIImageView *centerImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

NS_ASSUME_NONNULL_END
